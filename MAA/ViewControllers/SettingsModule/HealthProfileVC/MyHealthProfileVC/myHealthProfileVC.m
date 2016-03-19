//
//  myHealthProfileVC.m
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#import "MyAllergies.h"
#import "MedicalDocumentsVC.h"
#import "myHealthProfileVC.h"

@interface myHealthProfileVC ()
{
    NSArray *BloodGrups;
    
}
@property (nonatomic, strong) NSString *selectedBloodGroupId;
@end

@implementation myHealthProfileVC

CGFloat ht=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblDropDown.hidden=YES;
    self.selectedBloodGroupId = @"";
    [self callingHealthProfileApi];
    self.underLineImg1.backgroundColor=[UIColor clearColor];
    self.underLineImg2.backgroundColor=[UIColor clearColor];
    self.underLineImg3.backgroundColor=[UIColor clearColor];
    self.underLineImg4.backgroundColor=[UIColor clearColor];
    self.underLineImg5.backgroundColor=[UIColor clearColor];
    self.underLineImg6.backgroundColor=[UIColor clearColor];
    self.underLineImg7.backgroundColor=[UIColor clearColor];
    self.submitButton.hidden=YES;
    
    _childView1.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _childView1.layer.shadowOffset = CGSizeMake(5, 5);
    _childView1.layer.shadowOpacity = .5;
    _childView1.layer.shadowRadius = 1.0;
    
    _childView2.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _childView2.layer.shadowOffset = CGSizeMake(5, 5);
    _childView2.layer.shadowOpacity = .5;
    _childView2.layer.shadowRadius = 1.0;
    
    _childView3.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _childView3.layer.shadowOffset = CGSizeMake(5, 5);
    _childView3.layer.shadowOpacity = .5;
    _childView3.layer.shadowRadius = 1.0;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return BloodGrups.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableIdentifier=@"TableItem";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    }
    cell.textLabel.text=[[BloodGrups objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.textLabel.font=[UIFont systemFontOfSize:(11.0)];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.tag = 300+indexPath.row;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *x = [BloodGrups[indexPath.row] valueForKey:@"name"];
    self.selectedBloodGroupId = [BloodGrups[indexPath.row] valueForKey:@"id"];
    [_btnDropDown setTitle:x forState:UIControlStateNormal];
    _tblDropDown.hidden=YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) viewDidLayoutSubviews
{

    CGFloat  height = self.ContentView.frame.size.height+154;
    
    [_scroller setContentSize:CGSizeMake(self.view.frame.size.width,height)];
    
}
- (IBAction)backbuttonAction:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)editButtonAction:(UIButton *)sender
{
    
    self.heightTextField.enabled = YES;
    self.weightTextField.enabled = YES;
    self.btnDropDown.enabled = YES;
    self.lowBPtextField.enabled = YES;
    self.hightextField.enabled = YES;
    self.fastingSugarTextField.enabled = YES;
    self.postMealSugarTextField.enabled  =YES;
    self.notestextField.enabled = YES;
    
    self.submitButton.enabled = YES;
    self.underLineImg1.backgroundColor=[UIColor redColor];
    self.underLineImg2.backgroundColor=[UIColor redColor];
    self.underLineImg3.backgroundColor=[UIColor redColor];
    self.underLineImg4.backgroundColor=[UIColor redColor];
    self.underLineImg5.backgroundColor=[UIColor redColor];
    self.underLineImg6.backgroundColor=[UIColor redColor];
    self.underLineImg7.backgroundColor=[UIColor redColor];
    self.submitButton.hidden=NO;
}

- (IBAction)DropDown:(id)sender
{
    if (_tblDropDown.hidden==YES) {
        _tblDropDown.hidden=NO;
    }
    else
        _tblDropDown.hidden=YES;
}
- (IBAction)prescriptionsButtonAction:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    MedicalDocumentsVC *medicalDocumentsVC = (MedicalDocumentsVC *)[storyboard instantiateViewControllerWithIdentifier:@"MedicalDocumentsVC"];
    medicalDocumentsVC.isFromPrescriptions = YES;
    [self.navigationController pushViewController:medicalDocumentsVC animated:YES];
}
- (IBAction)medicalDocumentsbuttonAction:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    MedicalDocumentsVC *medicalDocumentsVC = (MedicalDocumentsVC *)[storyboard instantiateViewControllerWithIdentifier:@"MedicalDocumentsVC"];
    medicalDocumentsVC.isFromMedicalDocuments = YES;
    [self.navigationController pushViewController:medicalDocumentsVC animated:YES];
}
- (IBAction)imagesActions:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    MedicalDocumentsVC *medicalDocumentsVC = (MedicalDocumentsVC *)[storyboard instantiateViewControllerWithIdentifier:@"MedicalDocumentsVC"];
    medicalDocumentsVC.isFromImages = YES;
    [self.navigationController pushViewController:medicalDocumentsVC animated:YES];
}

- (IBAction)allergiesButtonAction:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    MyAllergies *myAllergiesVC = (MyAllergies *)[storyboard instantiateViewControllerWithIdentifier:@"MyAllergies"];
    [self.navigationController pushViewController:myAllergiesVC animated:YES];
}

- (IBAction)submitButtonAction:(UIButton *)sender
{
    [self callingSubmitHealthProfile];
    self.underLineImg1.backgroundColor=[UIColor clearColor];
    self.underLineImg2.backgroundColor=[UIColor clearColor];
    self.underLineImg3.backgroundColor=[UIColor clearColor];
    self.underLineImg4.backgroundColor=[UIColor clearColor];
    self.underLineImg5.backgroundColor=[UIColor clearColor];
    self.underLineImg6.backgroundColor=[UIColor clearColor];
    self.underLineImg7.backgroundColor=[UIColor clearColor];
    
}

#pragma mark - Calling Health Profile Api

-(void)callingHealthProfileApi{
    NSString *getAccountInfoApiUrlSrtring = [Baseurl stringByAppendingString:GetHealthProfileUrl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *healthinfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [healthinfoMutableDictionary setValue:accessToken forKey:@"token"];
    [healthinfoMutableDictionary setValue:[NSNumber numberWithInt:1] forKey:@"show_blood_groups"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getAccountInfoApiUrlSrtring] withBody:healthinfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object:%@",responseObject);
        [self populatingHealthDetailsWithResponsedata:[responseObject valueForKey:Datakey]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
        NSLog(@"Error :%@",errorResponse);
    }];
}

-(void)populatingHealthDetailsWithResponsedata:(id)profileData{
//    if(!([profileData valueForKey:@"e_base_img"] == [NSNull null])){
//        [self downloadingProfileImageWithUrlString:[profileData valueForKey:@"e_base_img"]];
//    }
//    if(!([profileData valueForKey:@"e_banner_img"] == [NSNull null])){
//        [self downloadingProfileBackgroundImageWithurlString:[profileData valueForKey:@"e_banner_img"]];
//    }
//    if(!([profileData valueForKey:@"name"] == [NSNull null])){
//        self.nameLabel.text = [profileData valueForKey:@"name"];
//    }
//    if(!([profileData valueForKey:@"location"] == [NSNull null])){
//        self.locationlabel.text = [profileData valueForKey:@"location"];
//    }
//    if(!([profileData valueForKey:@"address"] == [NSNull null])){
//        self.addresslabel.text = [profileData valueForKey:@"address"];
//    }
//    if(!([profileData valueForKey:@"phone"] == [NSNull null])){
//        self.phoneTextField.text = [profileData valueForKey:@"phone"];
//    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"weight"] == [NSNull null])){
        self.weightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"weight"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"height"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"height"];
    }
    if (!([[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"] == [NSNull null])){
        NSString *bloodGroup = [[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"];
        [self.btnDropDown setTitle:bloodGroup forState:UIControlStateNormal];
    }
    if (!([[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"id"] == [NSNull null])){
        self.selectedBloodGroupId = [[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"id"];
    }
//    if(!([profileData valueForKey:@"dob"] == [NSNull null])){
//        self.dateOfBirthTextField.text = [profileData valueForKey:@"dob"];
//    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"] == [NSNull null])){
        self.lowBPtextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"];
    }
    BloodGrups = [profileData valueForKey:@"blood_groups"];
    [self.tblDropDown reloadData];
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"] == [NSNull null])){
        self.hightextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"];
    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"fasting_sugar"] == [NSNull null])){
        self.fastingSugarTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"fasting_sugar"] ;
    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"post_meal_sugar"] == [NSNull null])){
        self.postMealSugarTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"post_meal_sugar"] ;
    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"notes"] == [NSNull null])){
        self.notestextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"notes"];
    }
//    self.userImagesArray = [profileData valueForKey:@"images"];
//    [self.photosCollectionView reloadData];
//    self.medicalDocumentsArray = [profileData valueForKey:@"medical_docs"];
//    [self.medicalDocumantsCollectionview reloadData];
//    self.prescriptionsArray = [profileData valueForKey:@"prescription"];
//    [self.prescriptionsTableView reloadData];
}


#pragma mark - Calling Edit Account Info api

-(void)callingSubmitHealthProfile{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *editAccountInfoUrlString = [Baseurl stringByAppendingString:EditAccountInfoUrl];
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *editAccountInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [editAccountInfoMutableDictionary setValue:self.heightTextField.text forKey:@"height"];
    [editAccountInfoMutableDictionary setValue:self.weightTextField.text forKey:@"weight"];
    [editAccountInfoMutableDictionary setValue:self.lowBPtextField.text forKey:@"low_bp"];
    [editAccountInfoMutableDictionary setValue:self.hightextField.text forKey:@"high_bp"];
    [editAccountInfoMutableDictionary setValue:self.fastingSugarTextField.text forKey:@"fasting_sugar"];
    [editAccountInfoMutableDictionary setValue:self.postMealSugarTextField.text forKey:@"post_meal_sugar"];
    [editAccountInfoMutableDictionary setValue:self.notestextField.text forKey:@"notes"];
    [editAccountInfoMutableDictionary setValue:tokenString forKey:@"token"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:editAccountInfoUrlString] withBody:editAccountInfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [self disablingControlsAfterSubmittingUserDetails];
        [self callingAlertViewControllerWithPopActionWithMessageString:[[responseObject valueForKey:Datakey] valueForKey:@"message"]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        [self callingAlertViewControllerWithMessageString:errorMessage];
    }];
}

-(void)callingAlertViewControllerWithMessageString:(NSString *)alertMessage{
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

-(void)callingAlertViewControllerWithPopActionWithMessageString:(NSString *)alertMessage{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:alertMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   [self.navigationController popViewControllerAnimated:YES];
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)disablingControlsAfterSubmittingUserDetails{
    self.heightTextField.enabled = NO;
    self.weightTextField.enabled = NO;
    self.btnDropDown.enabled = NO;
    self.lowBPtextField.enabled = NO;
    self.hightextField.enabled = NO;
    self.fastingSugarTextField.enabled = NO;
    self.postMealSugarTextField.enabled  =NO;
    self.notestextField.enabled = NO;
    
    self.submitButton.enabled = NO;
    self.underLineImg1.backgroundColor=[UIColor clearColor];
    self.underLineImg2.backgroundColor=[UIColor clearColor];
    self.underLineImg3.backgroundColor=[UIColor clearColor];
    self.underLineImg4.backgroundColor=[UIColor clearColor];
    self.underLineImg5.backgroundColor=[UIColor clearColor];
    self.underLineImg6.backgroundColor=[UIColor clearColor];
    self.underLineImg7.backgroundColor=[UIColor clearColor];
   
}
@end
