//
//  MedicalDocumentsVC.h
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalDocumentsVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgFloat;
- (IBAction)floatButton:(id)sender;

- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *AddPopup;

@end
