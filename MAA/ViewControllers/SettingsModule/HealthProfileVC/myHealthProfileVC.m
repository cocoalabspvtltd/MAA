//
//  myHealthProfileVC.m
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "myHealthProfileVC.h"

@interface myHealthProfileVC ()
{
    NSArray *BloodGrups;
    
}

@end

@implementation myHealthProfileVC

CGFloat ht=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    BloodGrups=@[@"O +",@"O -",@"A +",@"A -",@"B +",@"B -",@"AB +",@"AB -"];
    _tblDropDown.hidden=YES;
    [self callingHealthProfileApi];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return BloodGrups.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableIdentifier=@"TableItem";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    }
    
        
        cell.textLabel.text=[BloodGrups objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:(11.0)];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *x = BloodGrups[indexPath.row];
    [_btnDropDown setTitle:x forState:UIControlStateNormal];
    _tblDropDown.hidden=YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) viewDidLayoutSubviews
{

    CGFloat  height = self.ContentView.frame.size.height+50;
    
    [_scroller setContentSize:CGSizeMake(self.view.frame.size.width,height)];
    
}
- (IBAction)backbuttonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)editButtonAction:(UIButton *)sender {
}

- (IBAction)DropDown:(id)sender
{
    if (_tblDropDown.hidden==YES) {
        _tblDropDown.hidden=NO;
    }
    else
        _tblDropDown.hidden=YES;
}

#pragma mark - Calling Health Profile Api

-(void)callingHealthProfileApi{
    NSString *getAccountInfoApiUrlSrtring = [Baseurl stringByAppendingString:getAccountinfoApiurl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *healthinfoMutableDictionary = [[NSMutableDictionary alloc] init];
    NSArray *fieldArray = [NSArray arrayWithObjects:@"name",@"location",@"e_base_img",@"e_banner_img",@"dob",@"about",@"address",@"phone",@"gender",@"health_profile",@"images",@"medical_docs",@"prescription", nil];
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

-(void)populatingHealthDetailsWithResponsedata:(id)profileData{
    NSLog(@"Health Data:%@",profileData);
//    if(!([profileData valueForKey:@"e_base_img"] == [NSNull null])){
//        [self downloadingProfileImageWithUrlString:[profileData valueForKey:@"e_base_img"]];
//    }
//    if(!([profileData valueForKey:@"e_banner_img"] == [NSNull null])){
//        [self downloadingProfileBackgroundImageWithurlString:[profileData valueForKey:@"e_banner_img"]];
//    }
//    if(!([profileData valueForKey:@"name"] == [NSNull null])){
//        self.nameLabel.text = [profileData valueForKey:@"name"];
//    }
//    if(!([profileData valueForKey:@"location"] == [NSNull null])){
//        self.locationlabel.text = [profileData valueForKey:@"location"];
//    }
//    if(!([profileData valueForKey:@"address"] == [NSNull null])){
//        self.addresslabel.text = [profileData valueForKey:@"address"];
//    }
//    if(!([profileData valueForKey:@"phone"] == [NSNull null])){
//        self.phoneTextField.text = [profileData valueForKey:@"phone"];
//    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"weight"] == [NSNull null])){
        self.weightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"weight"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"height"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"height"];
    }
    if (!([[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"] == [NSNull null])){
        NSString *bloodGroup = [[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"];        [self.bloodGroupButton setTitle:bloodGroup forState:UIControlStateNormal];
    }
//    if(!([profileData valueForKey:@"dob"] == [NSNull null])){
//        self.dateOfBirthTextField.text = [profileData valueForKey:@"dob"];
//    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"] == [NSNull null])){
        self.lowBPtextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"] == [NSNull null])){
        self.hightextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"];
    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"fasting_sugar"] == [NSNull null])){
        self.fastingSugarTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"fasting_sugar"] ;
    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"post_meal_sugar"] == [NSNull null])){
        self.postMealSugarTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"post_meal_sugar"] ;
    }
//    self.userImagesArray = [profileData valueForKey:@"images"];
//    [self.photosCollectionView reloadData];
//    self.medicalDocumentsArray = [profileData valueForKey:@"medical_docs"];
//    [self.medicalDocumantsCollectionview reloadData];
//    self.prescriptionsArray = [profileData valueForKey:@"prescription"];
//    [self.prescriptionsTableView reloadData];
}
@end
