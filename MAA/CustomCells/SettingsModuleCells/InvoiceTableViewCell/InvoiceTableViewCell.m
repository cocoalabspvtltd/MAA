//
//  InvoiceTableViewCell.m
//  MAA
//
//  Created by Cocoalabs India on 14/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "InvoiceTableViewCell.h"


@implementation InvoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialisation];
    // Initialization code
}

-(void)initialisation{
    self.invoiceImageView.layer.borderColor = AppCommnRedColor.CGColor;
    self.invoiceImageView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
