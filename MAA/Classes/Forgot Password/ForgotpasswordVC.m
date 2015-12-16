//
//  ForgotpasswordVC.m
//  MAA
//
//  Created by Roshith Balendran on 28/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "ForgotpasswordVC.h"

@interface ForgotpasswordVC ()

@end

@implementation ForgotpasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textFieldEmail resignFirstResponder];
    [textFieldPhone resignFirstResponder];
}

- (IBAction)funcButtonBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
