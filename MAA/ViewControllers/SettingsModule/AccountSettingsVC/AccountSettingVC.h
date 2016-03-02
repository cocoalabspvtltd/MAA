//
//  AccountSettingVC.h
//  MAA
//
//  Created by Cocoalabs India on 02/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountSettingVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *namLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UITextField *emailTesxtField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UIButton *femaleRadioButton;
@property (weak, nonatomic) IBOutlet UIButton *maleRadioButton;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTExtField;
@property (weak, nonatomic) IBOutlet UITextField *localityTextField;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
