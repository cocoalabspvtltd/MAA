//
//  Appoinments.h
//  maa.stroyboard
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoalabs India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AppoinmentsDocs : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblAppoinments;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@property (weak, nonatomic) IBOutlet UIView *ChildView;
- (IBAction)Filter:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *FromDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *Todate;
@property (weak, nonatomic) IBOutlet UIButton *btnfrom;
@property (weak, nonatomic) IBOutlet UIButton *btnTo;
- (IBAction)To:(id)sender;
- (IBAction)From:(id)sender;
- (IBAction)SelectDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectD;
@property (weak, nonatomic) IBOutlet UIButton *btnDropDown;
- (IBAction)DropDown:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblDropList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
