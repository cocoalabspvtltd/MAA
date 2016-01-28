//
//  homepage_doctorViewController.h
//  MAA
//
//  Created by Kiran on 23/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homepage_doctorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)NSString *token;
@property (strong, nonatomic) IBOutlet UITableViewCell *celll;
@property (weak, nonatomic) IBOutlet UILabel *xiblabel;
@property (weak, nonatomic) IBOutlet UIImageView *xibimage;
@property (weak, nonatomic) IBOutlet UILabel *colllabel;
@property (weak, nonatomic) IBOutlet UIImageView *collimage;
@property (weak, nonatomic) IBOutlet UILabel *doctor_name;
@property (weak, nonatomic) IBOutlet UILabel *doctore_dis;
@property (weak, nonatomic) IBOutlet UIImageView *doctor_pic;
@property (weak, nonatomic) IBOutlet UITableView *tablee;
- (IBAction)toggler:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collviewwwww;
@property (weak, nonatomic) IBOutlet UISwitch *toggler;
@property (weak, nonatomic) IBOutlet UILabel *status_label;
@property (weak, nonatomic) IBOutlet UIImageView *downimage;
@end
