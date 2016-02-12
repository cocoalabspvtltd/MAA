//
//  AppointmentTableViewCell.h
//  MAA
//
//  Created by kiran on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftStatusImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightProfileImageView;
@property (nonatomic, strong) NSString *rightprofileImageurlString;
@property (nonatomic, strong) NSString *timeStampString;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *closeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;
@property (weak, nonatomic) IBOutlet UIButton *playbutton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) NSString *typeString;
@property (weak, nonatomic) IBOutlet UILabel *appointmentTypeLabel;
@property (nonatomic, strong) NSString *statusString;
@property (weak, nonatomic) IBOutlet UIImageView *appointmrntTypeIconimageView;
@end
