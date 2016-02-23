//
//  myHealthProfileVC.h
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myHealthProfileVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnDropDown;
- (IBAction)DropDown:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UIButton *bloodGroupButton;
@property (weak, nonatomic) IBOutlet UITextField *lowBPtextField;
@property (weak, nonatomic) IBOutlet UITextField *hightextField;
@property (weak, nonatomic) IBOutlet UITextField *fastingSugarTextField;
@property (weak, nonatomic) IBOutlet UITextField *postMealSugarTextField;

@end
