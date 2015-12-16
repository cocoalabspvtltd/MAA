//
//  ForgotpasswordVC.h
//  MAA
//
//  Created by Roshith Balendran on 28/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotpasswordVC : UIViewController
{
    IBOutlet UITextField *textFieldEmail;
    IBOutlet UITextField *textFieldPhone;
    IBOutlet UIButton *buttonNext;
    
    IBOutlet UIButton *buttonOTP;
    
    IBOutlet UIButton *buttonBack;
}

- (IBAction)funcButtonBack:(id)sender;

@end
