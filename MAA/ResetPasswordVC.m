//
//  ResetPasswordVC.m
//  MAA
//
//  Created by Cocoalabs India on 12/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "ResetPasswordVC.h"
#import <CommonCrypto/CommonDigest.h>

@interface ResetPasswordVC ()<UITextFieldDelegate>
@property (nonatomic,assign)CGRect oldFrame;
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

#pragma mark - Calling Edit Account Info api

-(void)callingResetPasswordApi{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *editAccountInfoUrlString = [Baseurl stringByAppendingString:EditAccountInfoUrl];
    NSMutableDictionary *editAccountInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [editAccountInfoMutableDictionary setValue:[self sha1:self.passwordtextField.text] forKey:@"pwd"];
   // [editAccountInfoMutableDictionary setValue:self.tokenString forKey:@"token"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:editAccountInfoUrlString] withBody:editAccountInfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        [self.navigationController popToRootViewControllerAnimated:YES];
        UIAlertView *passwordresetSuccessfulAlert = [[UIAlertView alloc] initWithTitle:AppName message:@"Password reset successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [passwordresetSuccessfulAlert show];
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
    }];
}

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    self.oldFrame = self.view.frame;
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.20 animations:^{
        CGRect newFrame = self.oldFrame;
        [self.view setFrame:newFrame];
        [self.passwordtextField resignFirstResponder];
        [self.retypPasswordTextField resignFirstResponder];
        
    }completion:^(BOOL finished)
     {
         
     }];
   
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.passwordtextField ) {
        [UIView animateWithDuration:0.20 animations:^{
            CGRect newFrame = self.oldFrame;
            newFrame.origin.y -= self.passwordtextField.y-100;
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    else if (textField == self.retypPasswordTextField ) {
        [UIView animateWithDuration:0.30 animations:^{
            CGRect newFrame = self.oldFrame;
            newFrame.origin.y -= self.retypPasswordTextField.y-120;
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    
}

//self.Outlet_nameOFthegift.height
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.passwordtextField){
        [self.retypPasswordTextField becomeFirstResponder];
    }
    else{
    [UIView animateWithDuration:0.20 animations:^{
        CGRect newFrame = self.oldFrame;
        [self.retypPasswordTextField resignFirstResponder];
        [self.view setFrame:newFrame];
    }completion:^(BOOL finished)
     {
         
     }];
    }
    return YES;
}

@end
