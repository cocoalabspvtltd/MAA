//
//  DoctorProfileVC.m
//  MAA
//
//  Created by kiran on 02/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "CLToolKit/ImageCache.h"
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
    NSLog(@"Get Doctor Id;%@",self.entityId);
    NSString *getEntityDetailsUrlString = [Baseurl stringByAppendingString:GetEntityDetailsUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getEntityDetailsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityDetailsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getEntityDetailsMutableDictionary setValue:self.entityId forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityDetailsUrlString] withBody:getEntityDetailsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self settingEntityDetailsWithData:[responseObject valueForKey:Datakey]];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
         NSLog(@"Respnse Error;%@",errorResponse);
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


-(void)settingEntityDetailsWithData:(id)entityDetails{
    NSLog(@"Entity Details:%@",entityDetails);
    self.ratingLabel.text = [entityDetails valueForKey:@"rating"];
    self.experienceLabel.text = [entityDetails valueForKey:@"experience"];
    self.doctorNameLabel.text = [entityDetails valueForKey:@"name"];
    self.taglineLabel.text = [entityDetails valueForKey:@"tagline"];
    self.locationLabel.text = [[entityDetails valueForKey:@"location"] valueForKey:@"location_name"];
    self.consultationFeeLabel.text = [NSString stringWithFormat:@"Rs. %@ consultation fee",[entityDetails valueForKey:@"average_fee"]];
    self.satisfiedpeopleLabel.text = [NSString stringWithFormat:@"%@ satisfied people",[entityDetails valueForKey:@"no_of_consultations"]];
    self.reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews",[entityDetails valueForKey:@"no_of_reviews"]];
    [self settingProfileImageWithurlString:[entityDetails valueForKey:@"logo_image"] WithIdentifier:[entityDetails valueForKey:@"id"]];
    [self settingBannerImageWithurlString:[entityDetails valueForKey:@"banner_image"] WithIdentifier:[entityDetails valueForKey:@"id"]];
}

-(void)settingProfileImageWithurlString:(NSString *)urlString WithIdentifier:(id)identifier{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor"];
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:identifier];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:self.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:identifier];
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

-(void)settingBannerImageWithurlString:(NSString *)urlString WithIdentifier:(id)identifier{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor/Banner"];
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:identifier];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:self.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:identifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.coverImageView.image = tempImage;
                [MBProgressHUD hideAllHUDsForView:self.profileImageView animated:YES];
            }
                           );
        });
    }
    else{
        self.coverImageView.image = localImage;
    }
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
