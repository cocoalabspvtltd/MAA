//
//  Invoicepopup.h
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Invoicepopup : UIView
@property (weak, nonatomic) IBOutlet UILabel *invoiceNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeOfappointmentLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
