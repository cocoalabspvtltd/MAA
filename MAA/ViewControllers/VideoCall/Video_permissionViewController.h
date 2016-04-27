//
//  Video_permissionViewController.h
//  MAA
//
//  Created by Kiran on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface Video_permissionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *check;
- (IBAction)check:(id)sender;
- (IBAction)start:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *docImage;
@property (weak, nonatomic) IBOutlet UIButton *start_appnt;
@property(nonatomic,retain)NSString *appID;
@property(nonatomic,retain)NSString *duration;
@property(nonatomic,retain)NSURL *imagee;
@property(nonatomic,retain)NSString *namee;

@property(nonatomic,retain)NSString *type;
@property (weak, nonatomic) IBOutlet UILabel *app_dur;
@property (weak, nonatomic) IBOutlet UILabel *name;
- (IBAction)back:(id)sender;
@property (nonatomic, strong) id appointmentDetails;

@end
