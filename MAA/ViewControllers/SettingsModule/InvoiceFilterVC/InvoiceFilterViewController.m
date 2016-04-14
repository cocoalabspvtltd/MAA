//
//  InvoiceFilterViewController.m
//  MAA
//
//  Created by Cocoalabs India on 14/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "InvoiceFilterViewController.h"

@interface InvoiceFilterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;


@end

@implementation InvoiceFilterViewController

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
- (IBAction)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)resetButtonAction:(UIButton *)sender {
}
- (IBAction)submitButtonAction:(UIButton *)sender {
}

@end
