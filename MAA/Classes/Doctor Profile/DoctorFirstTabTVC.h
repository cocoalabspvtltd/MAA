//
//  DoctorFirstTabTVC.h
//  MAA
//
//  Created by kiran on 03/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorFirstTabTVC : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *doctorClinicNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNoLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *consultationFeeLabel;
@end
