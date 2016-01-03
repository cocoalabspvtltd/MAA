//
//  ResetPasswordVC.m
//  MAA
//
//  Created by Cocoalabs India on 12/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "ResetPasswordVC.h"

@interface ResetPasswordVC ()<UITextFieldDelegate>

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)submitButtonAction:(UIButton *)sender {
    if([self isValid]){
        [self callingResetPasswordApi];
    }
}

-(BOOL)isValid{
    BOOL valid = YES;
    NSString *messageString = @"";
    if([self.passwordtextField.text empty]){
        valid = NO;
        [self.passwordtextField becomeFirstResponder];
        messageString = @"Please enter password";
    }
    else if ([self.retypPasswordTextField.text empty]){
        valid = NO;
        [self.retypPasswordTextField becomeFirstResponder];
        messageString = @"Please enter confirm password";
    }
    else if (![self.passwordtextField.text isEqualToString:self.retypPasswordTextField.text]){
        valid = NO;
        [self.passwordtextField becomeFirstResponder];
        messageString = @"Password and confirm password should be same";
    }
    if(![messageString empty]){
        UIAlertView *validationAlert = [[UIAlertView alloc] initWithTitle:AppName message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [validationAlert show];
    }
    return valid;
}

#pragma mark - Reset password api

-(void)callingResetPasswordApi{
    NSString *resetPasswordUrlString = [Baseurl stringByAppendingString:ResetPasswordUrl];
    NSMutableDictionary *resetPasswordMutableDictionary = [[NSMutableDictionary alloc] init];
    [resetPasswordMutableDictionary setValue:self.passwordtextField.text forKey:@"oldpassword"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:resetPasswordUrlString] withBody:resetPasswordMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler]startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object:%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([[responseObject valueForKey:StatusKey] isEqualToString:ERROR]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:[responseObject valueForKey:ErrorMessagekey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            [self.navigationController popToRootViewControllerAnimated:YES];
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
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Textfield Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == self.passwordtextField){
        [self.passwordtextField resignFirstResponder];
        [self.retypPasswordTextField becomeFirstResponder];
    }
    else if (textField == self.retypPasswordTextField){
        [self.retypPasswordTextField resignFirstResponder];
    }
    return YES;
}
@end
