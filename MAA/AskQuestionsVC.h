//
//  AskQuestionsVC.h
//  MAA
//
//  Created by Cocoalabs India on 21/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AskQuestionsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *doctorTextField;
@property (weak, nonatomic) IBOutlet UITableView *tblCategories;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseCategry;
- (IBAction)ChooseCategory:(id)sender;


@end
