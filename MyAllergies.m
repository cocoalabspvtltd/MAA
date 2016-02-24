//
//  MyAllergies.m
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MyAllergies.h"

@interface MyAllergies ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyAllergies

- (void)viewDidLoad {
    [super viewDidLoad];
    _ppupView.hidden=YES;
    
    self.imgFloat.layer.cornerRadius = self.imgFloat.frame.size.width / 2;
    self.imgFloat.clipsToBounds = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    _childView.backgroundColor=[UIColor whiteColor];
    _ppupView.alpha=.6;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (IBAction)FloatButton:(id)sender
{
    _ppupView.hidden=NO;
    _ppupView.backgroundColor=[UIColor lightGrayColor];
    //self.view.backgroundColor=[UIColor lightGrayColor];
    
    
}
//- (IBAction)Back:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES] ;
//}
- (IBAction)Cancel:(id)sender
{
    if (_ppupView.hidden==NO)
    {
        _ppupView.hidden=YES;
        //_ppupView.backgroundColor=[UIColor whiteColor];
        self.view.backgroundColor=[UIColor whiteColor];
    }
}
@end
