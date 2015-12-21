//
//  SignUpPage2VC.h
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpPage2VC : UIViewController

{
    IBOutlet UITextField *textFieldGender;
    IBOutlet UITextField *textFieldDateOfBirth;
    IBOutlet UITextField *textFieldPassword;
    IBOutlet UITextField *textFieldReTypePassword;
    
    IBOutlet UIButton *buttonSubmit;
    
    IBOutlet UIButton *buttonBack;
}
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSString *phoneNumberString;
@property (nonatomic, strong) NSString *emailString;
- (IBAction)funcButtonBack:(id)sender;

- (IBAction)funcButtonSubmit:(id)sender;


@end
