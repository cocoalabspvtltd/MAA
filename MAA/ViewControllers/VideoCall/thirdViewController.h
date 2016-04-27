//
//  thirdViewController.h
//  LearningOpenTok
//
//  Created by Kiran on 29/12/15.
//  Copyright © 2015 tokboxkiran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenTok/OpenTok.h>

@interface thirdViewController : UIViewController<OTSessionDelegate,OTSubscriberDelegate,OTPublisherDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *end;
@property (weak, nonatomic) IBOutlet UIImageView *end1;
@property (weak, nonatomic) IBOutlet UIImageView *docImage;
@property (weak, nonatomic) IBOutlet UILabel *docName;
@property (weak, nonatomic) IBOutlet UILabel *progress;
- (IBAction)end:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *connecting;

@property(nonatomic,retain)NSString *appID;
@property (nonatomic, strong) NSString *doctorNameString;
@property (nonatomic, strong) NSString *doctorProfileImageUrlString;
@end
