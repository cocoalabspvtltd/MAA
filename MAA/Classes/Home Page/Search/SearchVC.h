//
//  SearchVC.h
//  MAA
//
//  Created by Roshith on 11/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController

{
    IBOutlet UITableView *tableViewSearch;
    
    NSMutableDictionary *dictionaryArrayData;
    
    NSMutableArray *arraySearchListing;
}

@end
