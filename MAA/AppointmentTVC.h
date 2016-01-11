//
//  AppointmentTVC.h
//  MAA
//
//  Created by Cocoalabs India on 11/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *isOnlineImageView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentDateLabel;
@end
