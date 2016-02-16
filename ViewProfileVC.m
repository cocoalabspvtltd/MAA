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
    self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.width / 2;
    self.imgprofile.clipsToBounds = YES;
    self.btnpersonal.backgroundColor=[UIColor redColor];
    
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

-(void) viewDidLayoutSubviews
{
    if (self.viewPersonal.hidden==NO) {
        [_scroller setContentSize:CGSizeMake(self.view.frame.size.width, 870)];

    }
    else if (self.viewProfessional.hidden==NO)
        [_scroller setContentSize:CGSizeMake(self.view.frame.size.width, 1432)];
 
        
}

- (IBAction)personal:(id)sender
{
    
    
    
        self.viewProfessional.hidden=YES;
        self.btnprofessional.backgroundColor=[UIColor clearColor];
        self.btnpersonal.backgroundColor=[UIColor redColor];
        [_scroller setContentSize:CGSizeMake(self.view.frame.size.width, 870)];
        
    

   }

- (IBAction)professional:(id)sender
{
        self.viewProfessional.hidden=NO;
        self.btnprofessional.backgroundColor=[UIColor redColor];
        self.btnpersonal.backgroundColor=[UIColor clearColor];
        [_scroller setContentSize:CGSizeMake(self.view.frame.size.width, 1432)];
}
@end
