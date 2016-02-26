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

@interface MedicalDocumentsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, assign) int limitValue;
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, strong) NSMutableArray *photosMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, strong) UIView *topTransparentView;
@property (nonatomic, assign) int medicalType;
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
    if(self.isFromImages){
        self.medicalType = 1;
    }
    else if(self.isFromMedicalDocuments){
        self.medicalType = 1;
    }
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
    self.topTransparentView.backgroundColor = [UIColor blackColor];
    self.topTransparentView.layer.opacity = 0.5;
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
        self.headingLabel.text = @"Medical Documents";
    }
    else if (self.isFromImages){
        self.headingLabel.text = @"Images";
    }
    else if (self.isFromAllergies){
        self.headingLabel.text = @"Allergies";
        self.imgFloat.hidden = YES;
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
    self.longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressTap:)];
    [photoCell addGestureRecognizer:_longPress];
    NSString *imageUrlString = [[self.photosMutableArray objectAtIndex:indexPath.row] valueForKey:@"url"];
    [photoCell.medicalDocumentImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
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
-(void)longPressTap:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped do nothing.
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit Title" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        if (_editTitleViewPopup.hidden==YES)
        {
           
            self.topTransparentView.hidden=NO;
            _editTitleViewPopup.hidden=NO;
            [self.topTransparentView addSubview:_editTitleViewPopup];
        }
        
        // take photo button tapped.
        //[self takePhoto];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // choose photo button tapped.
       // [self choosePhoto];
        
    }]];
    
//    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete Photo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        
//         Distructive button tapped.
//        [self deletePhoto];
//        
//    }]];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}
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

- (IBAction)chooseFromGalleryButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PhotoGridViewController *photoGridViewController = (PhotoGridViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PhotoGridViewController"];
    photoGridViewController.isFromMedicalDocuments = self.isFromMedicalDocuments;
    photoGridViewController.isFromImages = self.isFromImages;
    photoGridViewController.isFromePrescriptions = self.isFromPrescriptions;
    [self.navigationController pushViewController:photoGridViewController animated:YES];
    _AddPopup.hidden=YES;
    _topTransparentView.hidden=YES;
    
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
        NSLog(@"Response Object:%@",responseObject);
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
}
@end
