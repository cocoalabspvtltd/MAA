//
//  TimingsTableViewCell.h
//  MAA
//
//  Created by Cocoalabs India on 08/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol timingTabLeViewCellDelegate;
@interface TimingsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *availableDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *clinicNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *consultationFeeLabel;
@property (weak, nonatomic) IBOutlet UIButton *directionButton;
@property (nonatomic, strong) NSArray *timingsArray;
@property (nonatomic, assign) id <timingTabLeViewCellDelegate>timingCellDelegate;
@end
@protocol timingTabLeViewCellDelegate <NSObject>

-(void)directionButtonActionWithTag:(NSInteger)cellTag;

@end