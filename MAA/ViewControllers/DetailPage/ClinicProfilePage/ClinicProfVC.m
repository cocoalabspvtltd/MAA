//
//  ClinicProfVC.m
//  MAA
//
//  Created by Cocoalabs India on 22/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MapVC.h"

#import "AddMessagesVC.h"
#import "WebViewController.h"
#import "DoctorAboutVC.h"
#import "DoctorProfVC.h"
#import "ClinicProfVC.h"
#import "DoctorReviewsVC.h"
#import "SubmitReviewView.h"
#import "SearchResultsVC.h"
#import "SearchResultsTVC.h"
#import "TakeAppointmentVC.h"
#import "ReviewTableViewCell.h"

@interface ClinicProfVC ()<UITableViewDataSource,UITableViewDelegate,SubmitReviewDelegate>
@property (nonatomic, strong) NSArray *doctorsArray;
@property (nonatomic, strong) id clinicDetails;
@property (nonatomic, strong) UIActivityViewController *activityViewController;
@property (nonnull, strong) NSArray *reviewsArray;
@property (nonatomic, strong) SubmitReviewView *submitReviewView;
@property (nonatomic, strong) UIView *gradientView;
@end

@implementation ClinicProfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self addSubViews];
    _clinicProfileImage.layer.cornerRadius=_clinicProfileImage.frame.size.width/2;
    _clinicProfileImage.clipsToBounds=YES;
    _btnDirections.layer.borderWidth=0.5f;
    _btnDirections.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    [self callingGetClinicDetailsApi];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.gradientView = [[UIView alloc] init];
    self.gradientView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.gradientView.hidden = YES;
}

-(void)addSubViews{
    [self.view addSubview:self.gradientView];
}

-(void)viewWillLayoutSubviews{
   self.gradientView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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

-(void)callingGetClinicDetailsApi{
    NSString *getEntityDetailsUrlString = [Baseurl stringByAppendingString:GetEntityDetailsUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getEntityDetailsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityDetailsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getEntityDetailsMutableDictionary setValue:self.entityId forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityDetailsUrlString] withBody:getEntityDetailsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        self.clinicDetails = [responseObject valueForKey:Datakey];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self settingEntityDetailsWithData:[responseObject valueForKey:Datakey]];
        self.reviewsArray = [[responseObject valueForKey:Datakey] valueForKey:@"e_reviews"];
        if(self.reviewsArray.count<=2){
            self.allReviewsButton.hidden = YES;
        }
        [self.reviewsTableView reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
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
    NSString *clinicProfileImageUrlString = [entityDetails valueForKey:@"logo_image"];
    [self.clinicProfileImage sd_setImageWithURL:[NSURL URLWithString:clinicProfileImageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    self.clinicNameLabel.text = [entityDetails valueForKey:@"name"];
    self.clinicDetail.text = [entityDetails valueForKey:@"tagline"];
    self.locationLabel.text = [[entityDetails valueForKey:@"location"] valueForKey:@"location_name"];
    self.consultationLabel.text = [NSString stringWithFormat:@"Rs. %@ consultation fee",[entityDetails valueForKey:@"average_fee"]];
    self.experienceLabel.text = [NSString stringWithFormat:@"%@ of experience",[entityDetails valueForKey:@"experience"]];
    self.noOfConsultationsLabel.text = [NSString stringWithFormat:@"%@ consultations",[entityDetails valueForKey:@"no_of_consultations"]];
    if(!([entityDetails valueForKey:@"rating"] == [NSNull null])){
        self.ratingLabel.text = [NSString stringWithFormat:@"%@ rating",[entityDetails valueForKey:@"rating"]];
    }
    else{
        self.ratingLabel.text = [NSString stringWithFormat:@"0 rating"];
    }
     self.reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews",[entityDetails valueForKey:@"no_of_reviews"]];
    if(!([entityDetails valueForKey:@"phone"] == [NSNull null])){
        self.contactNumberLabel.text = [NSString stringWithFormat:@"Contact number: %@",[entityDetails valueForKey:@"phone"]];
    }
    self.doctorsArray = [entityDetails valueForKey:@"doctors"];
    [self.doctorsTableView reloadData];
    [self settingUIBasedOnDoctorDetails];
    
//    self.satisfiedpeopleLabel.text = [NSString stringWithFormat:@"%@ satisfied people",[entityDetails valueForKey:@"no_of_consultations"]];
   
}

-(void)settingUIBasedOnDoctorDetails{
    if(self.doctorsArray.count<=2){
        self.doctorsAllInfoButton.hidden = YES;
    }
}

#pragma mark - Table view Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.doctorsTableView){
        if(self.doctorsArray.count<=2){
            return self.doctorsArray.count;
        }
        else{
            return 2;
        }
    }
    else if (tableView == self.reviewsTableView){
        if(self.reviewsArray.count<=2){
            return self.reviewsArray.count;
        }
        else{
            return 2;
        }
    }
    else{
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.doctorsTableView){
        SearchResultsTVC *cell = [self.doctorsTableView dequeueReusableCellWithIdentifier:@"cellSearchResults"forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellImageViewIcon.clipsToBounds = YES;
        cell.cellImageViewIcon.layer.cornerRadius = 30.00;
        cell.cellImageViewIcon.layer.masksToBounds = YES;
        cell.cellImageViewIcon.layer.borderWidth=0.5f;
        cell.cellImageViewIcon.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
        cell.cellImageViewOnlineStatus.clipsToBounds = YES;
        cell.cellImageViewOnlineStatus.layer.cornerRadius = 5.00;
        cell.cellImageViewOnlineStatus.layer.masksToBounds = YES;
        cell.cellLabelTitle.text = [NSString stringWithFormat:@"%@",[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
        if(![[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"rating"] isEqual:[NSNull null]]){
            cell.cellLabelRating.text = [[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
        }
        NSString *doctorDescription = [NSString stringWithFormat:@"%@ | %@",[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"tagline"],[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"location"]];
        cell.cellLabelDescription.text = doctorDescription;
        cell.cellLabelConsultFee.text = [NSString stringWithFormat:@"Rs.%@ consultation fee",[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"fee"]];
        cell.cellLabelExperience.text = [NSString stringWithFormat:@"%@",[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"experience"]];
        NSURL *imageUrl = [NSURL URLWithString:[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"logo_image"]];
        [cell.cellImageViewIcon sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
        if([[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"is_online"] isEqualToString:@"1"]){
            cell.cellImageViewOnlineStatus.backgroundColor = [UIColor greenColor];
        }
        else{
            cell.cellImageViewOnlineStatus.backgroundColor = [UIColor grayColor];
        }
        return cell;
    }
    else if (tableView == self.reviewsTableView){
        ReviewTableViewCell *cell = [self.reviewsTableView dequeueReusableCellWithIdentifier:@"cellReviews"forIndexPath:indexPath];
        cell.profilImageurlString = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"patient_image"];
        cell.reviewerNameLabel.text = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"patient_name"];
        cell.reviewContentLabel.text = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"review"];
        cell.dateString = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"date"];
        cell.ratingString = [[self.reviewsArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
        return cell;
    }
    else
        return nil;
}

#pragma mark - Adding Review view

-(void)addingReviewView{
    [self addingGradientView];
    self.submitReviewView = [[[NSBundle mainBundle]loadNibNamed:@"submitReviewView" owner:self options:nil]
                             firstObject];
    self.submitReviewView.submitReviewDelegate = self;
    CGFloat xMargin = 20,yMargin = 50;
    self.submitReviewView.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
    [self.view addSubview:self.submitReviewView];
}

-(void)addingGradientView{
    self.gradientView.hidden = NO;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gradientViewGestureAction:)];
    self.gradientView.userInteractionEnabled = YES;
    [self.gradientView addGestureRecognizer:tapGestureRecognizer];
}

-(void)gradientViewGestureAction:(UITapGestureRecognizer *)tapGesture{
    self.gradientView.hidden = YES;
    [self.submitReviewView removeFromSuperview];
}

#pragma mark - Submit Review Delegate

-(void)submitButtonActionWithReviewContent:(NSString *)reviewContent andRating:(float)reting{
    [self callingSubmitReviewPaiWithReviewContent:reviewContent andRating:reting];
    
}

#pragma mark - Submit Review Api

-(void)callingSubmitReviewPaiWithReviewContent:(NSString *)reviewContent andRating:(float)rating{
    NSString *submitReviewUrlString = [Baseurl stringByAppendingString:Submit_review_url];
    NSString *accessTokenString  = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *submitReviewMutableDictionary = [[NSMutableDictionary alloc] init];
    [submitReviewMutableDictionary setValue:accessTokenString forKey:@"token"];
    [submitReviewMutableDictionary setValue:reviewContent forKey:@"review"];
    NSNumber *reviewRating = [NSNumber numberWithFloat:rating];
    [submitReviewMutableDictionary setValue:reviewRating forKey:@"rating"];
    [submitReviewMutableDictionary setValue:self.entityId forKey:@"entity_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:submitReviewUrlString] withBody:submitReviewMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessTokenString];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.gradientView.hidden = YES;
        [self.submitReviewView removeFromSuperview];
        [self callingAlertViewControllerWithString:@"Your review submitted sucessfully. It become active after review"];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
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

#pragma mark - Adding Alert Controller

-(void)callingAlertViewControllerWithString:(NSString *)alertMessage{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:alertMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table View Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DoctorProfVC *doctorPfofileVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorProfVC"];
    doctorPfofileVC.entityId = [[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:doctorPfofileVC animated:YES];
}

#pragma mark  - Button Actions
- (IBAction)directionButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapVC *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"MapVC"];
    mapVC.title = [self.clinicDetails valueForKey:@"name"];
    mapVC.locationString = [self.clinicDetails valueForKey:@"name"];
    mapVC.headingString =  [self.clinicDetails valueForKey:@"name"];
    mapVC.locationDetailString = [[self.clinicDetails valueForKey:@"location"] valueForKey:@"location_name"];
    if(!([[self.clinicDetails valueForKey:@"location"] valueForKey:@"lat"] == [NSNull null]) ){
        mapVC.latitude = [[[self.clinicDetails valueForKey:@"location"] valueForKey:@"lat"] floatValue];
    }
    if(!([[self.clinicDetails valueForKey:@"location"] valueForKey:@"lng"] == [NSNull null]) ){
        mapVC.longitude = [[[self.clinicDetails valueForKey:@"location"] valueForKey:@"lng"] floatValue];
    }
    [self.navigationController pushViewController:mapVC animated:YES];
}
- (IBAction)favouriteButtonAction:(UIButton *)sender {
}
- (IBAction)messageButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddMessagesVC *addMessagesVC = [storyboard instantiateViewControllerWithIdentifier:@"AddMessagesVC"];
    addMessagesVC.entityId = self.entityId;
    [self.navigationController pushViewController:addMessagesVC animated:YES];
    
}
- (IBAction)shareButtonAction:(UIButton *)sender {
    [self addingActivityController];
}
- (IBAction)servicesviewMoreButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DoctorAboutVC *doctorAboutVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorAboutVC"];
    doctorAboutVC.doctorNameString = [self.clinicDetails valueForKey:@"name"];
    doctorAboutVC.specializationArray = [self.clinicDetails valueForKey:@"specializations"];
    doctorAboutVC.servicesArray = [self.clinicDetails valueForKey:@"services"];
    doctorAboutVC.membershipsArray = [self.clinicDetails valueForKey:@"memberships"];
    // doctorAboutVC.awardsArray = [self.clinicDetails valueForKey:@"memberships"];
    // doctorAboutVC.experienceArray = [self.clinicDetails valueForKey:@"memberships"];
    doctorAboutVC.educationArray = [self.clinicDetails valueForKey:@"education"];
    doctorAboutVC.registrationArray = [self.clinicDetails valueForKey:@"registrations"];
    doctorAboutVC.isFromClinic = YES;
    doctorAboutVC.clinicNameString = [self.clinicDetails valueForKey:@"name"];
    [self.navigationController pushViewController:doctorAboutVC animated:YES];
}

- (IBAction)doctorsAllInfoButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchResultsVC *searchResultVC = (SearchResultsVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchResultsVC"];
    //searchResultVC.selectedDepartmentDetails = [self.categoriesMutableArray objectAtIndex:indexPath.row];
    searchResultVC.clinicParentId = self.entityId;
    searchResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}


#pragma mark - Adding Activity Controller

-(void)addingActivityController{
    NSString *textToShare  = [NSString stringWithFormat:@"%@\n",[self.clinicDetails valueForKey:@"sharing_text"]];
    NSString *sharingUrlString = [self.clinicDetails valueForKey:@"sharing_url"];
    NSURL *sharingUrl = [NSURL URLWithString:sharingUrlString];
    NSString *contentDescription = @"";
    UIImage *shareImage;
    NSArray *objectsToShare;
    if(shareImage){
          objectsToShare = @[textToShare,sharingUrl,  contentDescription,shareImage];
    }
    else{
        objectsToShare = @[textToShare,sharingUrl,  contentDescription];
    }
    self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo
                                   
                                   ];
    self.activityViewController.excludedActivityTypes = excludeActivities;
    if ([self.activityViewController respondsToSelector:@selector(popoverPresentationController)]) {
        
        self.activityViewController.popoverPresentationController.sourceView =
        self.shareButton;
    }
    self.activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}

- (IBAction)bokkNowButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TakeAppointmentVC *takeAppointmentVC = [storyboard instantiateViewControllerWithIdentifier:@"TakeAppointmentVC"];
    takeAppointmentVC.entityIDString = self.entityId;
    takeAppointmentVC.isfromClinic = YES;
    takeAppointmentVC.headingString = [self.clinicDetails valueForKey:@"name"];
    takeAppointmentVC.profileImageUrlString = [self.clinicDetails valueForKey:@"banner_image"];
    takeAppointmentVC.locationDetails = [self.clinicDetails valueForKey:@"location"];
    [self.navigationController pushViewController:takeAppointmentVC animated:YES];
}

- (IBAction)facebookButtonAction:(UIButton *)sender {
    [self addingWebViewControllerWithUrlString:[self.clinicDetails valueForKey:@"fb_url"]];
}
- (IBAction)googlePlusButtonAction:(UIButton *)sender {
    [self addingWebViewControllerWithUrlString:[self.clinicDetails valueForKey:@"gp_url"]];
}
- (IBAction)twitterButtonAction:(UIButton *)sender {
    [self addingWebViewControllerWithUrlString:[self.clinicDetails valueForKey:@"tw_url"]];
}

-(void)addingWebViewControllerWithUrlString:(NSString *)webviewurlString{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.urlString = webviewurlString;
    webViewController.headingString = [self.clinicDetails valueForKey:@"name"];
    [self.navigationController pushViewController:webViewController animated:YES];
    
}
- (IBAction)addReviewButtonAction:(UIButton *)sender {
    [self addingReviewView];
}

- (IBAction)allReviewsButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DoctorReviewsVC *doctorReviewsVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorReviewsVC"];
    doctorReviewsVC.entityId = self.entityId;
    [self.navigationController pushViewController:doctorReviewsVC animated:YES];
}
@end
