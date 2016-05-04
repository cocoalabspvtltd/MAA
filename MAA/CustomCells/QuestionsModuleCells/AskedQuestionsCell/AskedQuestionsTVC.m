//
//  AskedQuestionsTVC.m
//  MAA
//
//  Created by Cocoalabs India on 05/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AskedQuestionsTVC.h"

@implementation AskedQuestionsTVC

- (void)awakeFromNib {
    // Initialization code
    self.profileImageView.layer.borderWidth = 1;
    self.profileImageView.layer.borderColor = AppCommnRedColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
