//
//  MedicalDocumentsVC.m
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MedicalDocumentsVC.h"

@interface MedicalDocumentsVC ()

@end

@implementation MedicalDocumentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgFloat.layer.cornerRadius = self.imgFloat.frame.size.width / 2;
    self.imgFloat.clipsToBounds = YES;
    
    _AddPopup.hidden=YES;
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

- (IBAction)floatButton:(id)sender
{
    
        _AddPopup.hidden=NO;
    _AddPopup.superview.backgroundColor=[UIColor lightGrayColor];
    
    
//    _AddPopup.superview.alpha=.06;
}

//- (IBAction)Back:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (IBAction)Cancel:(id)sender
{
    
        _AddPopup.hidden=YES;
        _AddPopup.superview.backgroundColor=[UIColor whiteColor];
    
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
