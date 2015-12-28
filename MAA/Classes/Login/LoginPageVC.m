//
//  LoginPageVC.m
//  MAA
//
//  Created by Roshith Balendran on 28/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//
//
#import "LoginPageVC.h"
#import "HomePageVC.h"
#import <CommonCrypto/CommonDigest.h>
#import "CLFacebookHandler/FacebookWrapper.h"

@interface LoginPageVC ()<UITextFieldDelegate>

@end

@implementation LoginPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[FacebookWrapper standardWrapper] addSessionChangedObserver:self];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)funcButtonLogin:(id)sender
{
    HomePageVC *homePage = [[HomePageVC alloc]init];
    [self.navigationController pushViewController:homePage animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textFieldEmail resignFirstResponder];
    [textFieldPassword resignFirstResponder];
}

- (IBAction)loginButtonAction:(UIButton *)sender {
    //if([self isValidLogIn]){
        [self callingLogInApi];
   // }
}
- (IBAction)facebookButtonAction:(UIButton *)sender {
    [[FacebookWrapper standardWrapper] openSessionWithAllowLoginUI:YES];
}


-(BOOL)isValidLogIn{
    BOOL valid = YES;
    NSString *alertMessage = @"";
    if([textFieldEmail.text empty]){
        alertMessage = @"Please enter emailId";
        valid = NO;
        [textFieldEmail becomeFirstResponder];
    }
    else if (![textFieldEmail.text validEmail]){
        alertMessage = @"Please enter a valid emailId";
        valid = NO;
        [textFieldEmail becomeFirstResponder];
    }
    else if ([textFieldPassword.text empty]){
        alertMessage = @"Please enter password";
        valid = NO;
        [textFieldPassword becomeFirstResponder];
    }
    if(![alertMessage empty]){
        UIAlertView *validationAlert = [[UIAlertView alloc] initWithTitle:AppName message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [validationAlert show];
    }
    return valid;
}

#pragma mark - Calling Log In Api

-(void)callingLogInApi{
    NSString *logInUrlString = [Baseurl stringByAppendingString:LogInUrl];
    NSMutableDictionary *logInDictionary = [[NSMutableDictionary alloc] init];
    NSString *passwordInSh1 = [self sha1:textFieldPassword.text];
   
    //[logInDictionary setValue:textFieldEmail.text forKey:@"uname"];
    [logInDictionary setValue:@"j@j.j" forKey:@"uname"];
    [logInDictionary setValue:@"jjjjjj" forKey:@"pwd"];
    //[logInDictionary setValue:passwordInSh1 forKey:@"pwd"];
    NSLog(@"Log In Dictionary:%@",logInDictionary);
    NSLog(@"Log In url:%@",logInUrlString);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:logInUrlString] withBody:logInDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"response Object;%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([[responseObject valueForKey:ErrorCodeKey] isEqualToString:@"invalid_user"]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:[responseObject valueForKey:ErrorMessagekey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        else{
            [[NSUserDefaults standardUserDefaults] setValue:[[responseObject valueForKey:Datakey] valueForKey:@"token"] forKey:ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self settingHomePage];
        }
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"Error Response:%@",errorResponse);
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
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

#pragma mark - Facebook session state change observer

- (void)fbSessionChanged:(NSNotification *)notification {
    NSDictionary *tempDictionary = notification.object;
    NSLog(@"Temp Dictionary:%@",tempDictionary);
    if(![[FacebookWrapper standardWrapper]isUserLoggedIn] ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[tempDictionary valueForKey:@"FaceBookError"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    else {
        [self callingRegisterApiWithDictionary:tempDictionary];
        //        if([[tempDictionary valueForKey:@"email"] isEqualToString:@""]){
        //            UIAlertView *noEmailFromFbAlert = [[UIAlertView alloc] initWithTitle:AppName message:NoEmailFromFBAlert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //            noEmailFromFbAlert.tag = 101;
        //            [noEmailFromFbAlert show];
        //        }
        //        else{
        //            NSMutableDictionary *userDetailsMutableDctionary = [[NSMutableDictionary alloc] init];
        //            [userDetailsMutableDctionary setObject:[tempDictionary objectForKey:@"email"] forKey:EmailIdKey];
        //            [userDetailsMutableDctionary setObject:@"" forKey:PasswordKey];
        //            self.userNameText = [tempDictionary objectForKey:@"email"];
        //            self.passwordText = @"";
        //            [userDetailsMutableDctionary setObject:[tempDictionary objectForKey:@"first_name"] forKey:FirstNameKey];
        //            [userDetailsMutableDctionary setObject:[tempDictionary objectForKey:@"last_name"] forKey:LastNameKey];
        //            [userDetailsMutableDctionary setObject:[self gettingUserNationality] forKey:NationalityKey];
        //            [userDetailsMutableDctionary setObject:[self gettingUserCOR] forKey:CountryOfResidenceKey];
        //            NSString *dateString;
        //            if([tempDictionary objectForKey:@"birthday"]){
        //                dateString = [tempDictionary objectForKey:@"birthday"];
        //            }
        //            else{
        //                dateString = [self gettingDOBOfUser];
        //            }
        //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        //            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        //            NSDate *dateFromString = [dateFormatter dateFromString:dateString];
        //
        //            NSNumber *dobmstime = [NSNumber numberWithLongLong:(long long)([dateFromString timeIntervalSince1970] * 1000.0)];
        //            [userDetailsMutableDctionary setObject:dobmstime forKey:DateOfBirthKey];
        //            if([[tempDictionary objectForKey:@"gender"] isEqualToString:@"female"]){
        //                [userDetailsMutableDctionary setObject:[NSNumber numberWithInt:1] forKey:GenderKey];
        //            }
        //            else{
        //                [userDetailsMutableDctionary setObject:[NSNumber numberWithInt:0] forKey:GenderKey];
        //            }
        //            [userDetailsMutableDctionary setObject:[self getPhoneNumber] forKey:PhoneNoKey];
        //            //            NSMutableDictionary *deviceDetailsMutableDctionary = [[NSMutableDictionary alloc] init];
        //            //            [deviceDetailsMutableDctionary setObject:@"1" forKey:@"uniqueId"];
        //            //            [deviceDetailsMutableDctionary setObject:@"tokenIdentifier" forKey:@"tokenIdentifier"];
        //            //            [deviceDetailsMutableDctionary setObject:@"0" forKey:@"deviceType"];
        //            //            [deviceDetailsMutableDctionary setObject:[NSNumber numberWithInt:1] forKey:@"notificationSettings"];
        //            //          [self showFacebookRegisterationView];
        //            //[self savingUserDataFromFBToLocalDatabase:tempDictionary];
        //            [self callingUserRegisterApiWithUserDetails:userDetailsMutableDctionary];
        //        }
        //    }
    }
}

#pragma mark - Facebook UserCancelled observer

- (void)fbUserCancelled:(NSNotification *)notification {
    
}

#pragma mark - Calling Register api

-(void)callingRegisterApiWithDictionary:(NSMutableDictionary *)dataDictionary{
    NSString *registerApiUrlString = [Baseurl stringByAppendingString:RegisterUrl];
    NSMutableDictionary *registerMutableDictionary = [[NSMutableDictionary alloc] init];
    [registerMutableDictionary setValue:[dataDictionary valueForKey:@"first_name"] forKey:@"name"];
    //    [registerMutableDictionary setValue:self.phoneNumberString forKey:@"phone"];
    //    [registerMutableDictionary setValue:self.emailString forKey:@"email"];
    //    [registerMutableDictionary setValue:textFieldDateOfBirth.text forKey:@"dob"];
    //    [registerMutableDictionary setValue:textFieldPassword.text forKey:@"pwd"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:registerApiUrlString] withBody:registerMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response Object:%@",responseObject);
        [self settingHomePage];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Error Description:%@",errorDescription);
    }];
}

#pragma mark - Setting Home Page

-(void)settingHomePage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarController = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [self.navigationController pushViewController:tabBarController animated:NO];
}


#pragma mark - TextFieldDeleagtes

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == textFieldEmail){
        [textFieldEmail resignFirstResponder];
        [textFieldPassword becomeFirstResponder];
        
    }
    else if (textField == textFieldPassword){
        [textFieldPassword resignFirstResponder];
    }
    return YES;
}
@end
