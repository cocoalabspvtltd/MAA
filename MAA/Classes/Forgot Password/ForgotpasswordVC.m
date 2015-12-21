//
//  ForgotpasswordVC.m
//  MAA
//
//  Created by Roshith Balendran on 28/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "ResetPasswordOTPVC.h"
#import "EmailSentVC.h"
#import "ForgotpasswordVC.h"

@interface ForgotpasswordVC ()

@end

@implementation ForgotpasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textFieldEmail resignFirstResponder];
    [textFieldPhone resignFirstResponder];
}

- (IBAction)funcButtonBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextButtonAction:(id)sender {
    if([self isValid]){
        // [self callingForgotPasswordApi];
    }
}

#pragma mark - Validation

-(BOOL)isValid{
    BOOL valid = YES;
    NSString *alertMessage = @"";
    if([textFieldEmail.text empty]&&[textFieldPhone.text empty]){
        alertMessage = @"Please enter either email or phone number";
        valid = NO;
    }
    else if ([textFieldEmail.text length]>0 && [textFieldPhone.text length]>0){
        alertMessage = @"Please enter either email or phone number";
        valid = NO;
    }
    else if([textFieldEmail.text length]>0){
        if (![textFieldEmail.text validEmail]){
            alertMessage = @"Please enter valid email id";
            valid = NO;
        }
        else{
            [self callingForgotPasswordEmailApi];
        }
    }
    else if ([textFieldPhone.text length]>0){
        if(![textFieldPhone.text validateMobile]){
            alertMessage = @"Please enter valid mobile number";
            valid = NO;
        }
        else{
            [self callingForgotPasswordMobileOTPApi];
        }
    }
    if(![alertMessage empty]){
        UIAlertView *validationAlert = [[UIAlertView alloc] initWithTitle:AppName message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [validationAlert show];
    }
    return valid;
}

#pragma mark - Forgot password email api

-(void)callingForgotPasswordEmailApi{
    NSString *forgotPasswordUrlString = [Baseurl stringByAppendingString:ForgotPasswordUrlForEmail];
    NSMutableDictionary *forgotPasswordmutableDictionary = [[NSMutableDictionary alloc] init];
    [forgotPasswordmutableDictionary setValue:textFieldEmail.text forKey:@"email"];
    NSLog(@"Forgot Password url string:%@",forgotPasswordUrlString);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:forgotPasswordUrlString] withBody:forgotPasswordmutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler]startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([[responseObject valueForKey:StatusKey] isEqualToString:ERROR]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:[responseObject valueForKey:ErrorMessagekey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            [self settingEmailSentShowVC];
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

#pragma mark - Forgot password mobile OTP api

-(void)callingForgotPasswordMobileOTPApi{
    NSString *forgotPasswordMobileString = [Baseurl stringByAppendingString:ForgotPasswordUrlForMobileOTP];
    NSMutableDictionary *forgotPasswordMobileApiDictionary = [[NSMutableDictionary alloc] init];
    [forgotPasswordMobileApiDictionary setValue:textFieldPhone.text forKey:@"phone"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:forgotPasswordMobileString] withBody:forgotPasswordMobileApiDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([[responseObject valueForKey:StatusKey] isEqualToString:ERROR]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:[responseObject valueForKey:ErrorMessagekey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            [self settingResetPasswordOTPVCSetting];
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

#pragma mark - Setting Email Sent Show VC

-(void)settingEmailSentShowVC{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EmailSentVC *emailSentShowPage = (EmailSentVC *)[storyboard instantiateViewControllerWithIdentifier:@"EmailSentShowVC"];
    [self.navigationController pushViewController:emailSentShowPage animated:YES];
}

#pragma mark - Setting OTPVC Setting

-(void)settingResetPasswordOTPVCSetting{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ResetPasswordOTPVC *resetPasswordOTPVC = (ResetPasswordOTPVC *)[storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordOTPVC"];
    [self.navigationController pushViewController:resetPasswordOTPVC animated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
