//
//  LoginPageVC.h
//  MAA
//
//  Created by Roshith Balendran on 28/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPageVC : UIViewController

{
    IBOutlet UITextField *textFieldEmail;
    IBOutlet UITextField *textFieldPassword;
    IBOutlet UIButton *buttonLogin;
    
    
    NSString *theSegueIUsed;
}


- (IBAction)funcButtonLogin:(id)sender;



@end
