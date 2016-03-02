//
//  AccountSettingVC.m
//  MAA
//
//  Created by Cocoalabs India on 02/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AccountSettingVC.h"

@interface AccountSettingVC ()

@end

@implementation AccountSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    [ _scroller setContentSize:CGSizeMake(self.view.frame.size.width, 760)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)Edit:(id)sender {
}
- (IBAction)Submit:(id)sender {
}
- (IBAction)changeMypassword:(id)sender {
}
- (IBAction)locality:(id)sender {
}

@end
