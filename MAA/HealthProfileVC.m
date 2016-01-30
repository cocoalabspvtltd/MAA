//
//  ProfilePageVC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "HealthProfileVC.h"
#import "PerescriptionsTVC.h"
#import "MedicalDocumantsCVC.h"
#import "HealthProfileUserPhotosCVC.h"


@interface HealthProfileVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSArray *userImagesArray;
@property (nonatomic, strong) NSArray *medicalDocumentsArray;
@property (nonatomic, strong) NSArray *prescriptionsArray;
@property (nonatomic, strong) NSArray *genderArray;
@property (nonatomic, strong) UIPickerView *genderPickerView;
@property (nonatomic, strong) NSString *stringGenderValue;
@property (nonatomic, strong) UIDatePicker *dobDatePicker;
@property (nonatomic, strong) NSString *DOBstringValue;
@end

@implementation HealthProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGenderPickerDoneToolBar];
    self.genderPickerView = [[UIPickerView alloc] init];
    self.genderPickerView.tag = 101;
    self.genderPickerView.dataSource = self;
    self.genderPickerView.delegate = self;
    self.genderArray = @[@"Male",@"Female",@"Unspecified"];
    self.gendertextField.inputView = self.genderPickerView;
    [self initialisingDOBDatePicker];
    self.dateOfBirthTextField.inputView = self.dobDatePicker;
    [self addDOBPickerDoneToolBar];
    [self callingHealthProfileApi];
    
    // Do any additional setup after loading the view.
}

-(void)addGenderPickerDoneToolBar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched3:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.gendertextField.inputAccessoryView = toolBar;
}


- (void)doneTouched3:(id)sender
{
    [self.view endEditing:YES];
    self.gendertextField.text = self.stringGenderValue;
}


-(void)initialisingDOBDatePicker{
    self.dobDatePicker = [[UIDatePicker alloc] init];
    self.dobDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.dobDatePicker setDate:[NSDate date]];
    [self.dobDatePicker setMaximumDate:[NSDate date]];
    [self.dobDatePicker addTarget:self action:@selector(dobPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - PickerViewToolBar

-(void)addDOBPickerDoneToolBar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.dateOfBirthTextField.inputAccessoryView = toolBar;
}

- (void)doneTouched:(id)sender
{
    [self.view endEditing:YES];
    if(self.DOBstringValue == nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        self.DOBstringValue = [dateFormatter stringFromDate:[NSDate date]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
       // self.dobApiValueString = [dateFormatter stringFromDate:[self.dobDatePicker date]];
    }
    self.dateOfBirthTextField.text = self.DOBstringValue;
    [self.dateOfBirthTextField resignFirstResponder];
}

-(void)dobPickerValueChanged:(UIDatePicker *)picker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    self.DOBstringValue = [dateFormatter stringFromDate:[self.dobDatePicker date]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    self.dobApiValueString = [dateFormatter stringFromDate:[self.dobDatePicker date]];
//    NSLog(@"DOB Apim String:%@",self.dobApiValueString);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Picker View Data Source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 101){
        return self.genderArray.count;
    }
    return 0;
}

#pragma mark - Picker View Delegates

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(pickerView.tag == 101){
        if (row==0) {
            self.stringGenderValue = [self.genderArray objectAtIndex:0];
            //self.genderIndex = 0;
        }
        return [self.genderArray objectAtIndex:row];
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView.tag == 101){
        self.stringGenderValue = [self.genderArray objectAtIndex:row];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)callingHealthProfileApi{
    NSString *getAccountInfoApiUrlSrtring = [Baseurl stringByAppendingString:getAccountinfoApiurl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *healthinfoMutableDictionary = [[NSMutableDictionary alloc] init];
    NSArray *fieldArray = [NSArray arrayWithObjects:@"name",@"location",@"e_base_img",@"e_banner_img",@"dob",@"about",@"address",@"phone",@"gender",@"health_profile",@"images",@"medical_docs",@"prescription", nil];
    [healthinfoMutableDictionary setValue:accessToken forKey:@"token"];
    [healthinfoMutableDictionary setValue:fieldArray forKey:@"fields"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getAccountInfoApiUrlSrtring] withBody:healthinfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [self populatingHealthDetailsWithResponsedata:[responseObject valueForKey:Datakey]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response :%@",responseObject);
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


- (IBAction)editButtonAction:(UIButton *)sender {
    self.phoneTextField.enabled = YES;
    self.heightTextField.enabled = YES;
    self.weightTextField.enabled = YES;
    self.bloodGroupTextField.enabled = YES;
    self.dateOfBirthTextField.enabled = YES;
    self.bloodGroupTextField.enabled = YES;
    self.gendertextField.enabled = YES;
    self.highbpTextField.enabled = YES;
    self.lowbpTextField.enabled = YES;
    self.fastingSugartextField.enabled = YES;
    self.postMealTextField.enabled = YES;
}

-(void)populatingHealthDetailsWithResponsedata:(id)profileData{
    NSLog(@"Health Data:%@",profileData);
    if(!([profileData valueForKey:@"e_base_img"] == [NSNull null])){
        [self downloadingProfileImageWithUrlString:[profileData valueForKey:@"e_base_img"]];
    }
    if(!([profileData valueForKey:@"e_banner_img"] == [NSNull null])){
        [self downloadingProfileBackgroundImageWithurlString:[profileData valueForKey:@"e_banner_img"]];
    }
    if(!([profileData valueForKey:@"name"] == [NSNull null])){
        self.nameLabel.text = [profileData valueForKey:@"name"];
    }
    if(!([profileData valueForKey:@"location"] == [NSNull null])){
        self.locationlabel.text = [profileData valueForKey:@"location"];
    }
    if(!([profileData valueForKey:@"address"] == [NSNull null])){
        self.addresslabel.text = [profileData valueForKey:@"address"];
    }
    if(!([profileData valueForKey:@"phone"] == [NSNull null])){
        self.phoneTextField.text = [profileData valueForKey:@"phone"];
    }
    if(!([[profileData valueForKey:@"health_profile"] valueForKey:@"weight"] == [NSNull null])){
        self.weightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"weight"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"height"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"height"];
    }
    if (!([[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"] == [NSNull null])){
        self.heightTextField.text = [[[profileData valueForKey:@"health_profile"] valueForKey:@"blood_group"] valueForKey:@"name"];
    }
    if(!([profileData valueForKey:@"dob"] == [NSNull null])){
        self.dateOfBirthTextField.text = [profileData valueForKey:@"dob"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"low_bp"];
    }
    if (!([[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"] == [NSNull null])){
        self.heightTextField.text = [[profileData valueForKey:@"health_profile"] valueForKey:@"high_bp"];
    }
    self.userImagesArray = [profileData valueForKey:@"images"];
    [self.photosCollectionView reloadData];
    self.medicalDocumentsArray = [profileData valueForKey:@"medical_docs"];
    [self.medicalDocumantsCollectionview reloadData];
    self.prescriptionsArray = [profileData valueForKey:@"prescription"];
    [self.prescriptionsTableView reloadData];
}

-(void)viewWillLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1400);
}

#pragma mark - Dowloading Profile images

-(void)downloadingProfileImageWithUrlString:(NSString *)profileImageUrlString{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/UserImages"];
    NSString *profileImageIdntifier = @"profileImage";
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:profileImageIdntifier];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:self.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrlString]];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:profileImageIdntifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.profileImageView.image = tempImage;
                [MBProgressHUD hideAllHUDsForView:self.profileImageView animated:YES];
            }
                           );
        });
    }
    else{
        self.profileImageView.image = localImage;
    }
}

-(void)downloadingProfileBackgroundImageWithurlString:(NSString *)profileBackUrlString{
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/UserImages"];
    NSString *profileImageIdntifier = @"profileBackImage";
    UIImage *localImage;
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:profileImageIdntifier];
    if(!localImage){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileBackUrlString]];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:profileImageIdntifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.profileBackgroundImageView.image = tempImage;
            }
                           );
        });
    }
    else{
        self.profileBackgroundImageView.image = localImage;
    }

}

#pragma mark - Table view Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.prescriptionsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PerescriptionsTVC *prescriptionCell = [tableView dequeueReusableCellWithIdentifier:@"prescriptionCell"];
    prescriptionCell.imageUrlString = [[self.prescriptionsArray objectAtIndex:indexPath.row] valueForKey:@"image"];
    prescriptionCell.nameLabel.text = [[self.prescriptionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    prescriptionCell.dateLabel.text = [[self.prescriptionsArray objectAtIndex:indexPath.row] valueForKey:@"date"];
    return prescriptionCell;
}

#pragma mark - Collection View Datasources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.photosCollectionView){
        return self.userImagesArray.count;
    }
    else if (collectionView == self.medicalDocumantsCollectionview){
        return self.medicalDocumentsArray.count;
    }
    else
        return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.photosCollectionView){
        HealthProfileUserPhotosCVC *healthProfileCVC = [collectionView dequeueReusableCellWithReuseIdentifier:@"healthProfilePhotoCell" forIndexPath:indexPath];
        healthProfileCVC.imageUrlString = [[self.userImagesArray  objectAtIndex:indexPath.row] valueForKey:@"image"];
        return healthProfileCVC;
    }
    else if (collectionView == self.medicalDocumantsCollectionview){
        MedicalDocumantsCVC *medicalCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"medicalDocumentsCell" forIndexPath:indexPath];
        medicalCollectionViewCell.medicalDocumantImageUrlString = [[self.medicalDocumentsArray objectAtIndex:indexPath.row] valueForKey:@"image"];
        medicalCollectionViewCell.medicalDocumantsCoverImageview.backgroundColor = [UIColor lightGrayColor];
        medicalCollectionViewCell.documantNameLabel.text = [[self.medicalDocumentsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        medicalCollectionViewCell.documantDatLabel.text = [[self.medicalDocumentsArray objectAtIndex:indexPath.row] valueForKey:@"date"];
        return medicalCollectionViewCell;
    }
    else{
        return nil;
    }
}
@end
