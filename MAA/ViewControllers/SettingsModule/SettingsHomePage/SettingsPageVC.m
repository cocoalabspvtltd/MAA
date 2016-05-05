//
//  SettingsPageVC.m
//  MAA
//
//  Created by Vineeth Vijayan on 28/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "FeedBackVC.h"
#import "SettingsPageVC.h"
#import "AccountSettingVC.h"
#import "WebViewController.h"
#import "myHealthProfileVC.h"
#import "AboutViewController.h"
#import "InvoiceViewController.h"
#import "doctorReviewsViewController.h"
#import "CLFacebookHandler/FacebookWrapper.h"


#import "SettingsTableViewCell.h"

@interface SettingsPageVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingsPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view.
    
}

//- (void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.navigationItem.hidesBackButton = YES;
//}

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

#pragma mark - Tbale View Data Sources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingsTableViewCell *settingsTVC = [tableView dequeueReusableCellWithIdentifier:@"settingsReusableCell"forIndexPath:indexPath];
    if(indexPath.row == 0){
        settingsTVC.headingLabel.text = @"My Health Profile";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"ecg-heart-red"];
    }
    else if (indexPath.row == 1){
        settingsTVC.headingLabel.text = @"Account Settings";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"settingsred"];
    }
    else if (indexPath.row == 2){
        settingsTVC.headingLabel.text = @"My Reviews";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"myreview"];
    }
    else if (indexPath.row == 3){
        settingsTVC.headingLabel.text = @"Invoices";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"invoice"];
    }
    else if (indexPath.row == 4){
        settingsTVC.headingLabel.text = @"About";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"aboutred"];
    }
    else if (indexPath.row == 5){
        settingsTVC.headingLabel.text = @"Feedback";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"feedback"];
    }
    else if (indexPath.row == 6){
        settingsTVC.headingLabel.text = @"Sign Out";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"logout"];
    }
    
    return settingsTVC;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(indexPath.row == 0){
        myHealthProfileVC *healthProfileVC = (myHealthProfileVC *)[storyboard instantiateViewControllerWithIdentifier:@"myHealthProfileVC"];
        [self.navigationController pushViewController:healthProfileVC animated:YES];
    }
    else if (indexPath.row == 1){
        AccountSettingVC *accountSettingsVC = (AccountSettingVC *)[storyboard instantiateViewControllerWithIdentifier:@"AccountSettingVC"];
        accountSettingsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:accountSettingsVC animated:YES];
    }
    else if (indexPath.row == 2){
        doctorReviewsViewController *doctorReviewsVC = (doctorReviewsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"doctorReviewsViewController"];
        doctorReviewsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:doctorReviewsVC animated:YES];
    }
    else if (indexPath.row == 3){
        InvoiceViewController *invoiceVC = (InvoiceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"InvoiceViewController"];
        invoiceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:invoiceVC animated:YES];
    }
    else if (indexPath.row == 4){
        AboutViewController *aboutVC = (AboutViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    else if (indexPath.row==5)
    {
        FeedBackVC *feedbackVC = (FeedBackVC *)[storyboard instantiateViewControllerWithIdentifier:@"FeedBackVC"];
        feedbackVC.hidesBottomBarWhenPushed  =YES;
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }
    else if(indexPath.row == 6){
        [self callingLogoutAlertViewController];
    }
}

#pragma mark - Calling Alert View Controller

-(void)callingLogoutAlertViewController{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:@"Are you sure want to logout?"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   [self callingSignOutApi];
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Calling Logout Api

-(void)callingSignOutApi{
    NSString *logoutApiUrlSrtring = [Baseurl stringByAppendingString:logoutApiUrl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *logoutMutableDictionary = [[NSMutableDictionary alloc] init];
    [logoutMutableDictionary setValue:accessToken forKey:@"token"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:logoutApiUrlSrtring] withBody:logoutMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self implementingLogot];
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

-(void)implementingLogot{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[FacebookWrapper standardWrapper] logoutFBSession];
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowLogInScreenObserver object:nil];
 }

#pragma mark-Tap Gesture Action

- (IBAction)termsAndConditionsTapgestureAction:(UITapGestureRecognizer *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.urlString = @"https://google.com";
    webViewController.headingString = @"Terms and Conditions";
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end
