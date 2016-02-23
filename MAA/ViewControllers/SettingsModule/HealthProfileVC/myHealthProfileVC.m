//
//  myHealthProfileVC.m
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "myHealthProfileVC.h"

@interface myHealthProfileVC ()
{
    NSArray *BloodGrups;
    
}

@end

@implementation myHealthProfileVC

CGFloat ht=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    BloodGrups=@[@"O +",@"O -",@"A +",@"A -",@"B +",@"B -",@"AB +",@"AB -"];
    _tblDropDown.hidden=YES;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return BloodGrups.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableIdentifier=@"TableItem";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    }
    
        
        cell.textLabel.text=[BloodGrups objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:(11.0)];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *x = BloodGrups[indexPath.row];
    [_btnDropDown setTitle:x forState:UIControlStateNormal];
    _tblDropDown.hidden=YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) viewDidLayoutSubviews
{

    CGFloat  height = self.ContentView.frame.size.height+50;
    
    [_scroller setContentSize:CGSizeMake(self.view.frame.size.width,height)];
    
}
- (IBAction)backbuttonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)DropDown:(id)sender
{
    if (_tblDropDown.hidden==YES) {
        _tblDropDown.hidden=NO;
    }
    else
        _tblDropDown.hidden=YES;
}
@end
