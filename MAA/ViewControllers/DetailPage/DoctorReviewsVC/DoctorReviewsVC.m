//
//  DoctorReviewsVC.m
//  MAA
//
//  Created by Cocoalabs India on 31/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "DoctorReviewsVC.h"

@interface DoctorReviewsVC ()<UITableViewDataSource,UIScrollViewDelegate,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *reviewsMutableArray;
@property (nonatomic, assign) int startIndex;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@end

@implementation DoctorReviewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self callinggetEntityReviewssApi];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.reviewsMutableArray = [[NSMutableArray alloc] init];
    self.startIndex = 0;
    self.limitValue = 10;
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

#pragma mark - Table view Datasources 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reviewsMutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Review Content:%@",[self.reviewsMutableArray objectAtIndex:indexPath.row]);
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReviews"forIndexPath:indexPath];
    cell.profilImageurlString = [[self.reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"patient_image"];
    cell.reviewerNameLabel.text =[[self.reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"patient_name"];
    cell.reviewContentLabel.text = [[self.reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"review"];
    cell.dateString = [[self.reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.ratingString = [[self.reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
#pragma maRK - Calling get Entity Reviews Api

-(void)callinggetEntityReviewssApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *getEntityReviewsUrlString = [Baseurl stringByAppendingString:GetEntityReviewsurl];
    NSMutableDictionary *getEntityReviewsmutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityReviewsmutableDictionary setValue:accessToken forKey:@"token"];
    [getEntityReviewsmutableDictionary setValue:self.entityId forKey:@"id"];
    [getEntityReviewsmutableDictionary setValue:@"for" forKey:@"type"];
    [getEntityReviewsmutableDictionary setValue:[NSNumber numberWithInt:self.startIndex] forKey:Offsetkey];
    [getEntityReviewsmutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    if(self.startIndex == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityReviewsUrlString] withBody:getEntityReviewsmutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        [self.bottomProgressIndicatorView stopAnimating];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.startIndex=self.startIndex+self.limitValue;
        NSArray *reviewArray = [responseObject valueForKey:Datakey];
        [self.reviewsMutableArray addObjectsFromArray:reviewArray];
        [self.reviewsTableView reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"Error Description:%@",errorResponse);
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
    }];
    
}

#pragma makr - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (endScrolling >= scrollView.contentSize.height)
    {
        [self callinggetEntityReviewssApi];
         [self.bottomProgressIndicatorView startAnimating];
    }
    else{
        [self.bottomProgressIndicatorView stopAnimating];
    }
}


@end
