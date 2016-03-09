//
//  TextChatVC.h
//  MAA
//
//  Created by Cocoalabs India on 08/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextChatVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *msgbackground;
@property (strong, nonatomic) IBOutlet UITableViewCell *CellSender;
@property (weak, nonatomic) IBOutlet UILabel *lblSender;
@property (weak, nonatomic) IBOutlet UILabel *lblSendTime;
@property (strong, nonatomic) IBOutlet UITableViewCell *CellReciever;
@property (weak, nonatomic) IBOutlet UILabel *lblReciever;
@property (weak, nonatomic) IBOutlet UILabel *lblRecievingTime;
@property (weak, nonatomic) IBOutlet UITableView *tblChat;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
- (IBAction)Send:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfChildView;

@end
