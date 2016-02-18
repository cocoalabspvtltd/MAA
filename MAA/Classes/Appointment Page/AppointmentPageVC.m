//
//  AppointmentPageVC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "AppointmentTVC.h"
#import "AppointmentPageVC.h"


@interface AppointmentPageVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSString *searchTextString;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, strong) NSMutableArray *appointmentDoctorsMutableArray;
@property (nonatomic, strong) NSArray *appointmentDoctorsArray;
@end

@implementation AppointmentPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customisation];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)initialisation{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.appointmentDoctorsMutableArray = [[NSMutableArray alloc] init];
}

-(void)customisation{
    
}

-(void)addSubViews{
    
}


-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.appointmentDoctorsMutableArray removeAllObjects];
    self.offsetValue = 0;
    [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:searchText];
    NSLog(@"Search Text:%@",searchText);
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.appointmentDoctorsMutableArray removeAllObjects];
    self.offsetValue = 0;
     [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:@""];
}
#pragma mark - Table View Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appointmentDoctorsMutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentTVC *appointmentTableViewCell =  [tableView dequeueReusableCellWithIdentifier:@"appointmentCell"forIndexPath:indexPath];
    appointmentTableViewCell.doctorNameLabel.text = [[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Category"];
//    NSString *imageUrlString =  [[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"logo_image"];
//    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    NSURL *imageUrl = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/en/4/4e/Tis_The_Season_To_Be_Fearless_Cover.jpg"];
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:[[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"id"]];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:appointmentTableViewCell.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:[[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"id"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                appointmentTableViewCell.profileImageView.image = tempImage;
                [MBProgressHUD hideAllHUDsForView:appointmentTableViewCell.profileImageView animated:YES];
            }
                           );
        });
    }
    else{
        appointmentTableViewCell.profileImageView.image = localImage;
    }
    return appointmentTableViewCell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)closeButtonAction:(UIButton *)sender {
}

#pragma mark - Calling Search Doctor Names Api


-(void)getSearchDoctorNamesForAppointmentesApiCallWithSearchText:(NSString *)keywordText{
    self.searchTextString = keywordText;
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSLog(@"Access Token:%@",accessToken);
    NSString *getDoctorsAppointmentsUrlString = [Baseurl stringByAppendingString:GetUserAppointmentesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:keywordText forKey:@"keyword"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    NSLog(@"Get Sub categories mutable Dictionary:%@",getSubcategoriesMutableDictionary);
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getDoctorsAppointmentsUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        self.appointmentDoctorsArray = [responseObject valueForKey:Datakey];
        self.offsetValue=self.offsetValue+self.limitValue;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.bottomProgressIndicatorView stopAnimating];
        [self.appointmentDoctorsMutableArray addObjectsFromArray:self.appointmentDoctorsArray];
        [self.appointmentTableView reloadData];
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
    }];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.appointmentTableView){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:self.searchTextString];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}


@end
