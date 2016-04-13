//
//  TimingsTableViewCell.m
//  MAA
//
//  Created by Cocoalabs India on 08/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "TimingsTableViewCell.h"

@implementation TimingsTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _directionButton.layer.borderWidth=.5;
    _directionButton.layer.cornerRadius=5;
    _directionButton.clipsToBounds=YES;
    _directionButton.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)directionsbuttonAction:(UIButton *)sender {
    if(self.timingCellDelegate &&[self.timingCellDelegate respondsToSelector:@selector(directionButtonActionWithTag:)]){
        [self.timingCellDelegate directionButtonActionWithTag:self.tag];
    }
}

-(void)setTimingsArray:(NSArray *)timingsArray{
    NSString *timingString = @"";
    for (int i = 0; i<timingsArray.count; i++) {
        timingString = [timingString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[timingsArray objectAtIndex:i]]];
    }
    self.availableDaysLabel.text = timingString;
    NSLog(@"Timings Array:%@",timingString);
}
@end
