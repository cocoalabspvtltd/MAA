//
//  TimingsVC.m
//  MAA
//
//  Created by Kiran on 03/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "TimingsVC.h"

@interface TimingsVC ()
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;

@end

@implementation TimingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonAction:(UIButton *)sender {
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
