//
//  AddMessagesVC.h
//  MAA
//
//  Created by Cocoalabs India on 15/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMessagesVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *subjectTextfield;
@property (weak, nonatomic) IBOutlet UITextView *messagetTextField;
@property (nonatomic, strong) NSString *entityId;
@end
