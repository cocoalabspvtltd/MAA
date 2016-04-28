//
//  ReviewTableViewCell.m
//  MAA
//
//  Created by Cocoalabs India on 28/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define EmptyStarImageName @"star_empty_x"
#define HalfStarImageName @"starhalf"
#define SelectStarImagename @"star_sel@2x"
#import "ReviewTableViewCell.h"

@implementation ReviewTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _reviewerImageView.layer.borderWidth=.5;
    _reviewerImageView.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.275 alpha:1.00]CGColor];
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"dd-MMM-yy"];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
}

-(void)setRatingString:(NSString *)ratingString{
    self.ratingStarImageView_1.image = [UIImage imageNamed:EmptyStarImageName];
    self.ratingStarImageView_2.image = [UIImage imageNamed:EmptyStarImageName];
    self.ratingStarImageView_3.image = [UIImage imageNamed:EmptyStarImageName];
    self.ratingStarImageView_4.image = [UIImage imageNamed:EmptyStarImageName];
    self.ratingStarImageView_5.image = [UIImage imageNamed:EmptyStarImageName];
    if([ratingString isEqualToString:@"0.5"]){
       self.ratingStarImageView_1.image = [UIImage imageNamed:HalfStarImageName];
    }
    if([ratingString isEqualToString:@"1.0"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"1.5"]){
       self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
       self.ratingStarImageView_2.image = [UIImage imageNamed:HalfStarImageName];
    }
    else if ([ratingString isEqualToString:@"2.0"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"2.5"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:HalfStarImageName];
    }
    else if ([ratingString isEqualToString:@"3.0"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"3.5"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_4.image = [UIImage imageNamed:HalfStarImageName];
    }
    else if ([ratingString isEqualToString:@"4.0"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_4.image = [UIImage imageNamed:SelectStarImagename];
    }
    else if ([ratingString isEqualToString:@"4.5"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_4.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_5.image = [UIImage imageNamed:HalfStarImageName];
    }
    else if ([ratingString isEqualToString:@"5.0"]){
        self.ratingStarImageView_1.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_2.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_3.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_4.image = [UIImage imageNamed:SelectStarImagename];
        self.ratingStarImageView_5.image = [UIImage imageNamed:SelectStarImagename];
    }
}
@end
