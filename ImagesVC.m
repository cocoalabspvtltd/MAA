//
//  ImagesVC.m
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "ImagesVC.h"

@interface ImagesVC ()

@end

@implementation ImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgFloat.layer.cornerRadius = self.imgFloat.frame.size.width / 2;
    self.imgFloat.clipsToBounds = YES;
    _Addpopup.hidden=YES;
    
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

//- (IBAction)Back:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (IBAction)FloatButton:(id)sender
{
    _Addpopup.hidden=NO;
}
- (IBAction)Cancel:(id)sender
{
    if (_Addpopup.hidden==NO) {
        _Addpopup.hidden=YES;
    }
}
@end
