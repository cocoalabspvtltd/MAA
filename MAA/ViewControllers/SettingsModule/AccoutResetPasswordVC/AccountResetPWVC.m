//
//  AccountResetPWVC.m
//  MAA
//
//  Created by Cocoalabs India on 16/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AccountResetPWVC.h"
#import <CommonCrypto/CommonDigest.h>

@interface AccountResetPWVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *changeMyPasswordLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentPasswordHeightConstraint;

@end

@implementation AccountResetPWVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    if(self.isFromNewPassord){
        self.changeMyPasswordLabel.text = @"Create Password";
        self.currentPasswordHeightConstraint.constant = 0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
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

- (IBAction)submitButtonAction:(UIButton *)sender {
    if([self isValid]){
        [self callingResetPasswordApi];
    }
}


-(BOOL)isValid{
    BOOL valid = YES;
    NSString *messageString = @"";
    if([self.currentPasswordTextFiels.text empty]){
        valid = NO;
        [self.currentPasswordTextFiels becomeFirstResponder];
        messageString = @"Please enter current password";
    }
    else if([self.newpwdTextField.text empty]){
        valid = NO;
        [self.newpwdTextField becomeFirstResponder];
        messageString = @"Please enter password";
    }
    else if ([self.retyPasswordTextField.text empty]){
        valid = NO;
        [self.retyPasswordTextField becomeFirstResponder];
        messageString = @"Please enter confirm password";
    }
    else if (![self.newpwdTextField.text isEqualToString:self.retyPasswordTextField.text]){
        valid = NO;
        [self.newpwdTextField becomeFirstResponder];
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
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *editAccountInfoUrlString = [Baseurl stringByAppendingString:EditAccountInfoUrl];
    NSMutableDictionary *editAccountInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [editAccountInfoMutableDictionary setValue:[self sha1:self.currentPasswordTextFiels.text] forKey:@"old_pwd"];
    [editAccountInfoMutableDictionary setValue:[self sha1:self.newpwdTextField.text] forKey:@"pwd"];
    [editAccountInfoMutableDictionary setValue:tokenString forKey:@"token"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:editAccountInfoUrlString] withBody:editAccountInfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        if([[responseObject valueForKey:StatusKey] isEqualToString:@"error"]){
            [self callingAlertViewControllerWithMessageString:[responseObject valueForKey:@"error_message"]];
        }
        else{
            [self callingPushAlertViewControllerWithMessageString:@"Password reset successfully"];
        }
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

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField == self.currentPasswordTextFiels){
        [self.newpwdTextField becomeFirstResponder];
    }
    else if (textField == self.newpwdTextField){
        [self.retyPasswordTextField becomeFirstResponder];
    }
    return YES;
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


-(void)callingPushAlertViewControllerWithMessageString:(NSString *)alertMessage{
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

//_txtEnterCurrentPwd.layer.borderWidth=.5f;
//_txtEnterCurrentPwd.layer.cornerRadius=5;
//_txtEnterCurrentPwd.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
//
//_txtEnterNewPwd.layer.borderWidth=.5f;
//_txtEnterNewPwd.layer.cornerRadius=5;
//_txtEnterNewPwd.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
//
//_txtRetypePassword.layer.borderWidth=.5f;
//_txtRetypePassword.layer.cornerRadius=5;
//_txtRetypePassword.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];



@end
