//
//  ImagesVC.h
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgFloat;
@property (weak, nonatomic) IBOutlet UIView *Addpopup;

- (IBAction)Back:(id)sender;

- (IBAction)FloatButton:(id)sender;
@end
