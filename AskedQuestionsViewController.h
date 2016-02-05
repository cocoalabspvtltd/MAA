//
//  AskedQuestionsViewController.h
//  MAA
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskedQuestionsTVC.h"

@interface AskedQuestionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *floatimage;
@property (weak, nonatomic) IBOutlet UIButton *floatbutton;
@property (weak, nonatomic) IBOutlet UISearchBar *askedQuestionsSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *tblquestions;
@property (weak, nonatomic) IBOutlet UIView *childview;
@end
