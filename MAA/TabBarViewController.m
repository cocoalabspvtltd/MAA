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
    self.delegate = self;
    UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:0];
    UIImage *unselectedImage = [UIImage imageNamed:@"homeGREY"];
    UIImage *selectedImage = [UIImage imageNamed:@"home"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem = [self.tabBar.items objectAtIndex:1];
    unselectedImage = [UIImage imageNamed:@"search"];
    selectedImage = [UIImage imageNamed:@"search-a"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem = [self.tabBar.items objectAtIndex:2];
    unselectedImage = [UIImage imageNamed:@"calendarGREY"];
    selectedImage = [UIImage imageNamed:@"calendar"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem = [self.tabBar.items objectAtIndex:3];
    unselectedImage = [UIImage imageNamed:@"QUESTIONGREY"];
    selectedImage = [UIImage imageNamed:@"question"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem = [self.tabBar.items objectAtIndex:4];
    unselectedImage = [UIImage imageNamed:@"settingsGREY"];
    selectedImage = [UIImage imageNamed:@"settingsNew"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   //  Do any additional setup after loading the view.
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
