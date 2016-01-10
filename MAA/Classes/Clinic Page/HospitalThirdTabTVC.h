//
//  HospitalThirdTabTVC.h
//  MAA
//
//  Created by kiran on 03/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalThirdTabTVC : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *reviewerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *reviewDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *firstStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *thirdStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *fourthStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *fifthStarImageView;

@end
