//
//  SelectUsageViewController.m
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define TypeCodeForRegisterAsAuser @"1"
#define TypeCodeForRegisterAsADoctor @"2"

#define Usertext @"You can use this application for Searching Doctors, to make Appointments With them, to Consult them Online, ask Health related questions and to review the Doctors"
#define RegisterdPractiotionarText @"Use can use this application for conducting online appointments with patients."

#import "DoctorRegistrationVC.h"
#import "SelectUsageViewController.h"

@interface SelectUsageViewController ()

@end

@implementation SelectUsageViewController

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
- (IBAction)proceddButtonAction:(UIButton *)sender {
    if([self.termsOfServiceButton isSelected]){
        if([self.doctoSelectionButton isSelected]){
            if(self.isUsertypeStatusNull){
                [self callingEditAccountInfoApiWithTypeString:TypeCodeForRegisterAsADoctor];
            }
        }
        else if ([self.userSelectionButton isSelected]){
            if(self.isUsertypeStatusNull){
                [self callingEditAccountInfoApiWithTypeString:TypeCodeForRegisterAsAuser];
            }
        }
    }
    else{
        UIAlertView *selecttermsAndServiceAlertview = [[UIAlertView alloc] initWithTitle:AppName message:@"Accept terms and conditions of service" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [selecttermsAndServiceAlertview show];
    }
}

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registeredPractitionerCheckButtonAction:(UIButton *)sender {
    self.descriptionLabel.text = RegisterdPractiotionarText;
     sender.selected = YES;
    self.userSelectionButton.selected = NO;
}

- (IBAction)userCheckButtonAction:(UIButton *)sender {
    self.descriptionLabel.text = Usertext;
    sender.selected = YES;
    self.doctoSelectionButton.selected = NO;
}

- (IBAction)termsofServiceButtonAction:(UIButton *)sender {
    if([sender isSelected]){
        sender.selected = NO;
    }
    else{
       sender.selected = YES;
    }
}

#pragma mark - Calling Edit Account Info api

-(void)callingEditAccountInfoApiWithTypeString:(NSString *)typeString{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *editAccountInfoUrlString = [Baseurl stringByAppendingString:EditAccountInfoUrl];
    NSMutableDictionary *editAccountInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [editAccountInfoMutableDictionary setValue:typeString forKey:@"type"];
    [editAccountInfoMutableDictionary setValue:self.tokenString forKey:@"token"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:editAccountInfoUrlString] withBody:editAccountInfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        if([typeString isEqualToString:TypeCodeForRegisterAsAuser]){
            [self settingHomePage];
        }
        else if([typeString isEqualToString:TypeCodeForRegisterAsADoctor]){
            [self settingDoctorRegistrationPage];
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

-(void)settingHomePage{
    [[NSUserDefaults standardUserDefaults] setValue:@"maaUser" forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowLogInScreenObserver object:nil];
 
}


-(void)settingDoctorRegistrationPage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    DoctorRegistrationVC *doctorRegistrationVC = (DoctorRegistrationVC *)[storyboard instantiateViewControllerWithIdentifier:@"DoctorRegistrationVC"];
    [self.navigationController pushViewController:doctorRegistrationVC animated:YES];
}
@end
