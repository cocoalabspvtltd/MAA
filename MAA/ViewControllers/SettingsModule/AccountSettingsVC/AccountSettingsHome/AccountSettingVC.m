//
//  AccountSettingVC.m
//  MAA
//
//  Created by Cocoalabs India on 02/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#import "CountriesVC.h"
#import "AccountResetPWVC.h"
#import "AccountSettingVC.h"

@interface AccountSettingVC ()<CountriesVCDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL isFromCity;
@property (nonatomic, assign) BOOL isFromLocality;
@property (nonatomic, assign) BOOL isFromCreateNewPassword;
@property (nonatomic, strong) NSString *cityIdString;
@end

@implementation AccountSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self callingGetAccountInfoApi];
    _profileImageView.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
//    _childView1.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    _childView1.layer.shadowOffset = CGSizeMake(5, 5);
//    _childView1.layer.shadowOpacity = .5;
//    _childView1.layer.shadowRadius = 1.0;
//   
//    _childView2.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    _childView2.layer.shadowOffset = CGSizeMake(5, 5);
//    _childView2.layer.shadowOpacity = .5;
//    _childView2.layer.shadowRadius = 1.0;
//    
//    _childView3.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    _childView3.layer.shadowOffset = CGSizeMake(5, 5);
//    _childView3.layer.shadowOpacity = .5;
//    _childView3.layer.shadowRadius = 1.0;
    
    _submitButton.hidden=YES;
    _underlineimg1.hidden=YES;
    _underlineimg2.hidden=YES;
    _underlineimg3.hidden=YES;
    _underlineimg4.hidden=YES;
    _underlineimg5.hidden=YES;
    _underlineimg6.hidden=YES;
    _underlineimg7.hidden=YES;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
   // datePicker.tag = indexPath.row;
    _dateOfBirthTextField.inputView = datePicker;
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.isFromCity = NO;
    self.isFromLocality = NO;
    self.cityIdString = @"";
}
-(void)datePickerValueChanged
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    [ _scroller setContentSize:CGSizeMake(self.view.frame.size.width, 628)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)callingGetAccountInfoApi{
    NSString *getAccountInfoApiUrlSrtring = [Baseurl stringByAppendingString:getAccountinfoApiurl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *healthinfoMutableDictionary = [[NSMutableDictionary alloc] init];
    NSArray *fieldArray = [NSArray arrayWithObjects:@"name",@"location",@"e_base_img",@"e_banner_img",@"dob",@"about",@"address",@"phone",@"gender",@"images", nil];
    [healthinfoMutableDictionary setValue:accessToken forKey:@"token"];
    [healthinfoMutableDictionary setValue:fieldArray forKey:@"fields"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getAccountInfoApiUrlSrtring] withBody:healthinfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [self populatingProfileDetailsWithResponsedata:[responseObject valueForKey:Datakey]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response :%@",responseObject);
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

-(void)populatingProfileDetailsWithResponsedata:(id)profileData{
    NSLog(@"PRofile Date:%@",profileData);
    if(!([profileData valueForKey:@"e_base_img"] == [NSNull null])){
        NSString *profileImageUrlString = [profileData valueForKey:@"e_base_img"];
        [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:profileImageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    }
    if(!([profileData valueForKey:@"name"] == [NSNull null])){
        self.namLabel.text = [profileData valueForKey:@"name"];
        self.nameTxtField.text = [profileData valueForKey:@"name"];
    }
    if(!([profileData valueForKey:@"location"] == [NSNull null])){
        self.localityTextField.text = [profileData valueForKey:@"location"];
    }
    if(!([profileData valueForKey:@"address"] == [NSNull null])){
        self.addressTextView.text = [profileData valueForKey:@"address"];
    }
    if(!([profileData valueForKey:@"phone"] == [NSNull null])){
        self.mobileNumberTextField.text = [profileData valueForKey:@"phone"];
    }
    if(!([profileData valueForKey:@"gender"] == [NSNull null])){
        NSString *genderTExt = [profileData valueForKey:@"gender"];
        if([genderTExt isEqualToString:@"1"]){
            self.maleRadioButton.selected  =YES;
        }
        else{
            self.femaleRadioButton.selected  =YES;
        }
    }
    if(!([profileData valueForKey:@"dob"] == [NSNull null])){
        self.dateOfBirthTextField.text = [profileData valueForKey:@"dob"];
    }
    
    BOOL isFBlogIn = [[NSUserDefaults standardUserDefaults] boolForKey:isfaceBookLogIn];
    if(isFBlogIn){
        if([[profileData valueForKey:@"has_password"] isEqualToNumber:[NSNumber numberWithInt:0]]){
            self.isFromCreateNewPassword = YES;
            self.changeMyPasswordLabel.text = @"Create Password";
        }
        
    }
    
}

#pragma mark - Button Actions

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)maleRadioButtonAction:(UIButton *)sender {
    sender.selected = YES;
    self.femaleRadioButton.selected = NO;
    
}
- (IBAction)femaleRadioButtonAction:(UIButton *)sender {
    sender.selected  =YES;
    self.maleRadioButton.selected = NO;
}

- (IBAction)Edit:(id)sender {
    [self enablingInputFields];
}

- (IBAction)Submit:(id)sender {
    [self callingEditAccountInfoApi];
}

- (IBAction)changeMypassword:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountResetPWVC *accountResetPasswordVC = [storyboard instantiateViewControllerWithIdentifier:@"changePasswordVC"];
    accountResetPasswordVC.isFromNewPassord = self.isFromCreateNewPassword;
    [self.navigationController pushViewController:accountResetPasswordVC animated:YES];
}
- (IBAction)localityButtonAction:(UIButton *)sender {
    self.isFromLocality = YES;
    [self addingCountriesVC];
}

#pragma mark - Enabling Input Fields

-(void)enablingInputFields{
    self.profileImageView.userInteractionEnabled  =YES;
    self.nameTxtField.enabled = YES;
    self.emailTesxtField.enabled  =YES;
    self.mobileNumberTextField.enabled = YES;
    self.maleRadioButton.userInteractionEnabled = YES;
    self.femaleRadioButton.userInteractionEnabled = YES;
    self.dateOfBirthTextField.enabled  =YES;
    self.cityTExtField.enabled  =YES;
    self.localityTextField.enabled  =YES;
    self.addressTextView.editable = YES;
    self.submitButton.enabled = YES;
    self.changeMyPasswordButton.enabled =  YES;
    self.submitButton.hidden=NO;
    
    _underlineimg1.hidden=NO;
    _underlineimg2.hidden=NO;
    _underlineimg3.hidden=NO;
    _underlineimg4.hidden=NO;
    _underlineimg5.hidden=NO;
    _underlineimg6.hidden=NO;
    _underlineimg7.hidden=NO;
    
}

-(void)disablingInputFields
{
    self.profileImageView.userInteractionEnabled  =NO;
    self.nameTxtField.enabled = NO;
    self.emailTesxtField.enabled  =NO;
    self.mobileNumberTextField.enabled = NO;
    self.maleRadioButton.userInteractionEnabled = NO;
    self.femaleRadioButton.userInteractionEnabled = NO;
    self.dateOfBirthTextField.enabled  = NO;
    self.cityTExtField.enabled  = NO;
    self.localityTextField.enabled  =NO;
    self.addressTextView.editable = NO;
    self.changeMyPasswordButton.enabled =  NO;
    self.submitButton.enabled = NO;
    self.submitButton.hidden = NO;
    
}

-(void)addingCountriesVC{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CountriesVC *countriesVC = (CountriesVC *)[storyboard instantiateViewControllerWithIdentifier:@"CountriesVC"];
    countriesVC.countriesDelegate = self;
    [self.navigationController pushViewController:countriesVC animated:YES];
}


#pragma mark - CountriesVCDelegate

-(void)selectedLocationWithDetails:(id)locationDetails{
    if(self.isFromLocality){
        self.localityTextField.text = [locationDetails valueForKey:@"name"];
    }
    else if (self.isFromCity){
        self.cityTExtField.text =  [locationDetails valueForKey:@"name"];
        self.cityIdString = [locationDetails valueForKey:@"id"];
    }
    self.isFromLocality = NO;
    self.isFromCity = NO;
    NSLog(@"Is From :%d",self.isFromCity);
    NSLog(@"Location Details:%@",locationDetails);
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.cityTExtField){
        self.isFromCity = YES;
        [self addingCountriesVC];
        return NO;
    }
    else if (textField == self.localityTextField){
        self.isFromLocality = YES;
        [self addingCountriesVC];
        return NO;
    }
    else{
        return YES;
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField == self.nameTxtField){
        [self.emailTesxtField becomeFirstResponder];
    }
    else if (textField == self.emailTesxtField){
        [self.mobileNumberTextField becomeFirstResponder];
    }
    else if (textField == self.mobileNumberTextField){
        [self.dateOfBirthTextField becomeFirstResponder];
    }
    else if (textField == self.dateOfBirthTextField){
        [self.cityTExtField becomeFirstResponder];
    }
    else if (textField == self.cityTExtField){
        [self.localityTextField becomeFirstResponder];
    }
    else if (textField == self.localityTextField){
        [self.addressTextView becomeFirstResponder];
    }
    return YES;
}



#pragma mark - Calling Edit Account Info api

-(void)callingEditAccountInfoApi{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *editAccountInfoUrlString = Baseurl;
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *editAccountInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [editAccountInfoMutableDictionary setValue:self.nameTxtField.text forKey:@"name"];
    [editAccountInfoMutableDictionary setValue:self.emailTesxtField.text forKey:@"email"];
    [editAccountInfoMutableDictionary setValue:self.mobileNumberTextField.text forKey:@"phone"];
    if([self.maleRadioButton isSelected]){
        [editAccountInfoMutableDictionary setValue:@"1" forKey:@"gender"];
    }
    else{
        [editAccountInfoMutableDictionary setValue:@"2" forKey:@"gender"];
    }
    NSData *uploadingImageData;
    if(self.profileImageView.image){
         uploadingImageData = UIImageJPEGRepresentation(self.profileImageView.image, 0.1);
    }
    [editAccountInfoMutableDictionary setValue:self.cityIdString forKey:@"city_id"];
    [editAccountInfoMutableDictionary setValue:[self convertingDateOfBirth:self.dateOfBirthTextField.text] forKey:@"dob"];
    [editAccountInfoMutableDictionary setValue:self.localityTextField.text forKey:@"location"];
    [editAccountInfoMutableDictionary setValue:self.addressTextView.text forKey:@"address"];
    [editAccountInfoMutableDictionary setValue:tokenString forKey:@"token"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:editAccountInfoUrlString] withBody:editAccountInfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler]startUploadRequest:@"eajah.jpg" withData:uploadingImageData withType:fileTypeJPGImage withUrlParameter:EditAccountInfoUrl andFileName:@"logo" SuccessBlock:^(id responseObject) {
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseObject
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        [self disablingInputFields];
        [self callingAlertViewControllerWithMessageString:[[jsonObject valueForKey:Datakey] valueForKey:@"message"]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } ProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
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

#pragma mark - Adding Alert View Controller

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

-(NSString *)convertingDateOfBirth:(NSString *)dobString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:MM"];
    NSDate *interDate = [dateFormatter dateFromString:dobString];
    [dateFormatter setDateFormat:@"yyyy-MM-dd "];
    NSString *finalDate = [dateFormatter stringFromDate:interDate];
    return finalDate;
}
- (IBAction)profileImageTapGestureAction:(UITapGestureRecognizer *)sender {
    [self addingActionSheet];
}

-(void)addingActionSheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose Photos" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *chooseFromGallery = [UIAlertAction actionWithTitle:@"Choose From Gallery" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self chooseLibraryButtonAction];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *takePhotosAlertAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addingImagePickerView];
      [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:chooseFromGallery];
    [alertController addAction:takePhotosAlertAction];
    [alertController addAction:cancelAlertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)addingImagePickerView{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *noCameraAlertView = [[UIAlertView alloc] initWithTitle:AppName
                                                                    message:@"Device has no camera"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
        
        [noCameraAlertView show];
        
    }
    else{
        if([[CLUtilities standardUtilities] goToCamera]){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
}

- (void)chooseLibraryButtonAction {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Image Picker Delegates

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *chosenImage  = [[CLUtilities standardUtilities] scaleAndRotateImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    self.profileImageView.image = chosenImage;
    
}

@end
