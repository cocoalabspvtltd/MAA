//
//  DoctorProfVC.m
//  MAA
//
//  Created by Cocoalabs India on 22/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MapVC.h"
#import "DoctorProfVC.h"
#import "DoctorAboutVC.h"
#import "DoctorReviewsVC.h"
#import "ReviewTableViewCell.h"

@interface DoctorProfVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *reviewsArray;
@property (nonatomic, strong) id doctorFirstClinicDetails;
@property (nonatomic, strong) id entityDetails;
@end

@implementation DoctorProfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgProfile.layer.cornerRadius=_imgProfile.frame.size.width/2;
    _imgProfile.clipsToBounds=YES;
    _imgProfile.layer.borderWidth=0.5f;
    _imgProfile.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnDirection.layer.borderWidth=0.5f;
    _btnDirection.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    [self callingGetDoctorDetailsApi];
    // Do any additional setup after loading the view.
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

#pragma mark - Get Entity Details Api

-(void)callingGetDoctorDetailsApi{
    NSLog(@"Get Doctor Id;%@",self.entityId);
    NSString *getEntityDetailsUrlString = [Baseurl stringByAppendingString:GetEntityDetailsUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getEntityDetailsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityDetailsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getEntityDetailsMutableDictionary setValue:self.entityId forKey:@"id"];
    [getEntityDetailsMutableDictionary setValue:[NSNumber numberWithInt:1] forKey:@"format"];
    [getEntityDetailsMutableDictionary setValue:[NSNumber numberWithInt:3] forKey:@"reviews_count"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityDetailsUrlString] withBody:getEntityDetailsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         NSLog(@"Respnse Error;%@",responseObject);
        self.entityDetails = [responseObject valueForKey:Datakey];
        [self settingEntityDetailsWithData:[responseObject valueForKey:Datakey]];
        self.reviewsArray = [[responseObject valueForKey:Datakey] valueForKey:@"e_reviews"];
        if(self.reviewsArray.count<=2){
            self.reviewAllInfoButton.hidden = YES;
        }
        [self.reviewTableView reloadData];
       // self.clinicDetailsArray = [[responseObject valueForKey:Datakey] valueForKey:@"clinic_details"];
       // self.servicesArray = [[responseObject valueForKey:Datakey] valueForKey:@"attributes"];
        //NSLog(@"Services Array:%@",self.servicesArray);
       // [self.doctoDetailsTableView reloadData];
        
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
    NSString *profileImageUrlString = [entityDetails valueForKey:@"logo_image"];
    [self.imgProfile sd_setImageWithURL:[NSURL URLWithString:profileImageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    if(![[entityDetails valueForKey:@"name"] isEqual:[NSNull null]]){
        self.namLabel.text = [NSString stringWithFormat:@"Dr. %@",[entityDetails valueForKey:@"name"]];
    }
    if(!([entityDetails valueForKey:@"tagline"] == [NSNull null])){
        self.tagLineLabel.text = [entityDetails valueForKey:@"tagline"];
    }
    if(!([[entityDetails valueForKey:@"location"] valueForKey:@"location_name"] == [NSNull null])){
        self.locationLabel.text = [[entityDetails valueForKey:@"location"] valueForKey:@"location_name"];
    }
    if(!([entityDetails valueForKey:@"average_fee"] == [NSNull null])){
        self.consultationFeeLabel.text = [NSString stringWithFormat:@"Rs. %@ consultation fee",[entityDetails valueForKey:@"average_fee"]];
    }
    if(![[entityDetails valueForKey:@"experience"] isEqualToString:@"0"])
    {
        self.experienceLbael.text = [NSString stringWithFormat:@"%@ of experience",[entityDetails valueForKey:@"experience"]];
    }
    else{
        self.experienceLbael.text = @"";
    }
    if(!([entityDetails valueForKey:@"no_of_consultations"] == [NSNull null])){
        self.noOfConsultationsLabel.text = [NSString stringWithFormat:@"%@ consultations",[entityDetails valueForKey:@"no_of_consultations"]];
    }
    if(![[entityDetails valueForKey:@"rating"] isEqual:[NSNull null]]){
        self.ratingLabel.text = [NSString stringWithFormat:@"%@ rating",[entityDetails valueForKey:@"rating"]];
    }
    if(![[entityDetails valueForKey:@"rating"] isEqual:[NSNull null]]){
        self.reviewLabel.text = [NSString stringWithFormat:@"%@ Reviews",[entityDetails valueForKey:@"no_of_reviews"]];
    }
    if(![[entityDetails valueForKey:@"phone"] isEqual:[NSNull null]]){
        self.contactNoLabel.text = [NSString stringWithFormat:@"Contact number:%@",[entityDetails valueForKey:@"phone"]];
    }
    if(![[entityDetails valueForKey:@"description"] isEqual:[NSNull null]]){
        self.aboutLabel.text = [entityDetails valueForKey:@"description"];
    }
    if([[entityDetails valueForKey:@"clinic_details"] count]>0){
        self.doctorFirstClinicDetails = [[entityDetails valueForKey:@"clinic_details"] objectAtIndex:0];
        self.cliniclocationLabel.text = [NSString stringWithFormat:@"%@\n%@",[self.doctorFirstClinicDetails valueForKey:@"clinic_name"],[[self.doctorFirstClinicDetails valueForKey:@"location"] valueForKey:@"address"]];
    }
    NSLog(@"Doctor Clinic Details:%@",self.doctorFirstClinicDetails);
//    if([[entityDetails valueForKey:@"e_booking_avail"] isEqualToString:@"1"] ){
//        self.consultNowButton.hidden  = NO;
//    }
//    else{
//        self.consultNowButton.hidden = YES;
//    }
}

- (IBAction)aboutAllInfoButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DoctorAboutVC *doctorAboutVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorAboutVC"];
    NSLog(@"Name:%@",[self.entityDetails valueForKey:@"name"]);
    doctorAboutVC.doctorNameString = [self.entityDetails valueForKey:@"name"];
    doctorAboutVC.specializationArray = [self.entityDetails valueForKey:@"specializations"];
    doctorAboutVC.servicesArray = [self.entityDetails valueForKey:@"services"];
    doctorAboutVC.membershipsArray = [self.entityDetails valueForKey:@"memberships"];
   // doctorAboutVC.awardsArray = [self.entityDetails valueForKey:@"memberships"];
   // doctorAboutVC.experienceArray = [self.entityDetails valueForKey:@"memberships"];
    doctorAboutVC.educationArray = [self.entityDetails valueForKey:@"education"];
    doctorAboutVC.registrationArray = [self.entityDetails valueForKey:@"registrations"];
    [self.navigationController pushViewController:doctorAboutVC animated:YES];
    
}

- (IBAction)directionButtonAction:(UIButton *)sender {
    NSLog(@"dfdej:%@",[self.doctorFirstClinicDetails valueForKey:@"clinic_name"]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapVC *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"MapVC"];
    mapVC.locationString = [self.doctorFirstClinicDetails valueForKey:@"clinic_name"];
    mapVC.locationDetailString = [[self.doctorFirstClinicDetails valueForKey:@"location"] valueForKey:@"address"];
    mapVC.latitude = [[[self.doctorFirstClinicDetails valueForKey:@"location"] valueForKey:@"lat"] floatValue];
    mapVC.longitude = [[[self.doctorFirstClinicDetails valueForKey:@"location"] valueForKey:@"lng"] floatValue];
    mapVC.latitude = 10.015861;
    mapVC.longitude = 76.341867;
    [self.navigationController pushViewController:mapVC animated:YES];
}
- (IBAction)addReviewButtonAction:(UIButton *)sender {
}
- (IBAction)reviewAllInfoButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DoctorReviewsVC *doctorReviewsVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorReviewsVC"];
    doctorReviewsVC.entityId = self.entityId;
    [self.navigationController pushViewController:doctorReviewsVC animated:YES];
}
- (IBAction)timingViewMoreButtonAction:(UIButton *)sender {
}

#pragma mark - Table view Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.reviewTableView){
        if(self.reviewsArray.count>2){
            return 2;
        }
        else{
            return self.reviewsArray.count;
        }
    }
    else{
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReviewTableViewCell *cell = [self.reviewTableView dequeueReusableCellWithIdentifier:@"cellReviews"forIndexPath:indexPath];
    cell.profilImageurlString = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"patient_image"];
    cell.reviewerNameLabel.text = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"patient_name"];
    cell.reviewContentLabel.text = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"review"];
    cell.dateString = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.ratingString = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
    return cell;
}

@end
