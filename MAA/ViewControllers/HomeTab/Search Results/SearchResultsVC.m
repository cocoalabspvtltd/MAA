//
//  SearchResultsVC.m
//  MAA
//
//  Created by Roshith on 14/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "DoctorProfVC.h"
#import "ClinicProfVC.h"
#import "SearchFilterVC.h"

#import "SearchResultsVC.h"
#import "SearchResultsTVC.h"

@interface SearchResultsVC ()<UIScrollViewDelegate,UISearchBarDelegate,SearchFilterVCDelegate>
@property (nonatomic, strong) NSArray *doctorsArray;
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSMutableArray *doctorsMutableArray;
@property (nonatomic, strong) NSArray *onlineDoctorsArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, assign) BOOL isOnlineButtonSelected;

@property (nonatomic, strong) id selectedSearchTypeDetails;
@property (nonatomic, assign) BOOL isSortbyExperience;
@property (nonatomic, assign) BOOL IsSortByFee;
@property (nonatomic, strong) NSArray *availabilityArray;
@property (nonatomic, strong) id selectedsearchCategoryDetails;
@property (nonatomic, strong) NSArray *feeArray;
@property (nonatomic, strong) NSArray *ageArray;
@property (nonatomic, strong) NSString *searchGander;
@property (nonatomic, strong) NSArray *experienceArray;

@end

@implementation SearchResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customisation];
    [self addSubViews];
    [self callingSearchapi];
    if([self.selectedLocationDetail valueForKey:@"location"]){
        self.locationLabel.text = [self.selectedLocationDetail valueForKey:@"location"];
        self.headingLabel.text = [NSString stringWithFormat:@"%@ in %@",[self.selectedDepartmentDetails valueForKey:@"name"],[self.selectedLocationDetail valueForKey:@"location"]];
    }
    else{
        self.locationLabel.text = @"All";
        self.headingLabel.text = [self.selectedDepartmentDetails valueForKey:@"name"];
    }
    
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.isOnlineButtonSelected = NO;
    self.doctorsMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    self.isSortbyExperience = NO;
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
    if(self.isOnlineButtonSelected){
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
    cell.cellImageViewIcon.layer.cornerRadius = 30.00;
    cell.cellImageViewIcon.layer.masksToBounds = YES;
    cell.cellImageViewIcon.layer.borderWidth=0.5f;
    cell.cellImageViewIcon.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    cell.cellImageViewOnlineStatus.clipsToBounds = YES;
    cell.cellImageViewOnlineStatus.layer.cornerRadius = 5.00;
    cell.cellImageViewOnlineStatus.layer.masksToBounds = YES;
    NSURL *imageUrl;
    if(self.isOnlineButtonSelected){
        cell.cellLabelTitle.text = [NSString stringWithFormat:@"%@",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
       cell.cellLabelRating.text = [[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
       NSString *doctorDescription = [NSString stringWithFormat:@"%@ | %@",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"tagline"],[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"location"]];
        cell.cellLabelDescription.text = doctorDescription;
        cell.cellLabelConsultFee.text = [NSString stringWithFormat:@"Rs.%@ consultation fee",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"fee"]];
        cell.cellLabelExperience.text = [NSString stringWithFormat:@"%@",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"experience"]];
        cell.cellImageViewOnlineStatus.backgroundColor = [UIColor greenColor];
        imageUrl = [NSURL URLWithString:[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"logo_image"]];
    }
    else{
        cell.cellLabelRating.text = [[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
        if([[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"1"]){
           cell.cellLabelTitle.text = [NSString stringWithFormat:@"%@",[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
        }
        else{
          cell.cellLabelTitle.text = [NSString stringWithFormat:@"%@",[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
        }
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
        imageUrl = [NSURL URLWithString:[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"logo_image"]];
    }
    [cell.cellImageViewIcon sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSLog(@"DWFDBHAD:%@",[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"type"]);
    if(self.isOnlineButtonSelected){
        if([[[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"doctor"]){
            DoctorProfVC *doctorPfofileVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorProfVC"];
            doctorPfofileVC.entityId = [[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            [self.navigationController pushViewController:doctorPfofileVC animated:YES];
        }
        else{
            ClinicProfVC *clinicProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"ClinicProfVC"];
            clinicProfileVC.entityId = [[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            [self.navigationController pushViewController:clinicProfileVC animated:YES];
        }
       
    }
    else{
        if([[[self.doctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"doctor"]){
            DoctorProfVC *doctorPfofileVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorProfVC"];
            doctorPfofileVC.entityId = [[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            [self.navigationController pushViewController:doctorPfofileVC animated:YES];
        }
        else{
            ClinicProfVC *clinicProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"ClinicProfVC"];
            clinicProfileVC.entityId = [[self.onlineDoctorsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            [self.navigationController pushViewController:clinicProfileVC animated:YES];
        }

    }
}

-(void)callingSearchapi{
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSString *searchUrlString = [Baseurl stringByAppendingString:SearchApi];
    NSString *accesToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [searchMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [searchMutableDictionary setValue:accesToken forKey:@"token"];
    [searchMutableDictionary setValue:self.experienceArray forKey:@"experience"];
    [searchMutableDictionary setValue:self.feeArray forKey:@"fee"];
    [searchMutableDictionary setValue:self.availabilityArray forKey:@"availability"];
    [searchMutableDictionary setValue:[NSNumber numberWithBool:self.isOnlineButtonSelected] forKey:@"status"];
    [searchMutableDictionary setValue:self.searchGander forKey:@"gender"];
    [searchMutableDictionary setValue:[self.selectedSearchTypeDetails valueForKey:@"value"] forKey:@"type"];
    [searchMutableDictionary setValue:self.ageArray forKey:@"age"];
    if([self.selectedsearchCategoryDetails valueForKey:@"name"]){
        self.selectedDepartmentDetails = self.selectedsearchCategoryDetails;
    }
    [searchMutableDictionary setValue:[self.selectedDepartmentDetails valueForKey:@"id"] forKey:@"dept_id"];
    [searchMutableDictionary setValue:[self.selectedLocationDetail valueForKey:@"location_id"] forKey:@"location_id"];
    [searchMutableDictionary setValue:[NSNumber numberWithBool:self.isSortbyExperience] forKey:@"s_exp"];
     [searchMutableDictionary setValue:[NSNumber numberWithBool:self.IsSortByFee] forKey:@"s_fee"];

    //if(self.isLocationSearch){
    
    //}
    //else{
    
    //}
    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:searchUrlString] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.doctorsArray = [responseObject valueForKey:Datakey];
        self.offsetValue=self.offsetValue+self.limitValue;
        [self.bottomProgressIndicatorView stopAnimating];
        [self.doctorsMutableArray addObjectsFromArray:self.doctorsArray];
        NSPredicate *onlineDoctorsPredicate = [NSPredicate predicateWithFormat:@"SELF.is_online == %@",@"1"];
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

- (IBAction)segmentControlAction:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0){
        self.isOnlineButtonSelected = NO;
        [self.doctorsMutableArray removeAllObjects];
        self.offsetValue = 0;
        [self callingSearchapi];
       // [tableViewSearchResults reloadData];
    }
    else{
        self.isOnlineButtonSelected = YES;
        [self.doctorsMutableArray removeAllObjects];
        self.offsetValue = 0;
        [self callingSearchapi];
       // [tableViewSearchResults reloadData];
    }
}

#pragma mark - Search Bar Delegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)filterButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    SearchFilterVC *searchFilterVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchFilterVC"];
    searchFilterVC.searchFilterDelagate = self;
    searchFilterVC.selectedDepartmentDetails = self.selectedDepartmentDetails;
    searchFilterVC.selectedType = self.selectedSearchTypeDetails;
    searchFilterVC.sortBasedOnFee = self.IsSortByFee;
    searchFilterVC.sortBasedOnExperience = self.isSortbyExperience;
    searchFilterVC.selectedAvailabltyDateArray = [[NSMutableArray alloc] initWithArray:self.availabilityArray];
    searchFilterVC.selectedCategory = self.selectedsearchCategoryDetails;
    [self presentViewController:searchFilterVC animated:YES completion:nil];
}

#pragma mark - Search FilterVC Delegate

-(void)submitButtonActionWithType:(id)filterType andWhetherSortbyExperience:(BOOL)isSortByExperience andwhetherSortByConsultationFee:(BOOL)whetherConsultFee andAvailabilityArra:(NSMutableArray *)availabilityArray andCategory:(id)categoryDetails andFeeDetails:(NSArray *)feeDetail andAgeDetail:(NSArray *)ageDetail andGenderDetail:(id)genderDetails andExperienceDetail:(NSArray *)experienceDetail{
    self.selectedSearchTypeDetails = filterType;
    self.isSortbyExperience  = isSortByExperience;
    self.IsSortByFee = whetherConsultFee;
    self.availabilityArray = availabilityArray;
    self.selectedsearchCategoryDetails = categoryDetails;
    self.feeArray = feeDetail;
    self.ageArray = ageDetail;
    self.searchGander = [genderDetails valueForKey:@"value"];
    self.experienceArray = experienceDetail;
    self.offsetValue = 0;
    [self.doctorsMutableArray removeAllObjects];
    [self callingSearchapi];
    
}
@end
