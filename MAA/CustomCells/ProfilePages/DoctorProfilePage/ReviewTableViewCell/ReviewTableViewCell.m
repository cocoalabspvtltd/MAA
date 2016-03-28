//
//  ReviewTableViewCell.m
//  MAA
//
//  Created by Cocoalabs India on 28/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#define SelectStarImagename @"star_sel@2x"
#import "ReviewTableViewCell.h"

@implementation ReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setProfilImageurlString:(NSString *)profilImageurlString{
    [self.reviewerImageView sd_setImageWithURL:[NSURL URLWithString:profilImageurlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

-(void)setRatingString:(NSString *)ratingString{
    if([ratingString isEqualToString:@"1"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"2"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"3"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"4"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_4.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"5"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_4.image = [UIImage imageNamed:SelectStarImagename];
         self.ratingStarImageView_5.image = [UIImage imageNamed:SelectStarImagename];
    }
}
@end
