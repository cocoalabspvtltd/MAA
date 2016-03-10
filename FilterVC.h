//
//  FilterVC.h
//  MAA
//
//  Created by Cocoalabs India on 10/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtTo;
@property (weak, nonatomic) IBOutlet UITextField *txtTypOfAppoinment;
@property (weak, nonatomic) IBOutlet UITextField *Status;
- (IBAction)Submit:(id)sender;

@end
