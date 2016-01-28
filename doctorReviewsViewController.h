//
//  doctorReviewsViewController.h
//  MAA
//
//  Created by Kiran on 27/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface doctorReviewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *totalString;
    NSMutableArray *filteredString;
    BOOL isFiltered;
    NSRange stringRange;
}

@property (weak, nonatomic) IBOutlet UITableView *tablee;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableViewCell *celll;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *reviewContent;
@property (strong, nonatomic) UISearchController *searchController;
@property(nonatomic,retain)NSString *token;
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, assign) NSString * type;
@property (nonatomic, assign) NSString* keyword;
@property (nonatomic, assign) NSString* month;
@property (nonatomic, assign) NSString* year;
@property (weak, nonatomic) IBOutlet UILabel *selected_date;
@property (weak, nonatomic) IBOutlet UIDatePicker *date_picker;
- (IBAction)picker_action:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *s1;
@property (weak, nonatomic) IBOutlet UIImageView *s2;
@property (weak, nonatomic) IBOutlet UIImageView *s3;
@property (weak, nonatomic) IBOutlet UIImageView *s4;
@property (weak, nonatomic) IBOutlet UIImageView *s5;

@end
