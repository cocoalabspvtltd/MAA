//
//  InvoiceTableViewCell.h
//  MAA
//
//  Created by Cocoalabs India on 14/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *invoiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end
