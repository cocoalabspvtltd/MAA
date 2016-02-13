//
//  ResetPasswordOTPVC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//
#import "OTPVerificationSuccessfulViewController.h"

#import "ResetPasswordVC.h"
#import "ResetPasswordOTPVC.h"
#import "SelectUsageViewController.h"

@interface ResetPasswordOTPVC ()

@end

@implementation ResetPasswordOTPVC

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
    [textFieldOTP resignFirstResponder];
}

- (IBAction)funcButtonBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)verifyButtonAction:(UIButton *)sender {
    if([self isValid]){
        [self OTPVerificationApi];
    }
}


#pragma mark - Validation

-(BOOL)isValid{
    BOOL valid = YES;
    NSString *errorMessageString = @"";
    if([textFieldOTP.text empty]){
        valid = NO;
        errorMessageString = @"Please enter your OTP";
        [textFieldOTP becomeFirstResponder];
    }
    if(![errorMessageString empty]){
        UIAlertView *validationAlert = [[UIAlertView alloc] initWithTitle:AppName message:errorMessageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [validationAlert show];
    }
    return valid;
}

#pragma mark - OTP Verification Api

-(void)OTPVerificationApi{
    NSString *verifyOTPUrlString = [Baseurl stringByAppendingString:VerifyOTPurl];
    NSMutableDictionary *verifyOTPDictionary = [[NSMutableDictionary alloc] init];
    [verifyOTPDictionary setValue:textFieldOTP.text forKey:@"otp"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:verifyOTPUrlString] withBody:verifyOTPDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([[responseObject valueForKey:StatusKey] isEqualToString:ERROR]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:[responseObject valueForKey:ErrorMessagekey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            if(self.isfromRegistration){
                [[NSUserDefaults standardUserDefaults] setValue:[[responseObject valueForKey:Datakey] valueForKey:@"token"] forKey:ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if(([[responseObject valueForKey:Datakey] valueForKey:@"user_type"] == [NSNull null])){
                    [self settingSelectusageViewControllerWithUserTypeStatus:YES wihTokenString:[[responseObject valueForKey:Datakey] valueForKey:@"token"]];
                }
                else{
                     [self settingSelectusageViewControllerWithUserTypeStatus:NO wihTokenString:[[responseObject valueForKey:Datakey] valueForKey:@"token"]];
                }
                //[self settingOTPverificationSeccessFulView];
            }
            else{
                [self settingResetPasswordVc];
            }
            
        }
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"error description:%@",errorDescription);
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

#pragma mark - Setting OTP Verification Sucessfulpage

-(void)settingOTPverificationSeccessFulView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    SelectUsageViewController *selectusageViewCntrlr = (SelectUsageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SelectUsageViewController"];
    [self.navigationController pushViewController:selectusageViewCntrlr animated:YES];
//    OTPVerificationSuccessfulViewController *otpverificationSuccessfulPage = (OTPVerificationSuccessfulViewController *)[storyboard instantiateViewControllerWithIdentifier:@"OTPVerificationSuccessfulViewController"];
//    [self.navigationController pushViewController:otpverificationSuccessfulPage animated:YES];
}

-(void)settingSelectusageViewControllerWithUserTypeStatus:(BOOL)isuserTypeStatusNull wihTokenString:(NSString *)tokenString{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    SelectUsageViewController *selectusageViewCntrlr = (SelectUsageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SelectUsageViewController"];
    selectusageViewCntrlr.isUsertypeStatusNull = isuserTypeStatusNull;
    selectusageViewCntrlr.tokenString = tokenString;
    [self.navigationController pushViewController:selectusageViewCntrlr animated:YES];
}

-(void)settingResetPasswordVc{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ResetPasswordVC *resetPasswordVC = (ResetPasswordVC *)[storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordVC"];
    
    [self.navigationController pushViewController:resetPasswordVC animated:YES];
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
