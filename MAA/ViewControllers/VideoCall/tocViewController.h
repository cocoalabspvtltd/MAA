//
//  tocViewController.h
//  MAA
//
//  Created by Kiran on 04/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tocViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (weak, nonatomic) IBOutlet UILabel *heading;
- (IBAction)back:(id)sender;
@property(nonatomic,retain)NSURL *websiteUrl;
@property(nonatomic,retain)NSString*headingL;
@end
