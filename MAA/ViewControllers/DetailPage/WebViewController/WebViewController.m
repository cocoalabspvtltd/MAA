//
//  WebViewController.m
//  MAA
//
//  Created by Cocoalabs India on 14/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self initialisation];
    [self loadingWebView];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.TitleLabel.text = _headingString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadingWebView{
    NSURL *websiteUrl = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
