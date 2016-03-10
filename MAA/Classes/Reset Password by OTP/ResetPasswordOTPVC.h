//
//  ResetPasswordOTPVC.h
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordOTPVC : UIViewController
{
    IBOutlet UITextField *textFieldOTP;
    IBOutlet UIButton *buttonVerifyOTP;

    IBOutlet UIButton *buttonBack;
}
@property (nonatomic, strong) NSString *mobileNumberString;
@property (nonatomic, assign) BOOL isfromRegistration;
- (IBAction)funcButtonBack:(id)sender;

@end
