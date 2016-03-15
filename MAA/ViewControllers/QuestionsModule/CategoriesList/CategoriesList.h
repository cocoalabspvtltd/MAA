//
//  CategoriesList.h
//  MAA
//
//  Created by Cocoalabs India on 05/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryDelegate;
@interface CategoriesList : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblCategories;
@property (nonatomic, assign) id<CategoryDelegate>categoryDelegate;
@end
@protocol CategoryDelegate <NSObject>

-(void)tableViewSelectedActionWithCategoryDetails:(id)selectedCategoryDetails;

@end