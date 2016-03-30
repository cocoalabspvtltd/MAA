//
//  DoctorAboutVC.m
//  MAA
//
//  Created by Cocoalabs India on 30/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorAboutTVC.h"
#import "DoctorAboutVC.h"

@interface DoctorAboutVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DoctorAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tbale View Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.specializationTableView)
    {
       DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"doctorAboutReuseCell"forIndexPath:indexPath];
        return cell;
    }
    else
     return nil;
}

#pragma mark - Button Actions

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)specializationviewMoreButtonAction:(UIButton *)sender {
}
- (IBAction)servicesViewMoreButtonAction:(UIButton *)sender {
}
- (IBAction)memberShipViewMoreButtonAction:(UIButton *)sender {
}
- (IBAction)awardsviewMoreButtonAction:(UIButton *)sender {
}
- (IBAction)experienceViewMoreButtonAction:(UIButton *)sender {
}
- (IBAction)educationViewMoreButtonAction:(UIButton *)sender {
}
- (IBAction)registrationviewMoreButtonAction:(UIButton *)sender {
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
