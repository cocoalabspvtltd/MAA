//
//  AccountSettingVC.m
//  MAA
//
//  Created by Cocoalabs India on 02/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AccountSettingVC.h"

@interface AccountSettingVC ()

@end

@implementation AccountSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callingGetAccountInfoApi];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    [ _scroller setContentSize:CGSizeMake(self.view.frame.size.width, 760)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)callingGetAccountInfoApi{
    NSString *getAccountInfoApiUrlSrtring = [Baseurl stringByAppendingString:getAccountinfoApiurl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *healthinfoMutableDictionary = [[NSMutableDictionary alloc] init];
    NSArray *fieldArray = [NSArray arrayWithObjects:@"name",@"location",@"e_base_img",@"e_banner_img",@"dob",@"about",@"address",@"phone",@"gender",@"images", nil];
    [healthinfoMutableDictionary setValue:accessToken forKey:@"token"];
    [healthinfoMutableDictionary setValue:fieldArray forKey:@"fields"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getAccountInfoApiUrlSrtring] withBody:healthinfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [self populatingProfileDetailsWithResponsedata:[responseObject valueForKey:Datakey]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response :%@",responseObject);
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

-(void)populatingProfileDetailsWithResponsedata:(id)profileData{
    if(!([profileData valueForKey:@"e_base_img"] == [NSNull null])){
        NSString *profileImageUrlString = [profileData valueForKey:@"e_base_img"];
        [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:profileImageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    }
    if(!([profileData valueForKey:@"e_banner_img"] == [NSNull null])){
        NSString *bannerImageUrlString = [profileData valueForKey:@"e_base_img"];
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:bannerImageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    }
    if(!([profileData valueForKey:@"name"] == [NSNull null])){
        self.namLabel.text = [profileData valueForKey:@"name"];
        self.nameTxtField.text = [profileData valueForKey:@"name"];
    }
    if(!([profileData valueForKey:@"location"] == [NSNull null])){
        self.localityTextField.text = [profileData valueForKey:@"location"];
    }
    if(!([profileData valueForKey:@"address"] == [NSNull null])){
        self.addressTextView.text = [profileData valueForKey:@"address"];
    }
    if(!([profileData valueForKey:@"phone"] == [NSNull null])){
        self.mobileNumberTextField.text = [profileData valueForKey:@"phone"];
    }
    if(!([profileData valueForKey:@"gender"] == [NSNull null])){
        NSString *genderTExt = [profileData valueForKey:@"gender"];
        if([genderTExt isEqualToString:@"1"]){
            self.maleRadioButton.selected  =YES;
        }
        else{
            self.femaleRadioButton.selected  =YES;
        }
    }
    if(!([profileData valueForKey:@"dob"] == [NSNull null])){
        self.dateOfBirthTextField.text = [profileData valueForKey:@"dob"];
    }
    
}

#pragma mark - Button Actions

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)maleRadioButtonAction:(UIButton *)sender {
    sender.selected = YES;
    self.femaleRadioButton.selected = NO;
    
}
- (IBAction)femaleRadioButtonAction:(UIButton *)sender {
    sender.selected  =YES;
    self.maleRadioButton.selected = NO;
}

- (IBAction)Edit:(id)sender {
    [self enablingInputFields];
}

- (IBAction)Submit:(id)sender {
}

- (IBAction)changeMypassword:(id)sender {
}

- (IBAction)locality:(id)sender {
}
#pragma mark - Enabling Input Fields

-(void)enablingInputFields{
    self.nameTxtField.enabled = YES;
    self.emailTesxtField.enabled  =YES;
    self.mobileNumberTextField.enabled = YES;
    self.maleRadioButton.enabled = YES;
    self.femaleRadioButton.enabled = YES;
    self.dateOfBirthTextField.enabled  =YES;
    self.cityTExtField.enabled  =YES;
    self.localityTextField.enabled  =YES;
    self.addressTextView.editable = YES;
    self.submitButton.enabled = YES;
}

-(void)disablingInputFields{
    
}
@end
