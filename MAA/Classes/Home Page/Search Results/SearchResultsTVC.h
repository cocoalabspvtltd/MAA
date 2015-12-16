//
//  SearchResultsTVC.h
//  MAA
//
//  Created by Roshith on 14/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsTVC : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *cellImageViewIcon;

@property (nonatomic, strong) IBOutlet UIImageView *cellImageViewOnlineStatus;

@property (nonatomic, strong) IBOutlet UILabel *cellLabelRating;

@property (nonatomic, strong) IBOutlet UILabel *cellLabelTitle;

@property (nonatomic, strong) IBOutlet UILabel *cellLabelDescription;

@property (nonatomic, strong) IBOutlet UIButton *cellButtonInfo;

@property (nonatomic, strong) IBOutlet UILabel *cellLabelConsultFee;

@property (nonatomic, strong) IBOutlet UILabel *cellLabelExperience;

@property (nonatomic, strong) IBOutlet UIButton *cellButtonLocation;



@end
