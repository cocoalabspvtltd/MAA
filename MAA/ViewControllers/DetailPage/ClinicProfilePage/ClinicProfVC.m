//
//  ClinicProfVC.m
//  MAA
//
//  Created by Cocoalabs India on 22/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MapVC.h"
#import "DoctorProfVC.h"
#import "ClinicProfVC.h"
#import "SearchResultsTVC.h"

@interface ClinicProfVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *doctorsArray;
@property (nonatomic, strong) id clinicDetails;
@property (nonatomic, strong) UIActivityViewController *activityViewController;
@end

@implementation ClinicProfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    _clinicProfileImage.layer.cornerRadius=_clinicProfileImage.frame.size.width/2;
    _clinicProfileImage.clipsToBounds=YES;
    _btnDirections.layer.borderWidth=0.5f;
    _btnDirections.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    [self callingGetClinicDetailsApi];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    
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
        NSLog(@"Hospital Detilst;%@",responseObject);
        self.clinicDetails = [responseObject valueForKey:Datakey];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self settingEntityDetailsWithData:[responseObject valueForKey:Datakey]];
        //[self.clinicTbableView reloadData];
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
    
    
//    self.satisfiedpeopleLabel.text = [NSString stringWithFormat:@"%@ satisfied people",[entityDetails valueForKey:@"no_of_consultations"]];
   
}

#pragma mark - Table view Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.doctorsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    mapVC.latitude = 10.015861;
    mapVC.longitude = 76.341867;
    [self.navigationController pushViewController:mapVC animated:YES];
}
- (IBAction)favouriteButtonAction:(UIButton *)sender {
}
- (IBAction)messageButtonAction:(UIButton *)sender {
}
- (IBAction)shareButtonAction:(UIButton *)sender {
    [self addingActivityController];
}
- (IBAction)servicesviewMoreButtonAction:(UIButton *)sender {
}

- (IBAction)doctorsAllInfoButtonAction:(UIButton *)sender {
}


#pragma mark - Adding Activity Controller

-(void)addingActivityController{
    NSString *tempString=@"Content";
   
    
    NSString *textToShare  = [NSString stringWithFormat:@"Found an interesting %@ on My App!!",tempString];
   
    NSString *contentHeading = @"Heading";
    NSString *contentDescription = @"Description";
    UIImage *shareImage;
//    if ([self.receivedItemString isEqualToString:EventsmainCategoryString])
//    {
//        shareImage =self.bannerImage;
//    }
  
    NSLog(@"share image =%@",shareImage);
    if (contentHeading==NULL) {
        contentHeading=@"My App";
    }
    NSArray *objectsToShare = @[textToShare,contentHeading,  contentDescription,shareImage];
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
        self.view;
    }
    self.activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}
@end
