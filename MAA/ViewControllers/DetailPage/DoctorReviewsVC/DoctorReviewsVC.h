//
//  DoctorReviewsVC.h
//  MAA
//
//  Created by Cocoalabs India on 31/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorReviewsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *reviewsTableView;
@property (nonatomic, strong) NSString *entityId;
@end
