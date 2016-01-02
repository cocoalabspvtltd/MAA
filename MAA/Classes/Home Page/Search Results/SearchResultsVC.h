//
//  SearchResultsVC.h
//  MAA
//
//  Created by Roshith on 14/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsVC : UIViewController

{
    IBOutlet UITableView *tableViewSearchResults;
   
//    NSMutableDictionary *dictionaryArrayData;
    
    NSMutableArray *arraySearchResultListing;}
@property (strong, nonatomic) IBOutlet UIButton *onlineButton;
@property (nonatomic, strong) NSString *departmentId;
@property (strong, nonatomic) IBOutlet UIButton *allButton;

@end
