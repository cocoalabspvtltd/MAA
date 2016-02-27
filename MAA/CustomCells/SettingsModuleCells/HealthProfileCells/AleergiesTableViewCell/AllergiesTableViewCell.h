//
//  AllergiesTableViewCell.h
//  MAA
//
//  Created by Cocoalabs India on 27/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AllergiesCellDelegate;
@interface AllergiesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *allergyNameLabel;
@property (nonatomic, assign) id<AllergiesCellDelegate>allergiesCellDelegate;
@end
@protocol AllergiesCellDelegate <NSObject>

-(void)longPressGestureActionWithCellTag:(NSUInteger)cellTag;

@end