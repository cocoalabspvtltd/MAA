//
//  MedicalDocumentsVC.m
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define TmdCellTag 300

#import "ImageFullView.h"
#import "MedicalDocumentsVC.h"
#import "TMDCollectionViewCell.h"
#import "PhotoGridViewController.h"
#import "MedicalDocumentsDetailVC.h"

@interface MedicalDocumentsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TMDCollectionViewCellDelegate,MedicalDocumentsDetailDelegate>
@property (nonatomic, assign) int limitValue;
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, strong) NSMutableArray *photosMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, strong) UIView *topTransparentView;
@property (nonatomic, assign) int medicalType;
@property (nonatomic, strong) ImageFullView *imageFulleView;
@property (nonatomic, assign) NSUInteger selectedIndex;
@end

@implementation MedicalDocumentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addingToptransparentView];
   //self.topTransparentView.hidden = YES;
    
    [self initialisation];
    [self addSubViews];
    self.imgFloat.layer.cornerRadius = self.imgFloat.frame.size.width / 2;
    self.imgFloat.clipsToBounds = YES;
    [self initialisingHeadingLabeltext];
    [self callingGetDocumentsApiWithType:self.medicalType];
   // [self callingImageUploadingApiWithImage:[UIImage imageNamed:@"fc_right"]];
    _AddPopup.hidden=YES;
    _editTitleViewPopup.hidden=YES;
    // Do any additional setup after loading the view.
}
-(void)addingToptransparentView
{
    self.topTransparentView = [[UIView alloc] init];
    self.topTransparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.topTransparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.topTransparentView.hidden = YES;
    [self.view addSubview:self.topTransparentView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialisation{
    self.limitValue = 20;
    self.offsetValue = 0;
    self.photosMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)initialisingHeadingLabeltext{
    if(self.isFromMedicalDocuments){
        self.medicalType = 2;
        self.headingLabel.text = @"Medical Documents";
    }
    else if (self.isFromImages){
        self.medicalType = 1;
        self.headingLabel.text = @"Images";
    }
    else if (self.isFromPrescriptions){
        self.headingLabel.text = @"Prescriptions";
    }
}

-(void)addSubViews{
    [self.view addSubview:self.bottomProgressIndicatorView];
}

-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
}
#pragma mark - Collection View Data sources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosMutableArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TMDCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tmdReuseCollectionCell" forIndexPath:indexPath];
    photoCell.backgroundColor = [UIColor greenColor];
    photoCell.tmdCellDelegate = self;
    photoCell.tag = indexPath.row+TmdCellTag;
    NSString *imageUrlString = [[self.photosMutableArray objectAtIndex:indexPath.row] valueForKey:@"url"];
    NSLog(@"Image Url:%@",imageUrlString);
    [photoCell.medicalDocumentImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    return photoCell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.imageFulleView = [[[NSBundle mainBundle]
                            loadNibNamed:@"ImageFullView"
                            owner:self options:nil]
                           firstObject];
    CGFloat xMargin = 0,yMargin = 20;
    self.imageFulleView.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - yMargin);
    self.imageFulleView.selecetdIndex = (int)indexPath.row;
    self.imageFulleView.imagesArray = self.photosMutableArray;
    [self.view addSubview:self.imageFulleView];
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
    self.topTransparentView.hidden=NO;
        _AddPopup.hidden=NO;
    [self.topTransparentView addSubview:_AddPopup];
   // _AddPopup.superview.backgroundColor=[UIColor lightGrayColor];
    
    
//    _AddPopup.superview.alpha=.06;
}

//- (IBAction)Back:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (IBAction)Cancel:(id)sender
{
    self.topTransparentView.hidden=YES;
        _AddPopup.hidden=YES;
       // _AddPopup.superview.backgroundColor=[UIColor whiteColor];
    
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)takePhotoButtonAction:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
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
    _AddPopup.hidden=YES;
    self.topTransparentView.hidden=YES;
}

- (IBAction)chooseLibraryButtonAction:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    _AddPopup.hidden=YES;
    self.topTransparentView.hidden=YES;
}

#pragma mark - Image Picker Delegates

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *chosenImage  = [[CLUtilities standardUtilities] scaleAndRotateImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    if(self.medicalType == 2){
        [self addingTitleEditingViewControllerWithChhosenImage:chosenImage];
    }
    else{
        [self callingImageUploadingApiWithImage:chosenImage];
    }
    
}

-(void)addingTitleEditingViewControllerWithChhosenImage:(UIImage *)choosenImage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MedicalDocumentsDetailVC *medicalDocumentsDetailVC = (MedicalDocumentsDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"MedicalDocumentsDetailVC"];
    medicalDocumentsDetailVC.medicalDocumentImage = choosenImage;
    medicalDocumentsDetailVC.medicalDetailDelegate = self;
    [self.navigationController pushViewController:medicalDocumentsDetailVC animated:YES];
}

#pragma mark - Medical Document Detail Delegates

-(void)imageUploadedActionDelegateWithData:(id)uploadedImageDetails{
    [self.photosMutableArray insertObject:uploadedImageDetails atIndex:0];
    [self callingAlertViewControllerWithMessageString:@"Medical Document added successfully"];
    [self.medicalDocumentsCollectionView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

//- (IBAction)chooseFromGalleryButtonAction:(UIButton *)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PhotoGridViewController *photoGridViewController = (PhotoGridViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PhotoGridViewController"];
//    photoGridViewController.isFromMedicalDocuments = self.isFromMedicalDocuments;
//    photoGridViewController.isFromImages = self.isFromImages;
//    photoGridViewController.isFromePrescriptions = self.isFromPrescriptions;
//    [self.navigationController pushViewController:photoGridViewController animated:YES];
//    _AddPopup.hidden=YES;
//    _topTransparentView.hidden=YES;
//    
//}

-(void)callingImageUploadingApiWithImage:(UIImage *)uploadingImage{
    NSData *uploadingImageData = UIImageJPEGRepresentation(uploadingImage, 0.1);
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *fileUploadUrlString = Baseurl;
    NSString *accesstokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *imageUploadingDictionary = [[NSMutableDictionary alloc] init];
    [imageUploadingDictionary setObject:accesstoken forKey:@"token"];
    [imageUploadingDictionary setObject:[NSNumber numberWithInt:self.medicalType] forKey:@"type"];
    NSLog(@"Image upload:%@",imageUploadingDictionary);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:fileUploadUrlString] withBody:imageUploadingDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstokenString];
    
    [[NetworkHandler sharedHandler] startUploadRequest:@"med_doc_img1.jpg" withData:uploadingImageData withType:fileTypeJPGImage withUrlParameter:AddImageurl SuccessBlock:^(id responseObject) {
        NSLog(@"Response object;%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self callingAlertViewControllerWithMessageString:@"Document added successfully"];
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseObject
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        [self.photosMutableArray insertObject:[[jsonObject valueForKey:Datakey] objectAtIndex:0] atIndex:0];
        NSLog(@"Json:%@",jsonObject);
        [self.medicalDocumentsCollectionView reloadData];
    } ProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

#pragma mark - Get Images Api

-(void)callingGetDocumentsApiWithType:(int)type{
    NSString *getDocumentsApiUrlSrtring = [Baseurl stringByAppendingString:GetHealthProfilImagesUrl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getDocumentsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getDocumentsMutableDictionary setValue:accessToken forKey:@"token"];
    [getDocumentsMutableDictionary setValue:[NSNumber numberWithInt:type] forKey:@"type"];
    [getDocumentsMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getDocumentsMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getDocumentsApiUrlSrtring] withBody:getDocumentsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
       
        self.offsetValue = self.offsetValue+self.limitValue;
        [self.bottomProgressIndicatorView stopAnimating];
        NSArray *imagesArray = [responseObject valueForKey:Datakey];
        [self.photosMutableArray addObjectsFromArray:imagesArray];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.medicalDocumentsCollectionView reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [self.bottomProgressIndicatorView stopAnimating];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.medicalDocumentsCollectionView){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self callingGetDocumentsApiWithType:self.medicalType];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}

- (IBAction)cancelEditTitlePopup:(id)sender
{
    self.topTransparentView.hidden=YES;
    _editTitleViewPopup.hidden=YES;
    [self.popUpTitleTextField resignFirstResponder];
}

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

#pragma mark - TMD cell delegate

-(void)longPressActionWithIndex:(NSUInteger)cellIndex{
    NSUInteger selectedIndex = cellIndex - TmdCellTag;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    if(self.isFromMedicalDocuments){
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit Title" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
                                    if (_editTitleViewPopup.hidden==YES)
                                    {
                                        
                                        self.topTransparentView.hidden=NO;
                                        _editTitleViewPopup.hidden=NO;
                                        self.selectedIndex = selectedIndex;
                                        [self.topTransparentView addSubview:_editTitleViewPopup];
                                        self.popUpTitleTextField.text = [[self.photosMutableArray objectAtIndex:selectedIndex] valueForKey:@"title"];
                                    }
                                    
                                }]];
    }
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self callingEditOrDeleteDocumentsApiWithStatus:0 withSelectdIndex:self.selectedIndex];
        // choose photo button tapped.
        // [self choosePhoto];
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)updateButtonAction:(UIButton *)sender {
    if([self isValidInputPopUpCredentials]){
        [self callingEditOrDeleteDocumentsApiWithStatus:1 withSelectdIndex:self.selectedIndex];
    }
}

#pragma mark - Calling Delete Or Edi Api of Document

-(void)callingEditOrDeleteDocumentsApiWithStatus:(int)status withSelectdIndex:(NSUInteger)selectedIndex{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *editAccountInfoUrlString = [Baseurl stringByAppendingString:EditAccountInfoUrl];
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *contentDictionary = [[NSMutableDictionary alloc] init];
    [contentDictionary setValue:[NSNumber numberWithInt:status] forKey:@"status"];
    NSString *titleString = [[self.photosMutableArray objectAtIndex:selectedIndex] valueForKey:@"title"];
    NSString *idString = [[self.photosMutableArray objectAtIndex:selectedIndex] valueForKey:@"id"];
    if(status == 0){
        [contentDictionary setValue:titleString forKey:@"title"];
    }
    else{
        [contentDictionary setValue:self.popUpTitleTextField.text forKey:@"title"];
    }
    [contentDictionary setValue:idString forKey:@"id"];
    NSMutableArray *contentsArray = [[NSMutableArray alloc] init];
    [contentsArray addObject:contentDictionary];
    NSMutableDictionary *editAccountInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [editAccountInfoMutableDictionary setValue:contentsArray forKey:@"medical_docs"];
    [editAccountInfoMutableDictionary setValue:tokenString forKey:@"token"];
    NSLog(@"Edit Account Dictionary:%@",editAccountInfoMutableDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:editAccountInfoUrlString] withBody:editAccountInfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object:%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(status == 0){
            [self.photosMutableArray removeObjectAtIndex:selectedIndex];
            [self callingAlertViewControllerWithMessageString:@"Document removed successfully"];
        }
        else{
            NSString *dateString = [[self.photosMutableArray objectAtIndex:selectedIndex] valueForKey:@"date"];
            NSString *urlString = [[self.photosMutableArray objectAtIndex:selectedIndex] valueForKey:@"url"];
            [contentDictionary setValue:dateString forKey:@"date"];
            [contentDictionary setValue:urlString forKey:@"url"];
            [self.photosMutableArray replaceObjectAtIndex:selectedIndex withObject:contentDictionary];
            [self callingAlertViewControllerWithMessageString:@"Document updated successfully"];
            self.popUpTitleTextField.text  =@"";
            self.topTransparentView.hidden=YES;
            _AddPopup.hidden=YES;
        }
        [self.medicalDocumentsCollectionView reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        [self callingAlertViewControllerWithMessageString:errorMessage];
    }];
}

-(BOOL)isValidInputPopUpCredentials{
    BOOL isValid = YES;
    NSString *errorMessageString = @"";
    if([self.popUpTitleTextField.text empty]){
        errorMessageString = @"Please enter title";
        isValid = NO;
    }
    if(![errorMessageString empty]){
        [self callingAlertViewControllerWithMessageString:errorMessageString];
    }
    return isValid;
}
@end
