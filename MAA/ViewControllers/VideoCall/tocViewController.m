//
//  tocViewController.m
//  MAA
//
//  Created by Kiran on 04/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "tocViewController.h"

@interface tocViewController ()

@end

@implementation tocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_headingL.length!=0) {
        _heading.text=_headingL;

    }
    _websiteUrl = [NSURL URLWithString:@"http://freemaart.com/dev/tos.html"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:_websiteUrl];
    [_web loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
