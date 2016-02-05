//
//  Appoinments.m
//  maa.stroyboard
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoalabs India. All rights reserved.
//

#import "Appoinments.h"

@interface Appoinments ()<UIPickerViewDelegate,UIPickerViewDelegate>
{
    NSArray *DDL;
    UILabel *name;

}
@end
NSString *flag=0;

@implementation Appoinments

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ChildView.hidden=YES;
    self.FromDate.hidden=YES;
    self.Todate.hidden=YES;
    self.btnSelectD.hidden=YES;
    self.tblDropList.hidden=YES;
    _tblAppoinments.dataSource=self;
    _tblAppoinments.delegate=self;
    
    
    DDL=@[@"Any",@"Audio Call",@"Video Call",@"Direct Appoinment",@"Chat"];
    
    
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
    if (tableView==_tblDropList)
    {
        return DDL.count;

    }
    else if (tableView==_tblAppoinments)
    {
        return  4;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  static NSString *TableIdentifier=@"TableItem";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    }
    if (tableView==_tblDropList)
    {
  
    
    cell.textLabel.text=[DDL objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:(11.0)];

       }
    else if (tableView==_tblAppoinments)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"bla"];
        if (cell==nil) {
            [[NSBundle mainBundle]loadNibNamed:@"View" owner:self options:nil];
            cell=_celll;
        }


    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *x = DDL[indexPath.row];
    [_btnDropDown setTitle:x forState:UIControlStateNormal];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)Filter:(id)sender
{
    if (self.ChildView.hidden==YES)
    {
        self.ChildView.hidden=NO;
        
        
        
    }
    else
    {
        self.ChildView.hidden=YES;
        //[self adjustHeightOfTableview];
    }
   // [self adjustHeightOfTableview];
}
- (IBAction)To:(id)sender
{
    if (self.Todate.hidden==YES)
    {
        self.Todate.hidden=NO;
        self.btnSelectD.hidden=NO;
        self.FromDate.hidden=YES;
    }
    else
    {
        self.Todate.hidden=YES;
        self.btnSelectD.hidden=YES;
        self.FromDate.hidden=YES;
        
    }
}

- (IBAction)From:(id)sender
{
    if (self.FromDate.hidden==YES)
    {
        self.FromDate.hidden=NO;
        self.btnSelectD.hidden=NO;
        self.Todate.hidden=YES;
        
    }
    else
    {
        self.FromDate.hidden=YES;
        self.btnSelectD.hidden=YES;
        self.Todate.hidden=YES;
       
    }
}

- (IBAction)SelectDate:(id)sender
{
    
}
- (IBAction)DropDown:(id)sender
{
    if (_tblDropList.hidden==YES) {
        _tblDropList.hidden=NO;
    }
    else
        _tblDropList.hidden=YES;
}
@end
