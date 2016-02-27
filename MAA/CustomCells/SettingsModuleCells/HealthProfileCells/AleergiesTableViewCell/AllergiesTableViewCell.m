//
//  AllergiesTableViewCell.m
//  MAA
//
//  Created by Cocoalabs India on 27/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AllergiesTableViewCell.h"

@implementation AllergiesTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressTap:)];
    [self addGestureRecognizer:longGesture];
}

-(void)longPressTap:(UILongPressGestureRecognizer *)longGesture{
    if(self.allergiesCellDelegate && [self.allergiesCellDelegate respondsToSelector:@selector(longPressGestureActionWithCellTag:)]){
        [self.allergiesCellDelegate longPressGestureActionWithCellTag:self.tag];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
