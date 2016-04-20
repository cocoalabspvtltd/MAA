//
//  fourthViewController.h
//  LearningOpenTok
//
//  Created by Kiran on 29/12/15.
//  Copyright © 2015 tokboxkiran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenTok/OpenTok.h>
@interface fourthViewController : UIViewController<OTSessionDelegate,OTSubscriberDelegate,OTPublisherDelegate>
@property (weak, nonatomic) IBOutlet UILabel *L2;
@property (weak, nonatomic) IBOutlet UITextField *TEXTF;
- (IBAction)BUT:(id)sender;

@end
