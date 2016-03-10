//
//  SignUpPage2VC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "SignUpPage2VC.h"
#import "LoginPageVC.h"
#import "ResetPasswordOTPVC.h"
#import <CommonCrypto/CommonDigest.h>

@interface SignUpPage2VC ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIDatePicker *dobDatePicker;
@property (nonatomic, strong) NSString *DOBstringValue;
@property (nonatomic, strong) UIPickerView *genderPickerView;
@property (nonatomic, strong) NSString *dobApiValueString;
@property (nonatomic, strong) NSArray *genderArray;
@property (nonatomic, strong) NSString *stringGenderValue;
@property (nonatomic, assign) CGRect oldFrame;
@end

@implementation SignUpPage2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    NSLog(@"Name String;%@",self.nameString);
    NSLog(@"Phone Number:%@",self.phoneNumberString);
    NSLog(@"Email id:%@",self.emailString);
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    [self initialisingDOBDatePicker];
    textFieldDateOfBirth.inputView = self.dobDatePicker;
    [self addDOBPickerDoneToolBar];
    [self addGenderPickerDoneToolBar];
    self.genderPickerView = [[UIPickerView alloc] init];
    self.genderPickerView.tag = 101;
    self.genderPickerView.dataSource = self;
    self.genderPickerView.delegate = self;
    self.genderArray = @[@"Male",@"Female",@"Unspecified"];
    textFieldGender.inputView = self.genderPickerView;
}

-(void)initialisingDOBDatePicker{
    self.dobDatePicker = [[UIDatePicker alloc] init];
    self.dobDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.dobDatePicker setDate:[NSDate date]];
    [self.dobDatePicker setMaximumDate:[NSDate date]];
    [self.dobDatePicker addTarget:self action:@selector(dobPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
}



-(void)dobPickerValueChanged:(UIDatePicker *)picker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    self.DOBstringValue = [dateFormatter stringFromDate:[self.dobDatePicker date]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dobApiValueString = [dateFormatter stringFromDate:[self.dobDatePicker date]];
    NSLog(@"DOB Apim String:%@",self.dobApiValueString);
    
}

#pragma mark - PickerViewToolBar

-(void)addDOBPickerDoneToolBar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    textFieldDateOfBirth.inputAccessoryView = toolBar;
}

-(void)addGenderPickerDoneToolBar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched3:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    textFieldGender.inputAccessoryView = toolBar;
}

- (void)doneTouched3:(id)sender
{
    [self.view endEditing:YES];
    textFieldGender.text = self.stringGenderValue;
    [textFieldDateOfBirth becomeFirstResponder];
}

- (void)doneTouched:(id)sender
{
    [self.view endEditing:YES];
    if(self.DOBstringValue == nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        self.DOBstringValue = [dateFormatter stringFromDate:[NSDate date]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.dobApiValueString = [dateFormatter stringFromDate:[self.dobDatePicker date]];
    }
    textFieldDateOfBirth.text = self.DOBstringValue;
    [textFieldDateOfBirth resignFirstResponder];
    [textFieldPassword becomeFirstResponder];
}

#pragma mark - Picker View Data Source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 101){
        return self.genderArray.count;
    }
    return 0;
}

#pragma mark - Picker View Delegates

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(pickerView.tag == 101){
        if (row==0) {
            self.stringGenderValue = [self.genderArray objectAtIndex:0];
            //self.genderIndex = 0;
        }
        return [self.genderArray objectAtIndex:row];
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView.tag == 101){
        if (row==0) {
            self.stringGenderValue = [self.genderArray objectAtIndex:0];
            //self.genderIndex = 0;
        }
        else
            self.stringGenderValue = [self.genderArray objectAtIndex:row];
        //self.genderIndex = row;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.20 animations:^{
        CGRect newFrame = self.oldFrame;
        [textFieldGender resignFirstResponder];
        [textFieldDateOfBirth resignFirstResponder];
        [textFieldPassword resignFirstResponder];
        [textFieldReTypePassword resignFirstResponder];
        [self.view setFrame:newFrame];
    }completion:^(BOOL finished)
     {
         
         
     }];
}

- (IBAction)funcButtonBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)funcButtonSubmit:(id)sender
{
    if([self isValid]){
        [self callingRegisterApi];
    }
}

#pragma mark - Validation

-(BOOL)isValid{
    NSString *messageString = @"";
    BOOL valid = YES;
    if([textFieldDateOfBirth.text empty] ){
        messageString = @"Please enter date of birth";
        valid = NO;
    }
    else if ([textFieldPassword.text empty]){
        messageString = @"Please enter password";
        valid = NO;
    }
    else if ([textFieldPassword.text length]<6){
        messageString = @"Password should be minimum 6 characters";
        valid = NO;
    }
    else if ([textFieldReTypePassword.text empty]){
        messageString = @"Please enter confirm password";
        valid = NO;
    }
    else if (![textFieldPassword.text isEqualToString:textFieldReTypePassword.text]){
        messageString = @"Password and confirm password are not same";
        valid = NO;
    }
    if(![messageString empty]){
        UIAlertView *validationAlert = [[UIAlertView alloc] initWithTitle:AppName message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [validationAlert show];
    }
    return valid;
}

#pragma mark - Calling Register api

-(void)callingRegisterApi{
    NSString *passwordInSha1 = [self sha1:textFieldPassword.text];
    NSString *registerApiUrlString = [Baseurl stringByAppendingString:RegisterUrl];
    NSMutableDictionary *registerMutableDictionary = [[NSMutableDictionary alloc] init];
    [registerMutableDictionary setValue:self.nameString forKey:@"name"];
    [registerMutableDictionary setValue:self.phoneNumberString forKey:@"phone"];
    [registerMutableDictionary setValue:self.emailString forKey:@"email"];
    [registerMutableDictionary setValue:self.dobApiValueString forKey:@"dob"];
    NSString *genderStringId;
    if([self.stringGenderValue isEqualToString:[self.genderArray objectAtIndex:0]]){
        genderStringId = @"1";
    }
    else if([self.stringGenderValue isEqualToString:[self.genderArray objectAtIndex:1]]){
        genderStringId = @"2";
    }
    else {
        genderStringId = @"3";
    }
    [registerMutableDictionary setValue:genderStringId forKey:@"gender"];
    [registerMutableDictionary setValue:passwordInSha1 forKey:@"pwd"];
    NSLog(@"Gender %@",self.stringGenderValue);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:registerApiUrlString] withBody:registerMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response object;%@",responseObject);
        if([[responseObject valueForKey:StatusKey] isEqualToString:ERROR]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:[responseObject valueForKey:ErrorMessagekey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            [self callingSendOTPApi];
        }
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

#pragma mark - Password encryption

-(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

#pragma amrk - Setting OTP Page

-(void)settingOTPPage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ResetPasswordOTPVC *resetOTPPage = (ResetPasswordOTPVC *)[storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordOTPVC"];
    resetOTPPage.isfromRegistration = YES;
    [self.navigationController pushViewController:resetOTPPage animated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Calling Send OTP api

-(void)callingSendOTPApi{
    NSMutableDictionary *sendOtpDictionary = [[NSMutableDictionary alloc] init];
    [sendOtpDictionary setValue:self.phoneNumberString forKey:@"phone"];
    NSString *sendOTPUrlString = [Baseurl stringByAppendingString:ForgotPasswordUrlForMobileOTP];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:sendOTPUrlString] withBody:sendOtpDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response object;%@",responseObject);
           [self settingOTPPage];
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

- (void)viewDidAppear:(BOOL)animated{
    self.oldFrame = self.view.frame;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == textFieldDateOfBirth ) {
        [UIView animateWithDuration:0.20 animations:^{
            CGRect newFrame = self.oldFrame;
            newFrame.origin.y -= textFieldDateOfBirth.y-100;
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    else if (textField == textFieldPassword ) {
        [UIView animateWithDuration:0.30 animations:^{
            CGRect newFrame = self.oldFrame;
            newFrame.origin.y -= textFieldPassword.y-120;
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    else if (textField == textFieldReTypePassword ) {
        [UIView animateWithDuration:0.30 animations:^{
            CGRect newFrame = self.oldFrame;
            newFrame.origin.y -= textFieldReTypePassword.y-120;
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    
}

//self.Outlet_nameOFthegift.height
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == textFieldPassword){
        [textFieldReTypePassword becomeFirstResponder];
    }
    else if (textField == textFieldReTypePassword ) {
        
        [UIView animateWithDuration:0.20 animations:^{
            CGRect newFrame = self.oldFrame;
            [textFieldReTypePassword resignFirstResponder];
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
        
    return YES;
}


@end
