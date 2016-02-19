//
//  AppoinmentDetailDocVC.m
//  MAA
//
//  Created by Cocoalabs India on 19/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AppoinmentDetailDocVC.h"

@interface AppoinmentDetailDocVC ()

@end

@implementation AppoinmentDetailDocVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.prescriptionView.hidden=YES;
    _btnProfile.backgroundColor=[UIColor redColor];
    _profileView.hidden=YES;
    
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
   // if (self.viewPersonal.hidden==NO) {
        [_Scroller setContentSize:CGSizeMake(self.view.frame.size.width,705)];
        
  //  }
  //  else if (self.viewProfessional.hidden==NO)
      //  [_Scroller setContentSize:CGSizeMake(self.view.frame.size.width, self.profileView.frame.size.height)];
    
    
}

- (IBAction)Profile:(id)sender
{
    _btnProfile.backgroundColor=[UIColor redColor];
    _prescriptionView.hidden=YES;
    _btnPrescription.backgroundColor=[UIColor clearColor];
    _btnChatHistory.backgroundColor=[UIColor clearColor];
}
- (IBAction)Prescription:(id)sender
{
    
    if (self.prescriptionView.hidden==YES)
    {
        _btnPrescription.backgroundColor=[UIColor redColor];
        self.prescriptionView.hidden=NO;
        _btnProfile.backgroundColor=[UIColor clearColor];
        _btnChatHistory.backgroundColor=[UIColor clearColor];

    }
   

}
- (IBAction)ChatHistory:(id)sender
{
    _btnChatHistory.backgroundColor=[UIColor redColor];
    _btnProfile.backgroundColor=[UIColor clearColor];
    _btnPrescription.backgroundColor=[UIColor clearColor];
    
}
- (IBAction)ClickMedickalDocuments:(id)sender {
}

- (IBAction)clickImages:(id)sender {
}


- (IBAction)All:(id)sender {
}
- (IBAction)Mine:(id)sender {
}
- (IBAction)Others:(id)sender {
}
- (IBAction)AddPrescriptions:(id)sender {
}
- (IBAction)FoatAddPrescription:(id)sender {
}
@end
