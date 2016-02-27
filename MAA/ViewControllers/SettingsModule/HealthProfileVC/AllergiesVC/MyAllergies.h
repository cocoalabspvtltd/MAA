//
//  MyAllergies.h
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAllergies : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgFloat;
- (IBAction)FloatButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ppupView;
@property (weak, nonatomic) IBOutlet UITableView *tblAllergies;
@property (weak, nonatomic) IBOutlet UIView *childView;
@property (weak, nonatomic) IBOutlet UITextField *allergyTextField;

@end
