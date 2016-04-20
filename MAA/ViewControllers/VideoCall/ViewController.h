//
//  ViewController.h
//  Getting Started
//
//  Created by Jeff Swartz on 11/19/14.
//  Copyright (c) 2014 TokBox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenTok/OpenTok.h>
#import "Config.h"

@interface ViewController : UIViewController<OTSessionDelegate,OTSubscriberDelegate,OTPublisherDelegate>
{
    OTSession *session;
}
@property (readonly) OTConnection *connection;
@property (readonly) int connectionCount;
@property (readonly) OTSessionConnectionStatus sessionConnectionStatus;
@property (readonly) NSDictionary *streams;
- (IBAction)connect:(id)sender;
- (IBAction)diconnect:(id)sender;

- (IBAction)MUTE:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *UNMUTE;
@property (weak, nonatomic) IBOutlet UIView *secondView;
- (IBAction)unpublish:(id)sender;

- (IBAction)UNMUTE:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bar_view;
@property (weak, nonatomic) IBOutlet UILabel *topBarLabel;
@property (weak, nonatomic) IBOutlet UIImageView *apple;
@property (weak, nonatomic) IBOutlet UIImageView *docImage;
@property(nonatomic,retain)NSString *appID;

@end
