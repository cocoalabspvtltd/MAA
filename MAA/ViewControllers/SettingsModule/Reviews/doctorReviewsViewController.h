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

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tablee;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableViewCell *celll;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *reviewContent;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, assign) int offsetValue;
@property (weak, nonatomic) IBOutlet UIView *NoResultsView;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, assign) NSString* month;
@property (nonatomic, assign) NSString* year;
@property (weak, nonatomic) IBOutlet UILabel *selected_date;
@property (weak, nonatomic) IBOutlet UIDatePicker *date_picker;
@property (weak, nonatomic) IBOutlet UIImageView *s1;
@property (weak, nonatomic) IBOutlet UIImageView *s2;
@property (weak, nonatomic) IBOutlet UIImageView *s3;
@property (weak, nonatomic) IBOutlet UIImageView *s4;
@property (weak, nonatomic) IBOutlet UIImageView *s5;

@property (weak, nonatomic) IBOutlet UIStackView *noReviewsView;

@end
