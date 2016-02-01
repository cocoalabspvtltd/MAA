//
//  Doc'sAccntInfo.h
//  MAA
//
//  Created by Cocoalabs India on 01/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Doc_sAccntInfo : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtemail;
@property (weak, nonatomic) IBOutlet UITextField *txtphone;
@property (weak, nonatomic) IBOutlet UIButton *btnChangePwd;
- (IBAction)ChangePwd:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ChildView;
@property (weak, nonatomic) IBOutlet UITextField *txtOldPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtNwPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtRetypPwd;
@property (weak, nonatomic) IBOutlet UIImageView *imgarrow;
- (IBAction)Submit:(id)sender;


@end
