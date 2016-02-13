//
//  DoctorRegistrationVC.m
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorRegistrationVC.h"

@interface DoctorRegistrationVC ()<UIActionSheetDelegate>

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

- (IBAction)medicalregistationDocumnetbuttonAction:(UIButton *)sender {
    [self addingActionSheet];
}

- (IBAction)medicalRegistrationbuttonAction:(UIButton *)sender {
    [self addingActionSheet];
}
- (IBAction)governmentIdProofButtonAction:(UIButton *)sender {
    [self addingActionSheet];
}
- (IBAction)prescriptionLetterHeaderCopyButtonAction:(UIButton *)sender {
    [self addingActionSheet];
}


#pragma mark - Adding Action Sheet

-(void)addingActionSheet{
    NSString *actionSheetTitle = @"Choose Photos"; //Action Sheet Title
    NSString *cameraTitle = @"Camera"; //Action Sheet Button Titles
    NSString *galleryTitle = @"Gallery";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet;
    actionSheet = [[UIActionSheet alloc]
                   initWithTitle:actionSheetTitle
                   delegate:self
                   cancelButtonTitle:cancelTitle
                   destructiveButtonTitle:cameraTitle
                   otherButtonTitles:galleryTitle, nil];
    [actionSheet showInView:self.view];
}




- (IBAction)submitButtonAction:(UIButton *)sender {
}

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
