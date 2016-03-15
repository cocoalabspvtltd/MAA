//
//  CategoriesList.m
//  MAA
//
//  Created by Cocoalabs India on 05/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "CategoriesList.h"
#import "CategoryCell.h"

@interface CategoriesList ()

@end

@implementation CategoriesList

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)back:(id)sender
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end
