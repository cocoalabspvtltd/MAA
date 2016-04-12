//
//  TakeAppointmentVC.m
//  MAA
//
//  Created by Cocoalabs India on 09/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "TakeAppointmentVC.h"

@interface TakeAppointmentVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *coll1;
    NSArray *coll2;
}
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;

@end

@implementation TakeAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    coll1 = [NSArray arrayWithObjects:@"March 16",@"March 17",@"March 18",@"March 19",@"March 20",@"March 21", nil];
    coll2 = [NSArray arrayWithObjects:@"10:30 am",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00",@"10:30",@"11:00",@"12:00", nil];
    _btnBookNow.layer.borderWidth=0.5f;
    _btnBookNow.layer.borderColor=[[UIColor whiteColor]CGColor];
    _imgProfile.layer.cornerRadius = _imgProfile.frame.size.width / 2;
    _imgProfile.clipsToBounds = YES;
    [self initialisingDetails];
    [self callingGetAppointmentTimeSlotsApi];
}

-(void)initialisingDetails{
    if(self.isfromClinic){
        self.headingLabel.text = self.headingString;
    }
    else{
        self.headingLabel.text = [NSString stringWithFormat:@"Dr. %@",self.headingString];
    }
    [self.imgProfile sd_setImageWithURL:[NSURL URLWithString:self.profileImageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    if(self.isfromClinic){
        self.addressLabel.text = [self.locationDetails valueForKey:@"location_name"];
    }
    else{
        self.addressLabel.text = [self.locationDetails valueForKey:@"clinic_name"];
    }
    
}

-(void)callingGetAppointmentTimeSlotsApi{
    NSString *getTimeSlotsUrlString = [Baseurl stringByAppendingString:getAppointmentTimeSlotsApiUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getTimeSlotsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getTimeSlotsMutableDictionary setValue:accesstoken forKey:@"token"];
    [getTimeSlotsMutableDictionary setValue:self.entityIDString forKey:@"entity_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getTimeSlotsUrlString] withBody:getTimeSlotsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response object:%@",responseObject);
      
        // self.clinicDetailsArray = [[responseObject valueForKey:Datakey] valueForKey:@"clinic_details"];
        // self.servicesArray = [[responseObject valueForKey:Datakey] valueForKey:@"attributes"];
        //NSLog(@"Services Array:%@",self.servicesArray);
        // [self.doctoDetailsTableView reloadData];
        
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

#pragma mark - Collection View Datasources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.datecollectionView) {
        return coll1.count;
    }
    if (collectionView == self.timeCollectionview) {
        return coll2.count;
    }
    return 1;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView==self.datecollectionView) {
        
        static NSString*cellident = @"cell1";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellident forIndexPath:indexPath];
        UILabel *labell = [cell viewWithTag:10];
        labell.text = coll1[indexPath.item];
        cell.layer.borderWidth=0.5f;
        cell.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
        
        return cell;
    }
    if (collectionView==self.timeCollectionview) {
        
        static NSString*cellident = @"cell2";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellident forIndexPath:indexPath];
        
        UIImageView *backGroundImg=[cell viewWithTag:11];
        backGroundImg.layer.cornerRadius = backGroundImg.frame.size.width / 2;
        backGroundImg.clipsToBounds = YES;
        backGroundImg.backgroundColor=[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
        backGroundImg.layer.borderWidth=.50f;
        
        cell.layer.borderColor=[[UIColor colorWithRed:0.800 green:0.800 blue:0.812 alpha:1.00]CGColor];
        UILabel *labellx = [cell viewWithTag:20];
        labellx.text = coll2[indexPath.item];
        
        return cell;
    }
    UICollectionViewCell *cell;
    return cell;
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
- (IBAction)bookNowButtonAction:(UIButton *)sender {
}

@end
