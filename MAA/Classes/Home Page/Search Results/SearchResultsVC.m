//
//  SearchResultsVC.m
//  MAA
//
//  Created by Roshith on 14/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//
#define OnlineAllButtonSelectedBorderColor [UIColor whiteColor].CGColor

#import "DoctorProfileVC.h"
#import "SearchResultsVC.h"
#import "SearchResultsTVC.h"

@interface SearchResultsVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *doctorsArray;
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSMutableArray *doctorsMutableArray;
@property (nonatomic, strong) NSArray *onlineDoctorsArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, assign) BOOL isOnlineButtonSelected;
@end

@implementation SearchResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customisation];
    [self addSubViews];
    [self callingSearchapi];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.isOnlineButtonSelected = NO;
    self.allButton.layer.borderColor = OnlineAllButtonSelectedBorderColor;
    self.doctorsMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)customisation{
    
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

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
    
}


#pragma mark - UITableView Delegate & Data Source methods.


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.onlineButton isSelected]){
        return self.onlineDoctorsArray.count;
    }
    else{
        return self.doctorsMutableArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultsTVC *cell = [tableViewSearchResults dequeueReusableCellWithIdentifier:@"cellSearchResults"forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cellImageViewIcon.clipsToBounds = YES;
    cell.cellImageViewIcon.layer.cornerRadius = 25.00;
    cell.cellImageViewIcon.layer.masksToBounds = YES;
    
    cell.cellImageViewOnlineStatus.clipsToBounds = YES;
    cell.cellImageViewOnlineStatus.layer.cornerRadius = 5.00;
    cell.cellImageViewOnlineStatus.layer.masksToBounds = YES;
    if([self.onlineButton isSelected]){
        cell.cellLabelRating.text = [[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
        cell.cellLabelTitle.text = [NSString stringWithFormat:@"Dr. %@",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
        NSString *doctorDescription = [NSString stringWithFormat:@"%@ | %@",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"tagline"],[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"location"]];
        cell.cellLabelDescription.text = doctorDescription;
        cell.cellLabelConsultFee.text = [NSString stringWithFormat:@"Rs.%@ consultation fee",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"fee"]];
        cell.cellLabelExperience.text = [NSString stringWithFormat:@"%@ Years",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"experience"]];
        if([[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"is_online"] isEqualToString:@"1"]){
            cell.cellImageViewOnlineStatus.backgroundColor = [UIColor greenColor];
        }
        else{
            cell.cellImageViewOnlineStatus.backgroundColor = [UIColor grayColor];
        }
 
    }
    else{
        cell.cellLabelRating.text = [[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
        cell.cellLabelTitle.text = [NSString stringWithFormat:@"Dr. %@",[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
        NSString *doctorDescription = [NSString stringWithFormat:@"%@ | %@",[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"tagline"],[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"location"]];
        cell.cellLabelDescription.text = doctorDescription;
        cell.cellLabelConsultFee.text = [NSString stringWithFormat:@"Rs.%@ consultation fee",[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"fee"]];
        cell.cellLabelExperience.text = [NSString stringWithFormat:@"%@",[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"experience"]];
        if([[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"is_online"] isEqualToString:@"1"]){
            cell.cellImageViewOnlineStatus.backgroundColor = [UIColor greenColor];
        }
        else{
            cell.cellImageViewOnlineStatus.backgroundColor = [UIColor grayColor];
        }
    }
       return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DoctorProfileVC *doctorPfofileVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorProfileVC"];
    doctorPfofileVC.entityId = [[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:doctorPfofileVC animated:YES];
}

-(void)callingSearchapi{
    NSLog(@"Departmentid:%@",self.departmentId);
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSString *searchUrlString = [Baseurl stringByAppendingString:SearchApi];
    NSString *accesToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [searchMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [searchMutableDictionary setValue:accesToken forKey:@"token"];
    if(self.isLocationSearch){
        [searchMutableDictionary setValue:self.locationId forKey:@"location_id"];
    }
    else{
        [searchMutableDictionary setValue:self.departmentId forKey:@"dept_id"];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:searchUrlString] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.doctorsArray = [responseObject valueForKey:Datakey];
        self.offsetValue=self.offsetValue+self.limitValue;
        [self.bottomProgressIndicatorView stopAnimating];
        [self.doctorsMutableArray addObjectsFromArray:self.doctorsArray];
        NSPredicate *onlineDoctorsPredicate = [NSPredicate predicateWithFormat:@"SELF.is_online == 1"];
        self.onlineDoctorsArray = [self.doctorsMutableArray filteredArrayUsingPredicate:onlineDoctorsPredicate];
        [tableViewSearchResults reloadData];
        NSLog(@"Response object:%@",responseObject);
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.bottomProgressIndicatorView stopAnimating];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == tableViewSearchResults){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self callingSearchapi];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}
- (IBAction)allButtonAction:(UIButton *)sender {
    self.isOnlineButtonSelected = NO;
    sender.layer.borderColor = OnlineAllButtonSelectedBorderColor;
    self.onlineButton.layer.borderColor = [UIColor clearColor].CGColor;
    [tableViewSearchResults reloadData];
}

- (IBAction)onlineButtonAction:(UIButton *)sender {
    self.isOnlineButtonSelected = YES;
    sender.layer.borderColor = OnlineAllButtonSelectedBorderColor;
    self.allButton.layer.borderColor = [UIColor clearColor].CGColor;
    [tableViewSearchResults reloadData];
}

@end
