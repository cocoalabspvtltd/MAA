//
//  FeedBackVC.m
//  MAA
//
//  Created by Cocoalabs India on 26/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "FeedBackVC.h"

@interface FeedBackVC ()<UITextFieldDelegate>

@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedbacktextView.layer.borderWidth = .5f;
    self.feedbacktextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
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
- (IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitButtonAction:(UIButton *)sender {
}

@end
