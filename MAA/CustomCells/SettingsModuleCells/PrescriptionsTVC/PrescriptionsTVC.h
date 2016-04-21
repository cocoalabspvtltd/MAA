//
//  PrescriptionsTVC.h
//  MAA
//
//  Created by Cocoalabs India on 21/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescriptionsTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *presDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *prescriptionImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end
