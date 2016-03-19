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
@property (weak, nonatomic) IBOutlet UIView *noResultsView;

- (IBAction)Filter:(id)sender;


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
