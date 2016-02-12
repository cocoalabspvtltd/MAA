//
//  AppoinmentDetailVC.m
//  MAA
//
//  Created by Cocoalabs India on 08/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AppoinmentDetailVC.h"

#import "PreviousAppoinmentCell.h"

@interface AppoinmentDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *previousAppointmentsArray;
@end

@implementation AppoinmentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAppointmentsDetailsApi];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews{
    
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

#pragma mark - Table View Datatsources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.previousAppointmentsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PreviousAppoinmentCell *cell = [self.previousAppointmentTableview dequeueReusableCellWithIdentifier:@"previousappointmentCell"forIndexPath:indexPath];
    cell.timeStampString = [[self.previousAppointmentsArray objectAtIndex:indexPath.row] valueForKey:@"timestamp"];
    cell.locationString = [[self.previousAppointmentsArray objectAtIndex:indexPath.row] valueForKey:@"location"];
    return cell;
}

- (IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getAppointmentsDetailsApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSLog(@"Access Token:%@",accessToken);
    NSString *getPatientsAppointmentsDetailUrlString = [Baseurl stringByAppendingString:GetuserAppointmentDetailsurl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:self.appointmentIdString forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getPatientsAppointmentsDetailUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        [self settingDoctorDetailsWithDictionary:[[responseObject valueForKey:Datakey] valueForKey:@"doctor_details"]];
        [self settingStatusWithstatuString:[[responseObject valueForKey:Datakey] valueForKey:@"status"]];
        [self settingTypeWithtypeString:[[responseObject valueForKey:Datakey] valueForKey:@"type"]];
        [self settingTimeStampString:[[responseObject valueForKey:Datakey] valueForKey:@"timestamp"]];
        self.previousAppointmentsArray = [[responseObject valueForKey:Datakey] valueForKey:@"previous_appointments"];
        
        [self.previousAppointmentTableview reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       
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

-(void)settingDoctorDetailsWithDictionary:(id)doctorDetails{
    self.doctorNameLabel.text = [doctorDetails valueForKey:@"name"];
    NSString *docctorProfileUrlString = [doctorDetails valueForKey:@"logo_image"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:docctorProfileUrlString]];
        UIImage *tempImage = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.doctorImageView.image = tempImage;
        }
                       );
    });
}


-(void)settingTypeWithtypeString:(NSString *)typeString{
    if([typeString isEqualToString:@"1"]){
        self.appontmentTypeLabel.text = @"Direct Appointment";
        //        self.playbutton.hidden = YES;
        //        self.playImageView.hidden = YES;
        //        self.closeButton.hidden = YES;
        //        self.closeImageView.hidden = YES;
        
    }
    else if ([typeString isEqualToString:@"2"]){
        self.appontmentTypeLabel.text = @"Text Chat";
        
    }
    else if ([typeString isEqualToString:@"3"]){
        self.appontmentTypeLabel.text = @"Audio Call";
    }
    else if ([typeString isEqualToString:@"4"]){
         self.appontmentTypeLabel.text = @"Video Call";
    }
}

-(void)settingStatusWithstatuString:(NSString *)statusString{
    if([statusString isEqualToString:@"1"]){
        self.leftStatusImageview.backgroundColor = [UIColor colorWithRed:0 green:0.588 blue:0.533 alpha:1];
    }
    else if ([statusString isEqualToString:@"2"]){
        self.leftStatusImageview.backgroundColor = [UIColor colorWithRed:0.827 green:0.184 blue:0.184 alpha:1];
    }
    else if ([statusString isEqualToString:@"3"]){
        self.leftStatusImageview.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1];
    }
}

-(void)settingTimeStampString:(NSString *)timeStampString{
    NSLog(@"Time Stamp String:%@",timeStampString);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSDate *currentDate = [dateFormatter dateFromString:timeStampString];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    [self comparingDateWithToday:timeStampString];
    NSLog(@"ConvertedDate:%@",[dateFormatter stringFromDate:currentDate]);
    [dateFormatter setDateFormat:@"MMM"];
    NSString *monthFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.monthLabel.text = monthFromCurrentDateString;
    [dateFormatter setDateFormat:@"HH:mm a"];
    NSString *timeStringFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.timeLabel.text = timeStringFromCurrentDateString;
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [self splittingDate:currentDate];
    
}

-(void)splittingDate:(NSDate *)timeDate{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay| NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:timeDate];
    NSInteger day = [components day];
    self.dayLabel.text = [NSString stringWithFormat:@"%02ld",(long)day];
}

-(void)comparingDateWithToday:(NSString *)comparingDateString{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy HH:mm a";
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *responseDate = [formatter dateFromString:comparingDateString];
    if([responseDate compare:today] == NSOrderedAscending ){
//        self.playbutton.hidden = YES;
//        self.playImageView.hidden = YES;
//        self.closeButton.hidden = YES;
//        self.closeImageView.hidden = YES;
    }
    else{
//        self.playbutton.hidden = NO;
//        self.playImageView.hidden = NO;
//        self.closeButton.hidden = NO;
//        self.closeImageView.hidden = NO;
    }
}


- (IBAction)startappointmentbuttonAction:(UIButton *)sender {
}

@end
