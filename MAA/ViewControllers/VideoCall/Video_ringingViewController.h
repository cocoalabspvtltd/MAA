//
//  Video_ringingViewController.h
//  MAA
//
//  Created by Kiran on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Video_ringingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *docImage;
- (IBAction)accept:(id)sender;
- (IBAction)reject:(id)sender;

@end
