//
//  TabBarViewController.m
//  MAA
//
//  Created by Cocoalabs India on 08/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:0];
    UIImage *unselectedImage = [UIImage imageNamed:@"home_white"];
    UIImage *selectedImage = [UIImage imageNamed:@"bar_b"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  //  [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    tabBarItem = [self.tabBar.items objectAtIndex:1];
//    unselectedImage = [UIImage imageNamed:@"ic_tabNews"];
//    selectedImage = [UIImage imageNamed:@"ic_tabNews"];
//    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tabBarItem setSelectedImage: selectedImage];
//    tabBarItem = [self.tabBar.items objectAtIndex:2];
//    unselectedImage = [UIImage imageNamed:@"ic_tabNotifications"];
//    selectedImage = [UIImage imageNamed:@"ic_tabNotifications"];
//    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tabBarItem setSelectedImage: selectedImage];
//    tabBarItem = [self.tabBar.items objectAtIndex:3];
//    unselectedImage = [UIImage imageNamed:@"ic_events"];
//    selectedImage = [UIImage imageNamed:@"ic_events"];
//    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tabBarItem setSelectedImage: selectedImage];
//    tabBarItem = [self.tabBar.items objectAtIndex:4];
//    unselectedImage = [UIImage imageNamed:@"ic_tabMore"];
//    selectedImage = [UIImage imageNamed:@"ic_tabMore"];
//    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tabBarItem setSelectedImage: selectedImage];
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

@end
