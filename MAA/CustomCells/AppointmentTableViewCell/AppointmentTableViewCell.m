//
//  AppointmentTableViewCell.m
//  MAA
//
//  Created by kiran on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AppointmentTableViewCell.h"

@implementation AppointmentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRightprofileImageurlString:(NSString *)rightprofileImageurlString{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:rightprofileImageurlString]];
        UIImage *tempImage = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.rightProfileImageView.image = tempImage;
        }
                       );
    });
}

-(void)setTimeStampString:(NSString *)timeStampString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSDate *currentDate = [dateFormatter dateFromString:timeStampString];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    //[self comparingDateWithToday:timeStampString];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSLog(@"ConvertedDate:%@",[dateFormatter stringFromDate:currentDate]);
    [dateFormatter setDateFormat:@"MMM"];
    NSString *monthFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.monthLabel.text = monthFromCurrentDateString;
    [dateFormatter setDateFormat:@"HH mm a"];
    NSString *timeStringFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.timeLabel.text = timeStringFromCurrentDateString;
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [self splittingDate:currentDate];
    
    self.playbutton.hidden = YES;
    self.playImageView.hidden = YES;
    self.closeButton.hidden = YES;
    self.closeImageView.hidden = YES;
    
}

-(void)splittingDate:(NSDate *)timeDate{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay| NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:timeDate];
    NSInteger day = [components day];
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",(long)day];
}

-(void)comparingDateWithToday:(NSString *)comparingDateString{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy HH:mm a";
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *responseDate = [formatter dateFromString:comparingDateString];
    if([responseDate compare:today] == NSOrderedAscending ){
        self.playbutton.hidden = YES;
        self.playImageView.hidden = YES;
        self.closeButton.hidden = YES;
        self.closeImageView.hidden = YES;
    }
    else{
        self.playbutton.hidden = NO;
        self.playImageView.hidden = NO;
        self.closeButton.hidden = NO;
        self.closeImageView.hidden = NO;
    }
}

-(void)setTypeString:(NSString *)typeString{
    if([typeString isEqualToString:@"1"]){
        self.appointmentTypeLabel.text = @"Direct Appointment";
        self.playbutton.hidden = YES;
        self.playImageView.hidden = YES;
        self.closeButton.hidden = YES;
        self.closeImageView.hidden = YES;
        
    }
    else if ([typeString isEqualToString:@"2"]){
       self.appointmentTypeLabel.text = @"Text Chat";
        
    }
    else if ([typeString isEqualToString:@"3"]){
       self.appointmentTypeLabel.text = @"Audio Call";
    }
    else if ([typeString isEqualToString:@"4"]){
        self.appointmentTypeLabel.text = @"Video Call";
    }
    
}

-(void)setStatusString:(NSString *)statusString{
    if([statusString isEqualToString:@"1"]){
        self.leftStatusImageView.backgroundColor = [UIColor colorWithRed:0 green:0.588 blue:0.533 alpha:1];
    }
    else if ([statusString isEqualToString:@"2"]){
        self.leftStatusImageView.backgroundColor = [UIColor colorWithRed:0.827 green:0.184 blue:0.184 alpha:1];
    }
    else if ([statusString isEqualToString:@"3"]){
        self.leftStatusImageView.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1];
    }
    
}

- (IBAction)closeButtonAction:(UIButton *)sender {
}
- (IBAction)plabuttonAction:(UIButton *)sender {
}
@end
