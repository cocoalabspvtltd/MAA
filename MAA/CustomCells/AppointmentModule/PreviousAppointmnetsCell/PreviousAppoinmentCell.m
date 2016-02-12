//
//  PreviousAppoinmentCell.m
//  MAA
//
//  Created by Cocoalabs India on 08/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "PreviousAppoinmentCell.h"

@implementation PreviousAppoinmentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTimeStampString:(NSString *)timeStampString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSDate *currentDate = [dateFormatter dateFromString:timeStampString];
    //[dateFormatter setDateFormat:@"dd-MMM hh:mm a"];
    [dateFormatter setDateFormat:@"dd"];
    self.dayLabel.text = [dateFormatter stringFromDate:currentDate];
    [dateFormatter setDateFormat:@"MMM"];
    self.monthLabel.text = [dateFormatter stringFromDate:currentDate];
    [dateFormatter setDateFormat:@"hh:mm a"];
    self.timeLabel.text = [dateFormatter stringFromDate:currentDate];
}

-(void)setLocationString:(NSString *)locationString{
    self.locationLabel.text = locationString;
}
@end
