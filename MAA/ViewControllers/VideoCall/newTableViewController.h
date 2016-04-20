//
//  newTableViewController.h
//  textChat_uiImplementation
//
//  Created by Kiran on 29/03/16.
//  Copyright © 2016 Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenTok/OpenTok.h>
#import "MessageComposerView.h"

@interface newTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,OTSessionDelegate,OTSubscriberDelegate,OTPublisherDelegate,MessageComposerViewDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *celll;
@property (weak, nonatomic) IBOutlet UILabel *docLAbel;
@property (weak, nonatomic) IBOutlet UILabel *pat_label;
@property (weak, nonatomic) IBOutlet UIView *docView;
- (IBAction)send:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textf;
@property (weak, nonatomic) IBOutlet UITableView *tablee;
- (IBAction)patientSend:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pat_name;
@property (weak, nonatomic) IBOutlet UIImageView *pat_image;
@property (weak, nonatomic) IBOutlet UIImageView *pat_ballon;
@property (weak, nonatomic) IBOutlet UILabel *pat_date;
@property(nonatomic,retain)NSString *appID;
- (IBAction)finishChat:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *app_dur;
@property (weak, nonatomic) IBOutlet UIView *viewTobemoved;
@property (nonatomic, strong) MessageComposerView *messageComposerView;
@property (nonatomic, assign) CGRect oldFrame;
- (IBAction)back:(id)sender;

@end
