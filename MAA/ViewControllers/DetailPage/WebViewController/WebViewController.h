//
//  WebViewController.h
//  MAA
//
//  Created by Cocoalabs India on 14/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *urlString;
- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (nonatomic, strong) NSString *headingString;

@end
