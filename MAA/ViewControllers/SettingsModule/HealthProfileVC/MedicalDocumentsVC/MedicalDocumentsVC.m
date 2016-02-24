//
//  MedicalDocumentsVC.m
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MedicalDocumentsVC.h"
#import "TMDCollectionViewCell.h"
#import "PhotoGridViewController.h"

@interface MedicalDocumentsVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation MedicalDocumentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgFloat.layer.cornerRadius = self.imgFloat.frame.size.width / 2;
    self.imgFloat.clipsToBounds = YES;
    //[self callingGetDocumentsApi];
   // [self callingImageUploadingApiWithImage:[UIImage imageNamed:@"fc_right"]];
    _AddPopup.hidden=YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data sources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TMDCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tmdReuseCollectionCell" forIndexPath:indexPath];
    //photoCell.profileImageUrl = [self.photosFinalArray objectAtIndex:indexPath.row];
    photoCell.backgroundColor = [UIColor greenColor];
    return photoCell;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)floatButton:(id)sender
{
    
        _AddPopup.hidden=NO;
    _AddPopup.superview.backgroundColor=[UIColor lightGrayColor];
    
    
//    _AddPopup.superview.alpha=.06;
}

//- (IBAction)Back:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (IBAction)Cancel:(id)sender
{
    
        _AddPopup.hidden=YES;
        _AddPopup.superview.backgroundColor=[UIColor whiteColor];
    
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)takePhotoButtonAction:(UIButton *)sender {
    _AddPopup.hidden=YES;
}

- (IBAction)chooseFromGalleryButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PhotoGridViewController *photoGridViewController = (PhotoGridViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PhotoGridViewController"];
    photoGridViewController.isFromMedicalDocuments = self.isFromMedicalDocuments;
    photoGridViewController.isFromImages = self.isFromImages;
    photoGridViewController.isFromePrescriptions = self.isFromPrescriptions;
    [self.navigationController pushViewController:photoGridViewController animated:YES];
    _AddPopup.hidden=YES;
}


#pragma mark - Get Images Api

-(void)callingGetDocumentsApi{
    NSString *getDocumentsApiUrlSrtring = [Baseurl stringByAppendingString:GetHealthProfilImagesUrl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getDocumentsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getDocumentsMutableDictionary setValue:accessToken forKey:@"token"];
    [getDocumentsMutableDictionary setValue:@"1" forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getDocumentsApiUrlSrtring] withBody:getDocumentsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object:%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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


-(void)callingImageUploadingApiWithImage:(UIImage *)uploadingImage{
    NSData *uploadingImageData = UIImageJPEGRepresentation(uploadingImage, 0.1);
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *fileUploadUrlString = Baseurl;
    NSString *accesstokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *imageUploadingDictionary = [[NSMutableDictionary alloc] init];
    [imageUploadingDictionary setObject:accesstoken forKey:@"token"];
    [imageUploadingDictionary setObject:@"Title1" forKey:@"title"];
      [imageUploadingDictionary setObject:@"1" forKey:@"type"];
    NSLog(@"Image Uploading Dictionary:%@",imageUploadingDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:fileUploadUrlString] withBody:imageUploadingDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstokenString];
   
    [[NetworkHandler sharedHandler] startUploadRequest:@"med_doc_img1.jpg" withData:uploadingImageData withType:fileTypeJPGImage withUrlParameter:AddImageurl SuccessBlock:^(id responseObject) {
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseObject
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        NSLog(@"jsonObject is %@",jsonObject);
        
    } ProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"Error Response:%@",errorResponse);
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

@end
