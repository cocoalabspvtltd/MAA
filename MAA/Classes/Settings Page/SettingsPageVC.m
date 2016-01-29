//
//  SettingsPageVC.m
//  MAA
//
//  Created by Vineeth Vijayan on 28/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "HealthProfileVC.h"
#import "SettingsTableViewCell.h"
#import "SettingsPageVC.h"

@interface SettingsPageVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingsPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

//- (void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.navigationItem.hidesBackButton = YES;
//}

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

#pragma mark - Tbale View Data Sources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingsTableViewCell *settingsTVC = [tableView dequeueReusableCellWithIdentifier:@"settingsReusableCell"forIndexPath:indexPath];
    if(indexPath.row == 0){
        settingsTVC.headingLabel.text = @"My Health Profile";
    }
    else if (indexPath.row == 1){
        settingsTVC.headingLabel.text = @"Account Settings";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"AccountSettings"];
    }
    else if (indexPath.row == 2){
        settingsTVC.headingLabel.text = @"My Reviews";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"Reviews"];
    }
    else if (indexPath.row == 3){
        settingsTVC.headingLabel.text = @"Invoices";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"Invoices"];
    }
    else if (indexPath.row == 4){
        settingsTVC.headingLabel.text = @"About";
    }
    else if (indexPath.row == 5){
        settingsTVC.headingLabel.text = @"Sign Out";
        settingsTVC.iconImageView.image = [UIImage imageNamed:@"signOut"];
    }
    return settingsTVC;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HealthProfileVC *myHealthProfileVC = (HealthProfileVC *)[storyboard instantiateViewControllerWithIdentifier:@"HealthProfileVC"];
        [self.navigationController pushViewController:myHealthProfileVC animated:YES];
    }
}
@end
