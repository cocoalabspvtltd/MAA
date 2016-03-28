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
@property (weak, nonatomic) IBOutlet UIImageView *ratingStarImageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *ratingStarImageView_2;
@property (weak, nonatomic) IBOutlet UIImageView *ratingStarImageView_3;
@property (weak, nonatomic) IBOutlet UIImageView *ratingStarImageView_4;
@property (weak, nonatomic) IBOutlet UIImageView *ratingStarImageView_5;
@property (nonatomic, strong) NSString *profilImageurlString;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *ratingString;
@end
