//
//  FeedBackVC.h
//  MAA
//
//  Created by Cocoalabs India on 26/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface FeedBackVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *feedbacktextView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end
