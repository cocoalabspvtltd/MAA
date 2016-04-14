//
//  BaseViewController.m
//  MAA
//
//  Created by kiran on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
  self.tabBarController.delegate = self;
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

@end
