//
//  ResetPasswordVC.m
//  MAA
//
//  Created by Cocoalabs India on 12/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "ResetPasswordVC.h"

@interface ResetPasswordVC ()

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


#pragma mark - Reset password api

-(void)callingResetPasswordView{
    NSString *resetPasswordUrlString = [Baseurl stringByAppendingString:ResetPasswordUrl];
    NSMutableDictionary *resetPasswordMutableDictionary = [[NSMutableDictionary alloc] init];
    [resetPasswordMutableDictionary setValue:@"" forKey:@"oldpassword"];
    [resetPasswordMutableDictionary setValue:@"" forKey:@"newpassword"];
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
