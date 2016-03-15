//
//  ResetPasswordVC.h
//  MAA
//
//  Created by Cocoalabs India on 21/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *passwordtextField;
@property (strong, nonatomic) IBOutlet UITextField *retypPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *txtEnterCurrentPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtEnterNewPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtRetypePassword;

@end
