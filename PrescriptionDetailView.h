//
//  PrescriptionDetailView.h
//  MAA
//
//  Created by Cocoalabs India on 27/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescriptionDetailView : UIView
@property (weak, nonatomic) IBOutlet UIPinchGestureRecognizer *PinchGesture;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIImageView *imgImage;
@property (weak, nonatomic) IBOutlet UIPinchGestureRecognizer *Pinch;

@end
