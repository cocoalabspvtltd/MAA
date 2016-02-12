//
//  AppoinmentDetailVC.h
//  MAA
//
//  Created by Cocoalabs India on 08/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AppoinmentDetailVC : BaseViewController
- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feesLabel;
@property (weak, nonatomic) IBOutlet UILabel *appontmentTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *doctorImageView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSString *appointmentIdString;
@property (weak, nonatomic) IBOutlet UITableView *previousAppointmentTableview;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@end
