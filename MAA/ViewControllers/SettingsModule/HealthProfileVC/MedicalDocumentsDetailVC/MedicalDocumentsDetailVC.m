//
//  MedicalDocumentsDetailVC.m
//  MAA
//
//  Created by Cocoalabs India on 24/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MedicalDocumentsDetailVC.h"

@interface MedicalDocumentsDetailVC ()<UITextFieldDelegate>

@end

@implementation MedicalDocumentsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGetsture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.view  addGestureRecognizer:tapGetsture];
    self.medicalDocumentImageView.image = self.medicalDocumentImage;
    // Do any additional setup after loading the view.
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tapGesture{
    [self.view endEditing:YES];
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
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cancelButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitButtonAction:(UIButton *)sender {
    if([self isValidInputs]){
        [self callingImageUploadingApiWithImage:self.medicalDocumentImage];
    }
}

#pragma mark - Image Uploading Api

-(void)callingImageUploadingApiWithImage:(UIImage *)uploadingImage{
    NSData *uploadingImageData = UIImageJPEGRepresentation(uploadingImage, 0.1);
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *fileUploadUrlString = Baseurl;
    NSString *accesstokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *imageUploadingDictionary = [[NSMutableDictionary alloc] init];
    [imageUploadingDictionary setObject:accesstoken forKey:@"token"];
    [imageUploadingDictionary setObject:self.titleTextField.text forKey:@"title"];
    [imageUploadingDictionary setObject:[NSNumber numberWithInt:2] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:fileUploadUrlString] withBody:imageUploadingDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstokenString];
    
    [[NetworkHandler sharedHandler] startUploadRequest:@"med_doc_img1.jpg" withData:uploadingImageData withType:fileTypeJPGImage withUrlParameter:AddImageurl SuccessBlock:^(id responseObject) {
        NSLog(@"Response object;%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseObject
                                  options:NSJSONReadingMutableLeaves
                                error:nil];
        [self.navigationController popViewControllerAnimated:YES];
        if(self.medicalDetailDelegate &&[self.medicalDetailDelegate respondsToSelector:@selector(imageUploadedActionDelegateWithData:)]){
            [self.medicalDetailDelegate imageUploadedActionDelegateWithData:[[jsonObject valueForKey:Datakey] objectAtIndex:0]];
        }
    } ProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:AppName message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
        NSLog(@"Error :%@",errorResponse);
    }];
}

#pragma mark textField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Validation

-(BOOL)isValidInputs{
    BOOL isValid = YES;
    NSString *errorMessage = @"";
    if([self.titleTextField.text empty]){
        errorMessage = @"Please enter title";
        isValid = NO;
    }
    if(!isValid){
        [self callingAlertViewControllerWithMessageString:errorMessage];
    }
    return isValid;
}

#pragma mark - Adding Alert View Controller

-(void)callingAlertViewControllerWithMessageString:(NSString *)alertMessage{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:alertMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
