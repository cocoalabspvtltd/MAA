//
//  TakeAppointmentVC.m
//  MAA
//
//  Created by Cocoalabs India on 09/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "TakeAppointmentVC.h"

@interface TakeAppointmentVC ()
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;

@end

@implementation TakeAppointmentVC

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

@end
