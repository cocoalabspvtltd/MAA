//
//  TakeAppointmentVC.m
//  MAA
//
//  Created by Cocoalabs India on 09/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MapVC.h"
#import "PaymentPageViewController.h"
#import "TakeAppointmentVC.h"

@interface TakeAppointmentVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
  
}
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (nonatomic, strong) NSArray *dateArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSIndexPath *previousDateSelectedIndex;
@property (nonatomic, strong) NSIndexPath *previousTimeSelectedIndex;

@end

@implementation TakeAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.previousTimeSelectedIndex = nil;
    self.previousDateSelectedIndex = nil;
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
        if(![[responseObject valueForKey:Datakey] isEqual:[NSNull null]]){
            self.dateArray = [[responseObject valueForKey:Datakey] valueForKey:@"timings"];
        }
        
        [self.datecollectionView reloadData];
        if(self.dateArray.count>0){
            self.previousDateSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
            self.timeArray = [[self.dateArray objectAtIndex:0] valueForKey:@"slots"];
            [self.timeCollectionview reloadData];
            UICollectionViewCell *currentCollectionViewCell = [self.datecollectionView cellForItemAtIndexPath:self.previousDateSelectedIndex];
            UILabel *labell = [currentCollectionViewCell viewWithTag:10];
            labell.textColor = [UIColor whiteColor];
            currentCollectionViewCell.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0.271 alpha:1]; /*#ff0045*/
            if(self.timeArray.count>0){
                self.previousTimeSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
                UICollectionViewCell *currentTimeCollectionViewCell = [self.timeCollectionview cellForItemAtIndexPath:self.previousTimeSelectedIndex];
                UIImageView *backGroundImg=[currentTimeCollectionViewCell viewWithTag:11];
                backGroundImg.backgroundColor =  [UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
                UILabel *labellx = [currentTimeCollectionViewCell viewWithTag:20];
                labellx.textColor = [UIColor whiteColor];
                self.addressLabel.text = [self.timeArray[self.previousTimeSelectedIndex.row] valueForKey:@"location"];
                self.locationButton.enabled = YES;
            }
            else{
                self.addressLabel.text = @"";
                self.locationButton.enabled = NO;
            }
        }
        else{
            self.addressLabel.text = @"";
            self.locationButton.enabled = NO;
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

#pragma mark - Collection View Datasources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.datecollectionView) {
        return self.dateArray.count;
    }
    else if (collectionView == self.timeCollectionview) {
        if(self.timeArray.count == 0){
            self.noResultsView.hidden = NO;
            self.timeCollectionview.hidden = YES;
        }
        else{
            self.noResultsView.hidden = YES;
            self.timeCollectionview.hidden = NO;
        }
        return self.timeArray.count;
    }
    return 1;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView==self.datecollectionView) {
        static NSString*cellident = @"cell1";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellident forIndexPath:indexPath];
        UILabel *labell = [cell viewWithTag:10];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *date = [dateFormatter dateFromString:[self.dateArray[indexPath.row] valueForKey:@"date"]];
        [dateFormatter setDateFormat:@"dd-MMM-yy"];
        labell.text = [dateFormatter stringFromDate:date];
        cell.layer.borderWidth=0.5f;
        cell.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
        if(indexPath != self.previousDateSelectedIndex){
            UILabel *labell = [cell viewWithTag:10];
            labell.textColor = [UIColor colorWithRed:1 green:0 blue:0.271 alpha:1]; /*#ff0045*/
            cell.backgroundColor = [UIColor whiteColor];
        }
        else{
            UILabel *labell = [cell viewWithTag:10];
            labell.textColor = [UIColor whiteColor]; /*#ff0045*/
            cell.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0.271 alpha:1]; /*#ff0045*/
            
        }
        
        return cell;
    }
    if (collectionView==self.timeCollectionview) {
        NSLog(@"Time Array;%@",self.timeArray[indexPath.item]);
        static NSString*cellident = @"cell2";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellident forIndexPath:indexPath];
       
        UIImageView *backGroundImg=[cell viewWithTag:11];
        backGroundImg.layer.cornerRadius = backGroundImg.frame.size.width / 2;
        backGroundImg.clipsToBounds = YES;
        backGroundImg.backgroundColor=[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
        backGroundImg.layer.borderWidth=.50f;
        UILabel *labellx = [cell viewWithTag:20];
        labellx.text = [self.timeArray[indexPath.item] valueForKey:@"time"];
        if([[self.timeArray[indexPath.item] valueForKey:@"status"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            backGroundImg.backgroundColor = [UIColor whiteColor];
            labellx.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
        }
        else{
            backGroundImg.backgroundColor = [UIColor grayColor];
            labellx.textColor = [UIColor whiteColor];
        }
        cell.layer.borderColor=[[UIColor colorWithRed:0.800 green:0.800 blue:0.812 alpha:1.00]CGColor];
        
        if(indexPath == self.previousTimeSelectedIndex){
            UIImageView *backGroundImg=[cell viewWithTag:11];
            backGroundImg.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
            UILabel *labellx = [cell viewWithTag:20];
            labellx.textColor = [UIColor whiteColor];
        }
        return cell;
    }
    UICollectionViewCell *cell;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.datecollectionView){
        if(self.previousDateSelectedIndex){
            UICollectionViewCell *prevoiusCollectionViewCell = [collectionView cellForItemAtIndexPath:self.previousDateSelectedIndex];
            UILabel *labell = [prevoiusCollectionViewCell viewWithTag:10];
            labell.textColor = [UIColor colorWithRed:1 green:0 blue:0.271 alpha:1]; /*#ff0045*/
            prevoiusCollectionViewCell.backgroundColor = [UIColor whiteColor];
        }
        UICollectionViewCell *currentCollectionViewCell = [collectionView cellForItemAtIndexPath:indexPath];
        UILabel *labell = [currentCollectionViewCell viewWithTag:10];
        labell.textColor = [UIColor whiteColor];
        currentCollectionViewCell.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0.271 alpha:1]; /*#ff0045*/
        self.previousDateSelectedIndex = indexPath;
        self.timeArray = [[self.dateArray objectAtIndex:indexPath.row] valueForKey:@"slots"];
        [self.timeCollectionview reloadData];
        if(self.timeArray.count>0){
            self.previousTimeSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
            UICollectionViewCell *currentTimeCollectionViewCell = [self.timeCollectionview cellForItemAtIndexPath:self.previousTimeSelectedIndex];
            UIImageView *backGroundImg=[currentTimeCollectionViewCell viewWithTag:11];
            backGroundImg.backgroundColor =  [UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
            UILabel *labellx = [currentTimeCollectionViewCell viewWithTag:20];
            labellx.textColor = [UIColor whiteColor];
            self.addressLabel.text = [self.timeArray[self.previousTimeSelectedIndex.row] valueForKey:@"location"];
            self.locationButton.enabled = YES;
        }
        else{
            self.addressLabel.text = @"";
            self.locationButton.enabled = NO;
        }
    }
    else if (collectionView == self.timeCollectionview){
        if([[self.timeArray[indexPath.item] valueForKey:@"status"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            if(self.previousTimeSelectedIndex){
                UICollectionViewCell *prevoiusTimeCollectionViewCell = [collectionView cellForItemAtIndexPath:self.previousTimeSelectedIndex];
                UIImageView *backGroundImg=[prevoiusTimeCollectionViewCell viewWithTag:11];
                backGroundImg.backgroundColor = [UIColor whiteColor];
                UILabel *labellx = [prevoiusTimeCollectionViewCell viewWithTag:20];
                labellx.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
            }
            UICollectionViewCell *currentCollectionViewCell = [collectionView cellForItemAtIndexPath:indexPath];
            UIImageView *backGroundImg=[currentCollectionViewCell viewWithTag:11];
            backGroundImg.backgroundColor =  [UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00];
            UILabel *labellx = [currentCollectionViewCell viewWithTag:20];
            labellx.textColor = [UIColor whiteColor];
            self.previousTimeSelectedIndex = indexPath;
        }
        if(!self.isfromClinic){
            self.addressLabel.text = [self.timeArray[self.previousTimeSelectedIndex.row] valueForKey:@"location"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Location:(id)sender {
    NSLog(@"Location:%@",self.locationDetails);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapVC *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"MapVC"];
    if(self.isfromClinic){
        mapVC.title = _headingString;
        mapVC.locationString = _headingString;
        mapVC.headingString =  _headingString;
        mapVC.locationDetailString = [self.locationDetails valueForKey:@"location_name"];
        if(!([self.locationDetails valueForKey:@"lat"] == [NSNull null]) ){
            mapVC.latitude = [[self.locationDetails valueForKey:@"lat"] floatValue];
        }
        if(!([self.locationDetails valueForKey:@"lng"] == [NSNull null]) ){
            mapVC.longitude = [[self.locationDetails valueForKey:@"lng"] floatValue];
        }

    }
    else{
        mapVC.title = _headingString;
        mapVC.headingString =  [NSString stringWithFormat:@"Dr. %@",self.headingString];
        mapVC.locationString = [[self.timeArray objectAtIndex:self.previousTimeSelectedIndex.row] valueForKey:@"location"];
        mapVC.locationDetailString = [[self.timeArray objectAtIndex:self.previousTimeSelectedIndex.row] valueForKey:@"address"];
        if(!([[self.timeArray objectAtIndex:self.previousTimeSelectedIndex.row] valueForKey:@"lat"] == [NSNull null]) ){
            mapVC.latitude = [[[self.timeArray objectAtIndex:self.previousTimeSelectedIndex.row] valueForKey:@"lat"]  floatValue];
        }
        if(!([[self.timeArray objectAtIndex:self.previousTimeSelectedIndex.row] valueForKey:@"lng"] == [NSNull null]) ){
            mapVC.latitude = [[[self.timeArray objectAtIndex:self.previousTimeSelectedIndex.row] valueForKey:@"lng"]  floatValue];
        }
    }
    mapVC.latitude = 10.015861;
    mapVC.longitude = 76.341867;
    [self.navigationController pushViewController:mapVC animated:YES];
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
    PaymentPageViewController *paymentVC = [[PaymentPageViewController alloc] init];
    [self.navigationController pushViewController:paymentVC animated:YES];
}

@end
