//
//  ViewProfileVC.h
//  MAA
//
//  Created by Cocoalabs India on 15/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewProfileVC : UIViewController
- (IBAction)personal:(id)sender;
- (IBAction)professional:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPersonal;
@property (weak, nonatomic) IBOutlet UIView *viewProfessional;

@end
