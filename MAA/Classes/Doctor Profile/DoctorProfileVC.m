//
//  DoctorProfileVC.m
//  MAA
//
//  Created by kiran on 02/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define SeparatorTabViewSelectedBackGroundColor [UIColor redColor]
#define SeparatorTabViewUnSelectedBackGroundColor [UIColor lightGrayColor]


#import "DoctorProfileVC.h"
#import "DoctorFirstTabTVC.h"
#import "DoctorThirdTabTVC.h"
#import "DoctorServicesHV.h"
#import "DoctorServicesTVC.h"
#import "DoctorConsultingTimingTVC.h"

@interface DoctorProfileVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,DoctorServicesDelegate>
@property (nonatomic, assign) BOOL isFirstTabSelected;
@property (nonatomic, assign) BOOL isSecondTabSelected;
@property (nonatomic, assign) BOOL isThirdTabSelected;
@property (nonatomic, strong) NSArray *clinicDetailsArray;
@property (nonatomic, strong) NSArray *reviewArray;
@property (nonatomic, assign) NSUInteger selectedService;
@property (nonatomic, strong) NSArray *servicesArray;
@end

@implementation DoctorProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customisation];
    [self addSubViews];
    [self callingGetDoctorDetailsApi];
     [self.doctoDetailsTableView registerNib:[UINib nibWithNibName:@"DoctorServicesTVC" bundle:nil] forCellReuseIdentifier:@"cellServics"];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.selectedService  = -1;
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.isFirstTabSelected = YES;
    self.isSecondTabSelected = NO;
    self.isThirdTabSelected = NO;
    self.doctoDetailsTableView.bounces = NO;
   // self.servicesArray = [NSArray arrayWithObjects:@"SERVICES",@"SPECIALIZATION",@"MEMEBERSHIP",@"QUALITY", nil];
}

-(void)customisation{
    
}

-(void)addSubViews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Entity Details Api

-(void)callingGetDoctorDetailsApi{
    NSLog(@"Get Doctor Id;%@",self.entityId);
    NSString *getEntityDetailsUrlString = [Baseurl stringByAppendingString:GetEntityDetailsUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getEntityDetailsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityDetailsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getEntityDetailsMutableDictionary setValue:self.entityId forKey:@"id"];
    [getEntityDetailsMutableDictionary setValue:[NSNumber numberWithInt:1] forKey:@"format"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityDetailsUrlString] withBody:getEntityDetailsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self settingEntityDetailsWithData:[responseObject valueForKey:Datakey]];
        self.clinicDetailsArray = [[responseObject valueForKey:Datakey] valueForKey:@"clinic_details"];
        self.servicesArray = [[responseObject valueForKey:Datakey] valueForKey:@"attributes"];
        NSLog(@"Services Array:%@",self.servicesArray);
        [self.doctoDetailsTableView reloadData];
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"Respnse Error;%@",errorResponse);
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


-(void)settingEntityDetailsWithData:(id)entityDetails{
    NSLog(@"Entity Details:%@",entityDetails);
    self.ratingLabel.text = [entityDetails valueForKey:@"rating"];
    if(![[entityDetails valueForKey:@"experience"] isEqualToString:@"0"])
    {
       self.experienceLabel.text = [NSString stringWithFormat:@"%@",[entityDetails valueForKey:@"experience"]];
    }
    else{
        self.experienceLabel.text = @"";
    }
    if([[entityDetails valueForKey:@"e_booking_avail"] isEqualToString:@"1"] ){
        self.consultNowButton.hidden  = NO;
    }
    else{
        self.consultNowButton.hidden = YES;
    }
    self.doctorNameLabel.text = [entityDetails valueForKey:@"name"];
    if(!([entityDetails valueForKey:@"tagline"] == [NSNull null])){
        self.taglineLabel.text = [entityDetails valueForKey:@"tagline"];
    }
    self.locationLabel.text = [[entityDetails valueForKey:@"location"] valueForKey:@"location_name"];
    self.consultationFeeLabel.text = [NSString stringWithFormat:@"Rs. %@ consultation fee",[entityDetails valueForKey:@"average_fee"]];
    self.satisfiedpeopleLabel.text = [NSString stringWithFormat:@"%@ satisfied people",[entityDetails valueForKey:@"no_of_consultations"]];
    self.reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews",[entityDetails valueForKey:@"no_of_reviews"]];
   [self settingProfileImageWithurlString:[entityDetails valueForKey:@"logo_image"] WithIdentifier:[entityDetails valueForKey:@"id"]];
    [self settingBannerImageWithurlString:[entityDetails valueForKey:@"banner_image"] WithIdentifier:[entityDetails valueForKey:@"id"]];
}

-(void)settingProfileImageWithurlString:(NSString *)urlString WithIdentifier:(id)identifier{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor"];
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:identifier];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:self.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:identifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.profileImageView.image = tempImage;
                [MBProgressHUD hideAllHUDsForView:self.profileImageView animated:YES];
            }
                           );
        });
    }
    else{
        self.profileImageView.image = localImage;
    }
    
}

-(void)settingBannerImageWithurlString:(NSString *)urlString WithIdentifier:(id)identifier{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor/Banner"];
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:identifier];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:self.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:identifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.coverImageView.image = tempImage;
                [MBProgressHUD hideAllHUDsForView:self.profileImageView animated:YES];
            }
                           );
        });
    }
    else{
        self.coverImageView.image = localImage;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -Tbable view Datasource and delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.isFirstTabSelected){
            return self.clinicDetailsArray.count;
    }
    else if(self.isSecondTabSelected){
        return self.servicesArray.count;
    }
    else
        return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isFirstTabSelected){
        return [[[self.clinicDetailsArray objectAtIndex:section] valueForKey:@"timings"] count];
        //return self.clinicDetailsArray.count;
    }
    else if (self.isThirdTabSelected){
        return self.reviewArray.count;
    }
    else if (self.isSecondTabSelected){
        if (section == self.selectedService){
            return [[[self.servicesArray objectAtIndex:section] valueForKey:@"value"] count] ;
        }
        else{
            return 0;
        }
    }
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isFirstTabSelected){
        if(indexPath.row == 0){
            DoctorFirstTabTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cellDoctorFirstTabCell"forIndexPath:indexPath];
            NSLog(@"Clinic Name:%@",[self.clinicDetailsArray valueForKey:@"clinic_name"]);
            cell.doctorClinicNameLabel.text = [[self.clinicDetailsArray objectAtIndex:indexPath.section] valueForKey:@"clinic_name"];
            cell.phoneNoLabel.text = [[self.clinicDetailsArray objectAtIndex:indexPath.section] valueForKey:@"phone"];
            cell.consultationFeeLabel.text = [NSString stringWithFormat:@"Rs. %@ consultation fee",[[self.clinicDetailsArray objectAtIndex:indexPath.section]valueForKey:@"fee"]];
            cell.addressLabel.text = [[[self.clinicDetailsArray objectAtIndex:indexPath.section ] valueForKey:@"location"] valueForKey:@"address"];
            cell.photosArray = [[self.clinicDetailsArray objectAtIndex:indexPath.section] valueForKey:@"images"];
            return cell;
        }
        else{
            DoctorConsultingTimingTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTimings"forIndexPath:indexPath];
            cell.timeLabel.text = [[[self.clinicDetailsArray objectAtIndex:indexPath.section] valueForKey:@"timings"] objectAtIndex:indexPath.row-1];
            return cell;
            
        }
    }
    else if(self.isSecondTabSelected){
        DoctorServicesTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cellServics" forIndexPath:indexPath];
        if (cell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DoctorServicesTVC" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects lastObject];
        }
        cell.servicesLAbel.text = [[[self.servicesArray objectAtIndex:indexPath.section] valueForKey:@"value"] objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        DoctorThirdTabTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cellComments"forIndexPath:indexPath];
        cell.reviewrNameLabel.text = [[self.reviewArray objectAtIndex:indexPath.row] valueForKey:@"reviewer"];
        cell.reviewContentLabel.text = [[self.reviewArray objectAtIndex:indexPath.row] valueForKey:@"review"];
        cell.timeLabel.text = [[self.reviewArray objectAtIndex:indexPath.row] valueForKey:@"time"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isFirstTabSelected){
        if(indexPath.row == 0){
            return 150;
        }
        else{
            return 30;
        }
    }
    else if (self.isThirdTabSelected){
        return 100;
    }
    else if(self.isSecondTabSelected){
        return 20;
    }
    else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.isSecondTabSelected){
        return 50;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DoctorServicesHV *doctorServicesheaderView = [[[NSBundle mainBundle] loadNibNamed:@"DoctorServicesHV" owner:self options:nil] firstObject];
    doctorServicesheaderView.tag = 100+section;
    doctorServicesheaderView.doctorServicesDelegate = self;
    doctorServicesheaderView.doctorServicesHVButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 250);
    [doctorServicesheaderView.doctorServicesHVButton setTitle:[[self.servicesArray objectAtIndex:section] valueForKey:@"name"]forState:UIControlStateNormal];
    if(self.selectedService == section){
        [doctorServicesheaderView.doctorServicesHVButton setBackgroundColor:[UIColor darkGrayColor]];
        doctorServicesheaderView.doctorServicesHeaderImageViuew.image = [UIImage imageNamed:@"angle-down"];
        
    }
    else{
        [doctorServicesheaderView.doctorServicesHVButton setBackgroundColor:[UIColor lightGrayColor]];
         doctorServicesheaderView.doctorServicesHeaderImageViuew.image = [UIImage imageNamed:@"angle-right"];
    }
    
    return doctorServicesheaderView;
}

- (IBAction)firstTabButtonAction:(UIButton *)sender {
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.secondTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.thirdTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.isFirstTabSelected = YES;
    self.isSecondTabSelected  = NO;
    self.isThirdTabSelected = NO;
    [self.doctoDetailsTableView reloadData];
}
- (IBAction)secondTabButtonAction:(UIButton *)sender {
    self.secondTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.thirdTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.isFirstTabSelected = NO;
    self.isSecondTabSelected = YES;
    self.isThirdTabSelected = NO;
    [self.doctoDetailsTableView reloadData];
    
}
- (IBAction)thirdTabButtonAction:(UIButton *)sender {
    self.thirdTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.secondTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.isFirstTabSelected = NO;
    self.isSecondTabSelected = NO;
    self.isThirdTabSelected = YES;
    [self callinggetEntityReviewssApi];
    [self.doctoDetailsTableView reloadData];
}

#pragma maRK - Calling get Entity Reviews Api

-(void)callinggetEntityReviewssApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *getEntityReviewsUrlString = [Baseurl stringByAppendingString:GetEntityReviewsurl];
    NSMutableDictionary *getEntityReviewsmutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityReviewsmutableDictionary setValue:accessToken forKey:@"token"];
    [getEntityReviewsmutableDictionary setValue:self.entityId forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.doctoDetailsTableView animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityReviewsUrlString] withBody:getEntityReviewsmutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.doctoDetailsTableView animated:YES];
        self.reviewArray = [responseObject valueForKey:Datakey];
        [self.doctoDetailsTableView reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"Error Description:%@",errorResponse);
        [MBProgressHUD hideAllHUDsForView:self.doctoDetailsTableView animated:YES];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.doctoDetailsTableView){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            NSLog(@"End:");
            //[self getCategoriesApiCall];
           // [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            //[self.bottomProgressIndicatorView stopAnimating];
        }
    }
}

#pragma mark - Button Actions

- (IBAction)consultNowButtonAction:(UIButton *)sender {
}

- (IBAction)callButtonAction:(UIButton *)sender {
}

- (IBAction)messageButtonAction:(UIButton *)sender {
}
- (IBAction)shareButtonAction:(UIButton *)sender {
}

#pragma mark - Doctor Services Delegate

-(void)headerButtonClickWithTag:(NSUInteger)headerTag{
    if(self.selectedService == headerTag - 100){
        self.selectedService = -1;
    }
    else{
        self.selectedService = headerTag - 100;
    }
    [self.doctoDetailsTableView reloadData];
}

@end
