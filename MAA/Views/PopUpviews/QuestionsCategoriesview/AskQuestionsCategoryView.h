//
//  AskQuestionsCategoryView.h
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AskQuestionsCategoryViewDeleagte;
@interface AskQuestionsCategoryView : UIView
@property (nonatomic, strong) NSArray *categoriesArray;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (nonatomic, assign) id<AskQuestionsCategoryViewDeleagte>askQuestionsCategoryDelegate;
@end
@protocol AskQuestionsCategoryViewDeleagte <NSObject>

-(void)salectedCategoryWithIndex:(NSString *)selectedCategoryIndex withCategoryName:(NSString *)categoryName;

@end