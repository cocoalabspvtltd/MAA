//
//  ReviewTableViewCell.h
//  MAA
//
//  Created by Cocoalabs India on 28/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *reviewerImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstRatingStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondRatingStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdRatingStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourthRatingStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthRatingStarImageView;
@property (nonatomic, strong) NSString *profilImageurlString;
@property (nonatomic, strong) NSString *dateString;
@end
