//
//  ClinicProfVC.m
//  MAA
//
//  Created by Cocoalabs India on 22/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "ClinicProfVC.h"

@interface ClinicProfVC ()

@end

@implementation ClinicProfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _clinicProfileImage.layer.cornerRadius=_clinicProfileImage.frame.size.width/2;
    _clinicProfileImage.clipsToBounds=YES;
    _btnDirections.layer.borderWidth=0.5f;
    _btnDirections.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    [self callingGetClinicDetailsApi];
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
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)callingGetClinicDetailsApi{
    NSString *getEntityDetailsUrlString = [Baseurl stringByAppendingString:GetEntityDetailsUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getEntityDetailsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityDetailsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getEntityDetailsMutableDictionary setValue:self.entityId forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityDetailsUrlString] withBody:getEntityDetailsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Hospital Detilst;%@",responseObject);
        //self.hospitalDataDictionary = [responseObject valueForKey:Datakey];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self settingEntityDetailsWithData:[responseObject valueForKey:Datakey]];
        //[self.clinicTbableView reloadData];
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
    NSString *clinicProfileImageUrlString = [entityDetails valueForKey:@"logo_image"];
    [self.clinicProfileImage sd_setImageWithURL:[NSURL URLWithString:clinicProfileImageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    self.clinicNameLabel.text = [entityDetails valueForKey:@"name"];
    self.clinicDetail.text = [entityDetails valueForKey:@"tagline"];
    self.locationLabel.text = [[entityDetails valueForKey:@"location"] valueForKey:@"location_name"];
    self.consultationLabel.text = [NSString stringWithFormat:@"Rs. %@ consultation fee",[entityDetails valueForKey:@"average_fee"]];
    self.experienceLabel.text = [NSString stringWithFormat:@"%@ of experience",[entityDetails valueForKey:@"experience"]];
    self.noOfConsultationsLabel.text = [NSString stringWithFormat:@"%@ consultations",[entityDetails valueForKey:@"no_of_consultations"]];
    if(!([entityDetails valueForKey:@"rating"] == [NSNull null])){
        self.ratingLabel.text = [NSString stringWithFormat:@"%@ rating",[entityDetails valueForKey:@"rating"]];
    }
    else{
        self.ratingLabel.text = [NSString stringWithFormat:@"0 rating"];
    }
     self.reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews",[entityDetails valueForKey:@"no_of_reviews"]];
    if(!([entityDetails valueForKey:@"phone"] == [NSNull null])){
        self.contactNumberLabel.text = [NSString stringWithFormat:@"Contact number: %@",[entityDetails valueForKey:@"phone"]];
    }
   
    
    
//    self.satisfiedpeopleLabel.text = [NSString stringWithFormat:@"%@ satisfied people",[entityDetails valueForKey:@"no_of_consultations"]];
   
}

@end
