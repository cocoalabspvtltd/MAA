//
//  PerescriptionsTVC.h
//  MAA
//
//  Created by Cocoalabs India on 30/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerescriptionsTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *documantImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageview;
@property (nonatomic, strong) NSString *imageUrlString;

@end
