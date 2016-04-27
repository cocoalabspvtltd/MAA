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

@property (weak, nonatomic) IBOutlet UIImageView *docImage;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property(nonatomic,retain)NSString *appID;

@property (nonatomic, strong) NSString *doctorNamneString;
@property (nonatomic, strong) NSString *doctorProfUrlString;

@end
