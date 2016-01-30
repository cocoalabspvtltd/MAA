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
    NSArray *fieldArray = [NSArray arrayWithObjects:@"health_profile", nil];
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

-(void)populatingHealthDetailsWithResponsedata:(id)healthData{
    NSLog(@"Health Data:%@",healthData);
    if(!([[healthData valueForKey:@"health_profile"] valueForKey:@"weight"] == [NSNull null])){
        self.weightTextField.text = [[healthData valueForKey:@"health_profile"] valueForKey:@"weight"];
    }
    if (!([[healthData valueForKey:@"health_profile"] valueForKey:@"height"] == [NSNull null])){
        self.heightTextField.text = [[healthData valueForKey:@"health_profile"] valueForKey:@"height"];
    }
    if (!([[[healthData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"] == [NSNull null])){
        self.heightTextField.text = [[[healthData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"];
    }
    if (!([[healthData valueForKey:@"health_profile"] valueForKey:@"low_bp"] == [NSNull null])){
        self.heightTextField.text = [[healthData valueForKey:@"health_profile"] valueForKey:@"low_bp"];
    }
    if (!([[healthData valueForKey:@"health_profile"] valueForKey:@"high_bp"] == [NSNull null])){
        self.heightTextField.text = [[healthData valueForKey:@"health_profile"] valueForKey:@"high_bp"];
    }
//    if()
    NSLog(@"Height:%@",[[healthData valueForKey:@"health_profile"] valueForKey:@"height"]);
}

-(void)viewWillLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1600);
}
@end
