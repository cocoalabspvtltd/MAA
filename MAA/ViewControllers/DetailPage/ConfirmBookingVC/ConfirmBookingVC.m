//
//  ConfirmBookingVC.m
//  MAA
//
//  Created by Cocoalabs India on 18/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "ConfirmBookingVC.h"

@interface ConfirmBookingVC ()

@end

@implementation ConfirmBookingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.dateLabel.text  = self.dateString;
    self.timeLabel.text = self.timeString;
    self.amountLabel.text = self.amountString;
    self.locationLabel.text = self.locationString;
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
- (IBAction)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirmButtonAction:(UIButton *)sender {
    
}

@end
