//
//  SignUpPage1VC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "SignUpPage2VC.h"
#import "SignUpPage1VC.h"
#import "LoginPageVC.h"

@interface SignUpPage1VC ()<UITextFieldDelegate>

@end

@implementation SignUpPage1VC

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
    [textFieldName resignFirstResponder];
    [textFieldPhone resignFirstResponder];
    [textFieldEmail resignFirstResponder];
}

- (IBAction)funcButtonBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonAction:(UIButton *)sender {
    if([self isValid]){
        [self callingCheckEmailApi];
    }
}


-(BOOL)isValid{
    BOOL valid = YES;
    NSString *messageString = @"";
    if([textFieldName.text empty]){
        valid = NO;
        [textFieldName becomeFirstResponder];
        messageString = @"Please enter user name";
    }
    else if ([textFieldPhone.text empty]){
        valid = NO;
        [textFieldPhone becomeFirstResponder];
        messageString = @"Please enter phone number";
    }
    else if (![textFieldPhone.text validateMobile]){
        valid = NO;
        [textFieldPhone becomeFirstResponder];
        messageString = @"Please enter valid phone number";
    }
    else if ([textFieldEmail.text empty]){
        valid = NO;
        [textFieldEmail becomeFirstResponder];
        messageString = @"Please enter email id";
    }
    else if (![textFieldEmail.text validEmail]){
        valid = NO;
        [textFieldEmail becomeFirstResponder];
        messageString = @"Please enter valid email id";
    }
    if(![messageString empty]){
        UIAlertView *validationAlert = [[UIAlertView alloc] initWithTitle:AppName message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [validationAlert show];
    }
    return valid;
}

#pragma mark - Pushing Signup2 vc

-(void)passingDatatoSignUpPage2VC{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpPage2VC *signUp2 = (SignUpPage2VC *)[storyboard instantiateViewControllerWithIdentifier:@"SignUpPage2VC"];
    //SignUpPage2VC *signUp2 = [[SignUpPage2VC alloc] init];
    signUp2.nameString = textFieldName.text;
    signUp2.phoneNumberString = textFieldPhone.text;
    signUp2.emailString = textFieldEmail.text;
    [self.navigationController pushViewController:signUp2 animated:YES];
}

#pragma mark - Calling Check Email Api

-(void)callingCheckEmailApi{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *checkEmailUrlString = [Baseurl stringByAppendingString:CheckEmailExistUrl];
    NSMutableDictionary *checkEmailmutableDictionary = [[NSMutableDictionary alloc] init];
    [checkEmailmutableDictionary setValue:textFieldEmail.text forKey:@"email"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:checkEmailUrlString] withBody:checkEmailmutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([[responseObject valueForKey:StatusKey] isEqualToString:ERROR]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:[responseObject valueForKey:ErrorMessagekey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            [self passingDatatoSignUpPage2VC];
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


#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == textFieldName){
        [textFieldName resignFirstResponder];
        [textFieldPhone becomeFirstResponder];
    }
    else if (textField == textFieldEmail){
        [textFieldEmail resignFirstResponder];
    }
    return YES;
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
