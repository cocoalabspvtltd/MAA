//
//  ViewController.h
//  PaymentGateway
//
//  Created by Suraj on 22/07/15.
//  Copyright (c) 2015 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentPageViewController : UIViewController
@property (nonatomic, strong) NSString *amountString;
@property (nonatomic, strong) NSString *payeeNameString;
@property (nonatomic, strong) NSString *payeeEmailidString;
@property (nonatomic, strong) NSString *productInfoString;
@property (nonatomic, strong) NSString *payeePhoneString;

@end

