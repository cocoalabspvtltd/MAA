//
//  ViewProfileVC.m
//  MAA
//
//  Created by Cocoalabs India on 15/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "ViewProfileVC.h"

@interface ViewProfileVC ()
{
    NSArray *Specialization;
    NSArray *Memberships;
    NSArray *Awards;
    NSArray *Education;
    NSArray *Experience;
    NSArray *Services;
}

@end

@implementation ViewProfileVC

- (void)viewDidLoad
{
    self.viewProfessional.hidden=YES;
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

- (IBAction)personal:(id)sender
{
    if (self.viewPersonal.hidden==YES) {
        self.viewPersonal.hidden=NO;
        
    }
    else
        self.viewPersonal.hidden=YES;
    
}

- (IBAction)professional:(id)sender
{
    if (self.viewProfessional.hidden==YES) {
        self.viewProfessional.hidden=NO;
    }
    else
        self.viewProfessional.hidden=YES;
}
@end
