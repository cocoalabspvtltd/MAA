//
//  AccountResetPWVC.h
//  MAA
//
//  Created by Cocoalabs India on 16/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountResetPWVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *currentPasswordTextFiels;
@property (weak, nonatomic) IBOutlet UITextField *newpwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *retyPasswordTextField;
@property (nonatomic, assign) BOOL isFromNewPassord;
@end
