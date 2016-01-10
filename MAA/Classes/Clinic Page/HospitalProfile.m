//
//  HospitalProfile.m
//  MAA
//
//  Created by kiran on 02/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#define SeparatorTabViewSelectedBackGroundColor [UIColor redColor]
#define SeparatorTabViewUnSelectedBackGroundColor [UIColor lightGrayColor]


#import "CLToolKit/ImageCache.h"
#import "HospitalFirstTabTVC.h"
#import "HospitalThirdTabTVC.h"
#import "HospitalProfile.h"

@interface HospitalProfile ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) BOOL isFirstTabSelected;
@property (nonatomic, assign) BOOL isSecondTabSelected;
@property (nonatomic, assign) BOOL isThirdTabSelected;
@property (nonatomic, strong) NSArray *reviewArray;
@property (nonatomic, strong) NSDictionary *hospitalDataDictionary;
@end

@implementation HospitalProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customisation];
    [self addSubViews];
    [self callingGetDoctorDetailsApi];
    // Do any additional setup after loading the view.
}
-(void)initialisation{
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.isFirstTabSelected = YES;
    self.isSecondTabSelected = NO;
    self.isThirdTabSelected = NO;

}

-(void)customisation{
    
}

-(void)addSubViews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callingGetDoctorDetailsApi{
    NSString *getEntityDetailsUrlString = [Baseurl stringByAppendingString:GetEntityDetailsUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getEntityDetailsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityDetailsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getEntityDetailsMutableDictionary setValue:self.entityId forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityDetailsUrlString] withBody:getEntityDetailsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Hospital Detilst;%@",responseObject);
        self.hospitalDataDictionary = [responseObject valueForKey:Datakey];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         [self settingEntityDetailsWithData:[responseObject valueForKey:Datakey]];
        [self.clinicTbableView reloadData];
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
    self.clinicNameLabel.text = [entityDetails valueForKey:@"name"];
    self.taglineLabel.text = [entityDetails valueForKey:@"tagline"];
    self.locationLabel.text = [[entityDetails valueForKey:@"location"] valueForKey:@"location_name"];
    self.consultationFeeLabel.text = [NSString stringWithFormat:@"Rs. %@ consultation fee",[entityDetails valueForKey:@"average_fee"]];
    self.satisfiedpeopleLabel.text = [NSString stringWithFormat:@"%@ satisfied people",[entityDetails valueForKey:@"no_of_consultations"]];
    self.reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews",[entityDetails valueForKey:@"no_of_reviews"]];
    [self settingProfileImageWithurlString:[entityDetails valueForKey:@"logo_image"] WithIdentifier:[entityDetails valueForKey:@"id"]];
    [self settingBannerImageWithurlString:[entityDetails valueForKey:@"banner_image"] WithIdentifier:[entityDetails valueForKey:@"id"]];
}

-(void)settingProfileImageWithurlString:(NSString *)urlString WithIdentifier:(id)identifier{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Clinic"];
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
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Clinic/Banner"];
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

- (IBAction)firstTabButtonAction:(UIButton *)sender {
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.secondTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.thirdTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.isFirstTabSelected = YES;
    self.isSecondTabSelected  = NO;
    self.isThirdTabSelected = NO;
    [self.clinicTbableView reloadData];
}
- (IBAction)secondTabButtonAction:(UIButton *)sender {
    self.secondTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.thirdTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.isFirstTabSelected = NO;
    self.isSecondTabSelected = YES;
    self.isThirdTabSelected = NO;
    
}
- (IBAction)thirdTabButtonAction:(UIButton *)sender {
    self.thirdTabSeparatorView.backgroundColor = SeparatorTabViewSelectedBackGroundColor;
    self.secondTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.firstTabSeparatorView.backgroundColor = SeparatorTabViewUnSelectedBackGroundColor;
    self.isFirstTabSelected = NO;
    self.isSecondTabSelected = NO;
    self.isThirdTabSelected = YES;
    [self callinggetEntityReviewssApi];
}

#pragma mark - Table view Data Sources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isFirstTabSelected){
        return 10;
    }
    else if (self.isSecondTabSelected){
        return 10;
    }
    else{
        return self.reviewArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isFirstTabSelected){
       // if(indexPath.row == 0){
            HospitalFirstTabTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cellClinicFirstTabCell"forIndexPath:indexPath];
            cell.phoneNumberLabel.text = [self.hospitalDataDictionary valueForKey:@"phone"];
            cell.AddressLabel.text = [[self.hospitalDataDictionary valueForKey:@"location"] valueForKey:@"location_name"];
            return cell;
      //  }
    }
    else if (self.isThirdTabSelected){
        HospitalThirdTabTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReviewCell"forIndexPath:indexPath];
        cell.reviewerNameLabel.text = [[self.reviewArray objectAtIndex:indexPath.row ] valueForKey:@"reviewer"];
         cell.reviewDescriptionLabel.text = [[self.reviewArray objectAtIndex:indexPath.row ] valueForKey:@"review"];
        cell.timeLabel.text = [[self.reviewArray objectAtIndex:indexPath.row ] valueForKey:@"time"];
        return cell;
    }
    return nil;
}

#pragma mark - Get Clinic Reviews Api

-(void)callinggetEntityReviewssApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *getEntityReviewsUrlString = [Baseurl stringByAppendingString:GetEntityReviewsurl];
    NSMutableDictionary *getEntityReviewsmutableDictionary = [[NSMutableDictionary alloc] init];
    [getEntityReviewsmutableDictionary setValue:accessToken forKey:@"token"];
    [getEntityReviewsmutableDictionary setValue:self.entityId forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.clinicTbableView animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getEntityReviewsUrlString] withBody:getEntityReviewsmutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.clinicTbableView animated:YES];
        self.reviewArray = [responseObject valueForKey:Datakey];
        [self.clinicTbableView reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"Error Description:%@",errorResponse);
        [MBProgressHUD hideAllHUDsForView:self.clinicTbableView animated:YES];
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

@end
