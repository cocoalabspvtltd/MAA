//
//  DoctorRegistrationVC.m
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "PhotoGridViewController.h"
#import "DoctorRegistrationVC.h"

@interface DoctorRegistrationVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,assign) BOOL isMedicalRegistarionDocumentButtonSelected;
@property (nonatomic,assign) BOOL isCertificatemedicalDegreeButtonSelected;
@property (nonatomic,assign) BOOL governmentIdproofButtonSelected;
@property (nonatomic, assign) BOOL presriptionHeaderCopyButtonSelected;
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
    self.isMedicalRegistarionDocumentButtonSelected = YES;
    self.isCertificatemedicalDegreeButtonSelected = NO;
    self.governmentIdproofButtonSelected = NO;
    self.presriptionHeaderCopyButtonSelected = NO;
    [self addingActionSheet];
}

- (IBAction)certificateMedicalDegreeRegistrationbuttonAction:(UIButton *)sender {
    self.isMedicalRegistarionDocumentButtonSelected = NO;
    self.isCertificatemedicalDegreeButtonSelected = YES;
    self.governmentIdproofButtonSelected = NO;
    self.presriptionHeaderCopyButtonSelected = NO;
    [self addingActionSheet];
}
- (IBAction)governmentIdProofButtonAction:(UIButton *)sender {
    self.isMedicalRegistarionDocumentButtonSelected = NO;
    self.isCertificatemedicalDegreeButtonSelected = NO;
    self.governmentIdproofButtonSelected = YES;
    self.presriptionHeaderCopyButtonSelected = NO;
    [self addingActionSheet];
}
- (IBAction)prescriptionLetterHeaderCopyButtonAction:(UIButton *)sender {
    self.isMedicalRegistarionDocumentButtonSelected = NO;
    self.isCertificatemedicalDegreeButtonSelected = NO;
    self.governmentIdproofButtonSelected = NO;
    self.presriptionHeaderCopyButtonSelected = YES;
    [self addingActionSheet];
}


#pragma mark - Adding Action Sheet

-(void)addingActionSheet{
    NSString *actionSheetTitle = @"Choose Photos"; //Action Sheet Title
    NSString *cameraTitle = @"Camera"; //Action Sheet Button Titles
    NSString *galleryTitle = @"Gallery";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                   initWithTitle:actionSheetTitle
                   delegate:self
                   cancelButtonTitle:cancelTitle
                   destructiveButtonTitle:cameraTitle
                   otherButtonTitles:galleryTitle, nil];
    [actionSheet showInView:self.view];
}

#pragma mark - Action sheet Delegates

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    if(buttonIndex == 0){
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *noCameraAlertView = [[UIAlertView alloc] initWithTitle:AppName
                                                                        message:@"Device has no camera"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles: nil];
            
            [noCameraAlertView show];
            
        }
        else{
            if([[CLUtilities standardUtilities] goToCamera]){
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:NULL];
            }
        }
    }
    else if(buttonIndex == 1){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
        PhotoGridViewController *photoGridViewCntrlr = [sb instantiateViewControllerWithIdentifier:@"PhotoGridViewController"];
        photoGridViewCntrlr.isFromMedicalRegitrationFromDR = self.isMedicalRegistarionDocumentButtonSelected;
        photoGridViewCntrlr.isFromMedicalDegreeFromDR = self.isCertificatemedicalDegreeButtonSelected;
        photoGridViewCntrlr.isFromGovernmentIdFromDR = self.governmentIdproofButtonSelected;
        photoGridViewCntrlr.isFromPrescriptionLetterFromDR = self.presriptionHeaderCopyButtonSelected;
        [self presentViewController:photoGridViewCntrlr animated:YES completion:nil];
//        [self.navigationController pushViewController:photoGridViewCntrlr animated:YES];
        photoGridViewCntrlr.title = @"Gallery Photos";
    }
    
}

#pragma mark - Image Picker Delegates

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //UIImage *chosenImage  = [[CLUtilities standardUtilities] scaleAndRotateImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
 //   NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.5);
//    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:GiftImageKeyForUserDefaults];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



- (IBAction)submitButtonAction:(UIButton *)sender {
}

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
