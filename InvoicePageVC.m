//
//  InvoicePageVC.m
//  MAA
//
//  Created by Cocoalabs India on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "InvoicePageVC.h"

@interface InvoicePageVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *Months;
    NSArray *Year;
}
@end

@implementation InvoicePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblMonth.hidden=YES;
    _tblYear.hidden=YES;

    Months=@[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    
    Year=@[@"2015",@"2016"];
    _tblMonth.delegate=self;
    _tblMonth.dataSource=self;
    
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
    if (tableView==_tblMonth)
    {
        return Months.count;
        
    }
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableIdentifier=@"TableItem";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    cell.textLabel.text=[Months objectAtIndex:indexPath.row];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *x = Months[indexPath.row];
    [_btnMonth setTitle:x forState:UIControlStateNormal];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ClickMonth:(id)sender
{
    if (_tblMonth.hidden==YES) {
        _tblMonth.hidden=NO;
    }
    else
        _tblMonth.hidden=YES;
}
- (IBAction)ClickYear:(id)sender
{
    if (_tblYear.hidden==YES) {
        _tblYear.hidden=NO;
    }
    else
        _tblYear.hidden=YES;
}
@end
