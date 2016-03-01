//
//  TMDCollectionViewCell.m
//  MAA
//
//  Created by Cocoalabs India on 24/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "TMDCollectionViewCell.h"

@implementation TMDCollectionViewCell

-(void)awakeFromNib{
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressTap:)];
    [self addGestureRecognizer:longGesture];
}

-(void)longPressTap:(UILongPressGestureRecognizer *)longGesture{
    if(self.tmdCellDelegate && [self.tmdCellDelegate respondsToSelector:@selector(longPressActionWithIndex:)]){
        [self.tmdCellDelegate longPressActionWithIndex:self.tag];
    }


}
-(void)setDocumentUrlString:(NSString *)documentUrlString{
    
}
@end
