//
//  myHealthProfileVC.h
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myHealthProfileVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *childView3;
@property (weak, nonatomic) IBOutlet UIView *childView2;
@property (weak, nonatomic) IBOutlet UIView *childView1;
@property (weak, nonatomic) IBOutlet UIButton *btnDropDown;
- (IBAction)DropDown:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *lowBPtextField;
@property (weak, nonatomic) IBOutlet UITextField *hightextField;
@property (weak, nonatomic) IBOutlet UITextField *fastingSugarTextField;
@property (weak, nonatomic) IBOutlet UITextField *postMealSugarTextField;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UITextField *notestextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIImageView *underLineImg1;
@property (weak, nonatomic) IBOutlet UIImageView *underLineImg2;
@property (weak, nonatomic) IBOutlet UIImageView *underLineImg3;
@property (weak, nonatomic) IBOutlet UIImageView *underLineImg4;
@property (weak, nonatomic) IBOutlet UIImageView *underLineImg5;
@property (weak, nonatomic) IBOutlet UIImageView *underLineImg6;
@property (weak, nonatomic) IBOutlet UIButton *prescriptionButton;
@property (weak, nonatomic) IBOutlet UIButton *medicalDocumentButton;
@property (weak, nonatomic) IBOutlet UIButton *imagesButton;

@property (weak, nonatomic) IBOutlet UIButton *allergiesButton;
@end
