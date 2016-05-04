//
//  AboutViewController.m
//  MAA
//
//  Created by kiran on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "WebViewController.h"
#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"V %@",appVersionString];
    // Do any additional setup after loading the view.
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

#pragma mark - Button Actions

- (IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)googlePlusButtonAction:(UIButton *)sender {
    [self loadingWebViewControllerWithUrlString:@"https://google.com" andHEadingString:@"Google Plus"];
}
- (IBAction)facebookButtonAction:(UIButton *)sender {
    [self loadingWebViewControllerWithUrlString:@"https://google.com" andHEadingString:@"Facebook"];
}
- (IBAction)twitterButtonAction:(UIButton *)sender {
    [self loadingWebViewControllerWithUrlString:@"https://google.com" andHEadingString:@"Twitter"];
}

#pragma mark - Loading Web view Controller

-(void)loadingWebViewControllerWithUrlString:(NSString *)webViewUrlString andHEadingString:(NSString *)headingString{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.urlString = webViewUrlString;
    webViewController.headingString = headingString;
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end
