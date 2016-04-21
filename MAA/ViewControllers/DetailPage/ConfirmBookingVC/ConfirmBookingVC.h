//
//  ConfirmBookingVC.h
//  MAA
//
//  Created by Cocoalabs India on 18/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmBookingVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextField *appointmentTypetextfield;

@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) NSString *amountString;
@property (nonatomic, strong) NSString *locationString;
@property (nonatomic, strong) NSString *timeSlotId;
@property (nonatomic, strong) NSString *entityIdString;
@property (weak, nonatomic) IBOutlet UITextView *txtNotes;
@property (nonatomic, strong) id entityDetails;
@end
