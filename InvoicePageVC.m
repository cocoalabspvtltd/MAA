//
//  InvoicePageVC.m
//  MAA
//
//  Created by Cocoalabs India on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "InvoicePageVC.h"

@interface InvoicePageVC ()

@end

@implementation InvoicePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblMonth.hidden=YES;
    _tblYear.hidden=YES;
    
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
    _tblYear.hidden=YES;
}
@end
