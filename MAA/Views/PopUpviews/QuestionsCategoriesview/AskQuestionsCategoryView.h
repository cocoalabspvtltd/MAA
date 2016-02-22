//
//  AskQuestionsCategoryView.h
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AskQuestionsCategoryView : UIView
@property (nonatomic, strong) NSArray *categoriesArray;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@end
