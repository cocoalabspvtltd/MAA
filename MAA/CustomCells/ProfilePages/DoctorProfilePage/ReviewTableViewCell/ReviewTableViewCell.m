//
//  ReviewTableViewCell.m
//  MAA
//
//  Created by Cocoalabs India on 28/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

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
@end
