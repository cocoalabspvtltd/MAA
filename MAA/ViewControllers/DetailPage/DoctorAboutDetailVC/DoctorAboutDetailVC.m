//
//  DoctorAboutDetailVC.m
//  MAA
//
//  Created by Kiran on 21/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorAboutTVC.h"
#import "DoctorAboutDetailVC.h"

@interface DoctorAboutDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;

@end

@implementation DoctorAboutDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.headingLabel.text = [NSString stringWithFormat:@"Dr. %@'s %@",self.doctorNameString,self.headingString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aboutListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"doctorAboutDetailCell" forIndexPath:indexPath];
    cell.specializationHeadingLabel.text = [self.aboutListArray objectAtIndex:indexPath.row];
    return cell;
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
