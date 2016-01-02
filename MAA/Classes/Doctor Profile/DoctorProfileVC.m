//
//  DoctorProfileVC.m
//  MAA
//
//  Created by kiran on 02/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorProfileVC.h"

@interface DoctorProfileVC ()

@end

@implementation DoctorProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
     [self customisation];
     [self addSubViews];
    [self callingGetDoctorDetailsApi];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    
}

-(void)customisation{
    
}

-(void)addSubViews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Entity Details Api

-(void)callingGetDoctorDetailsApi{
    NSString *getEntityDetailsUrlString = [Baseurl stringByAppendingString:GetEntityDetailsUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getEntityDetailsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityDetailsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getEntityDetailsMutableDictionary setValue:self.entityId forKey:@"id"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityDetailsUrlString] withBody:getEntityDetailsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Doctor Detilst;%@",responseObject);
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
         NSLog(@"Respnse Error;%@",errorResponse);
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
