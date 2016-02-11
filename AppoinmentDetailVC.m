//
//  AppoinmentDetailVC.m
//  MAA
//
//  Created by Cocoalabs India on 08/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AppoinmentDetailVC.h"

@interface AppoinmentDetailVC ()

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


-(void)settingTimeStampString:(NSString *)timeStampString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm a"];
    NSDate *currentDate = [dateFormatter dateFromString:timeStampString];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm a"];
    [self comparingDateWithToday:timeStampString];
    NSLog(@"ConvertedDate:%@",[dateFormatter stringFromDate:currentDate]);
    [dateFormatter setDateFormat:@"MMM"];
    NSString *monthFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    //self.monthLabel.text = monthFromCurrentDateString;
    [dateFormatter setDateFormat:@"HH mm a"];
    NSString *timeStringFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    //self.timeLabel.text = timeStringFromCurrentDateString;
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [self splittingDate:currentDate];
    
}

-(void)splittingDate:(NSDate *)timeDate{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay| NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:timeDate];
    NSInteger day = [components day];
   // self.dayLabel.text = [NSString stringWithFormat:@"%ld",(long)day];
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

-(void)settingTypeString:(NSString *)typeString{
    if([typeString isEqualToString:@"1"]){
//        self.appointmentTypeLabel.text = @"Direct Appointment";
//        self.playbutton.hidden = YES;
//        self.playImageView.hidden = YES;
//        self.closeButton.hidden = YES;
//        self.closeImageView.hidden = YES;
        
    }
    else if ([typeString isEqualToString:@"2"]){
        //self.appointmentTypeLabel.text = @"Text Chat";
        
    }
    else if ([typeString isEqualToString:@"3"]){
        //self.appointmentTypeLabel.text = @"Audio Call";
    }
    else if ([typeString isEqualToString:@"4"]){
       // self.appointmentTypeLabel.text = @"Video Call";
    }
    
}


@end
