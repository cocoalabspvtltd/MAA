//
//  DoctorReviewsVC.m
//  MAA
//
//  Created by Cocoalabs India on 31/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "DoctorReviewsVC.h"

@interface DoctorReviewsVC ()<UITableViewDataSource>

@end

@implementation DoctorReviewsVC

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
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view Datasources 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReviews"forIndexPath:indexPath];
    cell.profilImageurlString = @"my test";
    cell.reviewerNameLabel.text = @"Bibin";
    cell.reviewContentLabel.text = @"my Review";
    cell.dateString = @"My Date";
    cell.ratingString = @"My Rating";
    return cell;
}

@end
