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
    
    NSMutableArray *arraySearchResultListing;
}
@property (nonatomic, strong) NSString *departmentId;
@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, assign) BOOL isLocationSearch;

@end
