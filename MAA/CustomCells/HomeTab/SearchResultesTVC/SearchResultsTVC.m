//
//  SearchResultsTVC.m
//  MAA
//
//  Created by Roshith on 14/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "SearchResultsTVC.h"

@implementation SearchResultsTVC

- (void)awakeFromNib {
    self.cellImageViewOnlineStatus.layer.cornerRadius = 5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
