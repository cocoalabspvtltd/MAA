//
//  SignUpPage1VC.h
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpPage1VC : UIViewController

{
    IBOutlet UITextField *textFieldName;
    IBOutlet UITextField *textFieldPhone;
    IBOutlet UITextField *textFieldEmail;
    
    IBOutlet UIButton *buttonNext;
    
    IBOutlet UIButton *buttonBack;
}

- (IBAction)funcButtonBack:(id)sender;

@end