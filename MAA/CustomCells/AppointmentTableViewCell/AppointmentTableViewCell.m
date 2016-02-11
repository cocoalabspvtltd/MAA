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
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm a"];
    NSDate *currentDate = [dateFormatter dateFromString:timeStampString];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm a"];
    NSLog(@"ConvertedDate:%@",[dateFormatter stringFromDate:currentDate]);
    [dateFormatter setDateFormat:@"MMM"];
    NSLog(@"%@",[dateFormatter stringFromDate:currentDate]);
    NSString *monthFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.monthLabel.text = monthFromCurrentDateString;
    [dateFormatter setDateFormat:@"HH mm a"];
    NSString *timeStringFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.timeLabel.text = timeStringFromCurrentDateString;
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [self splittingDate:currentDate];
    
}

-(void)splittingDate:(NSDate *)timeDate{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay| NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:timeDate];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour];
    NSInteger min = [components minute];
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",(long)day];
    NSLog(@"YEar:%ld",(long)year);
    NSLog(@"YEar:%ld",(long)month);
     NSLog(@"YEar:%ld",(long)day);
     NSLog(@"Hour:%ld",(long)hour);
     NSLog(@"minute:%ld",(long)min);
}
@end
