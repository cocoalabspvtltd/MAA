//
//  ProfilePageVC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "HealthProfileVC.h"

@interface HealthProfileVC ()

@end

@implementation HealthProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callingHealthProfileApi];
    
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

-(void)callingHealthProfileApi{
    NSString *getAccountInfoApiUrlSrtring = [Baseurl stringByAppendingString:getAccountinfoApiurl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *healthinfoMutableDictionary = [[NSMutableDictionary alloc] init];
    NSArray *fieldArray = [NSArray arrayWithObjects:@"name",@"location",@"e_base_img",@"e_banner_img",@"dob",@"about",@"address",@"phone",@"gender",@"health_profile",@"images",@"medical_docs", nil];
    [healthinfoMutableDictionary setValue:accessToken forKey:@"token"];
    [healthinfoMutableDictionary setValue:fieldArray forKey:@"fields"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getAccountInfoApiUrlSrtring] withBody:healthinfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [self populatingHealthDetailsWithResponsedata:[responseObject valueForKey:Datakey]];
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


- (IBAction)editButtonAction:(UIButton *)sender {
}

-(void)populatingHealthDetailsWithResponsedata:(id)profileData{
    NSLog(@"Health Data:%@",profileData);
    if(!([profileData valueForKey:@"e_base_img"] == [NSNull null])){
        [self downloadingProfileImageWithUrlString:[profileData valueForKey:@"e_base_img"]];
    }
    if(!([profileData valueForKey:@"e_banner_img"] == [NSNull null])){
        [self downloadingProfileBackgroundImageWithurlString:[profileData valueForKey:@"e_banner_img"]];
    }
    if(!([profileData valueForKey:@"name"] == [NSNull null])){
        self.nameLabel.text = [profileData valueForKey:@"name"];
    }
    if(!([profileData valueForKey:@"location"] == [NSNull null])){
        self.locationlabel.text = [profileData valueForKey:@"location"];
    }
    if(!([profileData valueForKey:@"address"] == [NSNull null])){
        self.addresslabel.text = [profileData valueForKey:@"address"];
    }
    if(!([profileData valueForKey:@"phone"] == [NSNull null])){
        self.phoneTextField.text = [profileData valueForKey:@"phone"];
    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"weight"] == [NSNull null])){
        self.weightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"weight"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"height"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"height"];
    }
    if (!([[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"] == [NSNull null])){
        self.heightTextField.text = [[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"];
    }
    if(!([profileData valueForKey:@"dob"] == [NSNull null])){
        self.dateOfBirthTextField.text = [profileData valueForKey:@"dob"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"];
    }
}

-(void)viewWillLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1600);
}

-(void)downloadingProfileImageWithUrlString:(NSString *)profileImageUrlString{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/UserImages"];
    NSString *profileImageIdntifier = @"profileImage";
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:profileImageIdntifier];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:self.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrlString]];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:profileImageIdntifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.profileImageView.image = tempImage;
                [MBProgressHUD hideAllHUDsForView:self.profileImageView animated:YES];
            }
                           );
        });
    }
    else{
        self.profileImageView.image = localImage;
    }
}

-(void)downloadingProfileBackgroundImageWithurlString:(NSString *)profileBackUrlString{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/UserImages"];
    NSString *profileImageIdntifier = @"profileBackImage";
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:profileImageIdntifier];
    if(!localImage){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileBackUrlString]];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:profileImageIdntifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.profileBackgroundImageView.image = tempImage;
            }
                           );
        });
    }
    else{
        self.profileBackgroundImageView.image = localImage;
    }

}
@end
