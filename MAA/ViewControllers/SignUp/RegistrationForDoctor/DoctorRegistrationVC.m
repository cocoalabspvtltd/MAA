//
//  DoctorRegistrationVC.m
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorRegistrationVC.h"

@interface DoctorRegistrationVC ()

@end

@implementation DoctorRegistrationVC

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
- (IBAction)medicalregistationDocumnetbuttonAction:(UIButton *)sender {
}

- (IBAction)medicalRegistrationbuttonAction:(UIButton *)sender {
}
- (IBAction)governmentIdProofButtonAction:(UIButton *)sender {
}
- (IBAction)prescriptionLetterHeaderCopyButtonAction:(UIButton *)sender {
}
- (IBAction)submitButtonAction:(UIButton *)sender {
}
@end
