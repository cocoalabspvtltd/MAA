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
    
}

-(void)setLocationString:(NSString *)locationString{
    self.locationLabel.text = locationString;
}
@end
