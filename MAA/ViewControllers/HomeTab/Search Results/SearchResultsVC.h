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
@property (nonatomic, strong) id selectedDepartmentDetails;
@property (nonatomic, strong) id selectedLocationDetail;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, assign) BOOL isLocationSearch;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;

@end
