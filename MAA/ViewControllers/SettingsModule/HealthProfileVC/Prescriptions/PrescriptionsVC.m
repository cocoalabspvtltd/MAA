//
//  PrescriptionsVC.m
//  MAA
//
//  Created by Cocoalabs India on 21/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#define PrescriptionsTableViewCellIdentifier @"prescriptionsReusableCell"
#import "PrescriptionsVC.h"
#import "PrescriptionsTVC.h"

@interface PrescriptionsVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *prescriptionsmutableArray;
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, assign) BOOL isTextSearchValueChanged;
@end

@implementation PrescriptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self addSubViews];
    [self callingGetPrescriptionsApi];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.searchText = @"";
    self.offsetValue = 0;
    self.limitValue = 1;
    self.isTextSearchValueChanged = NO;
    _prescriptionsmutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)addSubViews{
    [self.view addSubview:self.bottomProgressIndicatorView];
}
-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = searchText;
    self.offsetValue = 0;
    self.isTextSearchValueChanged = YES;
    [self.prescriptionsmutableArray removeAllObjects];
    [self callingGetPrescriptionsApi];
    
}

#pragma mark - Table view Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.prescriptionsmutableArray.count == 0){
        self.noImagesView.hidden = NO;
    }
    else{
        self.noImagesView.hidden = YES;
    }
    return self.prescriptionsmutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PrescriptionsTVC *prescriptionsTableViewCell = [tableView dequeueReusableCellWithIdentifier:PrescriptionsTableViewCellIdentifier forIndexPath:indexPath];
    return prescriptionsTableViewCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Get Prescriptions Api

-(void)callingGetPrescriptionsApi{
    NSString *getPrescriptionsApiUrlString = [Baseurl stringByAppendingString:GetPrescriptionsUrl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getPrescriptionssMutableDictionary = [[NSMutableDictionary alloc] init];
    [getPrescriptionssMutableDictionary setValue:accessToken forKey:@"token"];
    [getPrescriptionssMutableDictionary setValue:self.searchText forKey:@"keyword"];
    [getPrescriptionssMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getPrescriptionssMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getPrescriptionsApiUrlString] withBody:getPrescriptionssMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        
        self.offsetValue = self.offsetValue+self.limitValue;
        [self.bottomProgressIndicatorView stopAnimating];
        NSArray *imagesArray = [responseObject valueForKey:Datakey];
        NSLog(@"Images :%@",imagesArray);
        if(self.isTextSearchValueChanged){
            [self.prescriptionsmutableArray removeAllObjects];
        }
        [self.prescriptionsmutableArray addObjectsFromArray:imagesArray];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.prescriptionsTableView reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [self.bottomProgressIndicatorView stopAnimating];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:AppName message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
        NSLog(@"Error :%@",errorResponse);
    }];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.prescriptionsTableView){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            self.isTextSearchValueChanged = NO;
            [self callingGetPrescriptionsApi];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}

@end
