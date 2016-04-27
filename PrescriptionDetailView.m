//
//  PrescriptionDetailView.m
//  MAA
//
//  Created by Cocoalabs India on 27/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "PrescriptionDetailView.h"

@interface PrescriptionDetailView()<UIScrollViewDelegate>

@end

@implementation PrescriptionDetailView

-(void)awakeFromNib
{
    self.scroller.minimumZoomScale = 1.0;
    self.scroller.maximumZoomScale = 2.0;
    self.scroller.contentSize = self.imgImage.frame.size;
    self.scroller.delegate = self;
    
    
    //    _scroller.delegate=self;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgImage;
}


- (IBAction)Close:(id)sender {
}

@end
