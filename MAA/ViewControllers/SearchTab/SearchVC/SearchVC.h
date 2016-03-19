//
//  SearchVC.h
//  MAA
//
//  Created by Roshith on 11/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SearchVC : BaseViewController

{
    IBOutlet UITableView *tableViewSearch;
    
   // NSMutableDictionary *dictionaryArrayData;
    
   // NSMutableArray *arraySearchListing;
}
@property (strong, nonatomic) IBOutlet UISearchBar *doctorSearchBar;
@property (strong, nonatomic) IBOutlet UISearchBar *locationSerchBar;
@property (weak, nonatomic) IBOutlet UIView *sewarchResultsTableView;
@property (weak, nonatomic) IBOutlet UIView *noResultsView;


@end
