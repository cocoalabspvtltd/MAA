//
//  SelectUsageViewController.h
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectUsageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *doctoSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *userSelectionButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *termsOfServiceButton;
@property (nonatomic, assign) BOOL isUsertypeStatusNull;
@property (nonatomic, strong) NSString *tokenString;
@property (nonatomic, assign) BOOL isFromLogin;
@property (nonatomic, assign) BOOL isDOCSubmitted;

@end
