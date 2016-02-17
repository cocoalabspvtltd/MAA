//
//  PhotoGridViewController.m
//  MAA
//
//  Created by Cocoalabs India on 01/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define PhotoCollectionviewCellIdentifier @"photoCollectionViewCell"

#import "GetGalleryPhotos.h"
#import "PhotoGridViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotogridCollectionViewCell.h"


@interface PhotoGridViewController ()
@property (nonatomic, strong) NSArray *galleryPhotosArray;
@property (nonatomic, strong) NSIndexPath *previousIndexPath;
@property (nonatomic, strong) NSMutableArray *selectedGalleryphotosArray;
@end

@implementation PhotoGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    self.previousIndexPath == nil;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UINib *nib = [UINib nibWithNibName:@"PhotogridCollectionViewCell" bundle: nil];
    [self.photoCollectionView registerNib:nib forCellWithReuseIdentifier:PhotoCollectionviewCellIdentifier];
    [[GetGalleryPhotos getGelleryPhotosUtilities] gettingPhotosFromGallery:^(NSMutableArray *photos) {
        self.galleryPhotosArray = photos;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.photoCollectionView reloadData];
    }];
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.selectedGalleryphotosArray = [[NSMutableArray alloc] init];
    
    [self settingChooseButtontitle];
}

-(void)settingChooseButtontitle{
    if(self.isFromMedicalRegitrationFromDR){
        self.photoCollectionView.allowsMultipleSelection = NO;
        [self.uploadPhotosButton setTitle:@"Choose Medical registration Certificate" forState:UIControlStateNormal];
    }
    else if (self.isFromMedicalDegreeFromDR){
        self.photoCollectionView.allowsMultipleSelection = NO;
        [self.uploadPhotosButton setTitle:@"Choose Medical Degree Certificate" forState:UIControlStateNormal];
    }
    else if (self.isFromGovernmentIdFromDR){
        self.photoCollectionView.allowsMultipleSelection = NO;
        [self.uploadPhotosButton setTitle:@"Choose Government ID Proof" forState:UIControlStateNormal];
    }
    else if (self.isFromPrescriptionLetterFromDR){
        self.photoCollectionView.allowsMultipleSelection = NO;
        [self.uploadPhotosButton setTitle:@"Choose Prescription Letter" forState:UIControlStateNormal];
    }
    else{
       self.photoCollectionView.allowsMultipleSelection = YES;
    }
}

#pragma mark - Collection View Datasources

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.galleryPhotosArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotogridCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionviewCellIdentifier forIndexPath:indexPath];
    ALAsset * asset = [self.galleryPhotosArray objectAtIndex:indexPath.row];
    photoCell.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    if([self.selectedGalleryphotosArray containsObject:[self.galleryPhotosArray objectAtIndex:indexPath.row]]){
        photoCell.tickImageView.hidden = NO;
    }
    else{
         photoCell.tickImageView.hidden = YES;
    }
    return photoCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotogridCollectionViewCell *selectedCell = (PhotogridCollectionViewCell *) [self.photoCollectionView cellForItemAtIndexPath:indexPath];
    if(self.photoCollectionView.allowsMultipleSelection == NO){
        if(self.previousIndexPath){
            PhotogridCollectionViewCell *previousCell = (PhotogridCollectionViewCell *) [self.photoCollectionView cellForItemAtIndexPath:self.previousIndexPath];
            previousCell.tickImageView.hidden = YES;
            [self.selectedGalleryphotosArray removeObject:[self.galleryPhotosArray objectAtIndex:self.previousIndexPath.row]];
        }
    }
    self.previousIndexPath = indexPath;
    selectedCell.tickImageView.hidden = NO;
    [self.selectedGalleryphotosArray addObject:[self.galleryPhotosArray objectAtIndex:indexPath.row]];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.photoCollectionView.allowsMultipleSelection == YES){
        PhotogridCollectionViewCell *unSelectedCell = (PhotogridCollectionViewCell *) [self.photoCollectionView cellForItemAtIndexPath:indexPath];
        unSelectedCell.tickImageView.hidden = YES;
        [self.selectedGalleryphotosArray removeObject:[self.galleryPhotosArray objectAtIndex:indexPath.row]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadButtonAction:(UIButton *)sender {
    if(self.selectedGalleryphotosArray.count == 0){
        [self callingAlertViewControllerWithString:@"Please select Photos to upload"];
    }
    else{
        if(self.isFromMedicalRegitrationFromDR){
            NSString *folderPath = [NSString stringWithFormat:FolderPathForDoctorRegistration];
            UIImage *convertedImage = [self convertingMedicalregistrationImageAsset:[self.selectedGalleryphotosArray objectAtIndex:0]];
            NSString *imagePath = [[ImageCache sharedCache] addImage:convertedImage toFolder:folderPath toCacheWithIdentifier:MedicalRegistratioCertificateIdentifier];
            NSLog(@"Image path:%@",imagePath);
        }
        else if(self.isFromMedicalDegreeFromDR){
            NSString *folderPath = [NSString stringWithFormat:FolderPathForDoctorRegistration];
            UIImage *convertedImage = [self convertingMedicalregistrationImageAsset:[self.selectedGalleryphotosArray objectAtIndex:0]];
            [[ImageCache sharedCache] addImage:convertedImage toFolder:folderPath toCacheWithIdentifier:MedicalDegreeCertificateidentifier];
        }
        else if(self.isFromGovernmentIdFromDR){
            NSString *folderPath = [NSString stringWithFormat:FolderPathForDoctorRegistration];
            UIImage *convertedImage = [self convertingMedicalregistrationImageAsset:[self.selectedGalleryphotosArray objectAtIndex:0]];
            [[ImageCache sharedCache] addImage:convertedImage toFolder:folderPath toCacheWithIdentifier:GovernmentIdCertifiateIdentifier];
        }
        else if(self.isFromPrescriptionLetterFromDR){
            NSString *folderPath = [NSString stringWithFormat:FolderPathForDoctorRegistration];
            UIImage *convertedImage = [self convertingMedicalregistrationImageAsset:[self.selectedGalleryphotosArray objectAtIndex:0]];
            [[ImageCache sharedCache] addImage:convertedImage toFolder:folderPath toCacheWithIdentifier:PrescriptionletterCertificateIdentifier];
        }

        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UIImage *)convertingMedicalregistrationImageAsset:(ALAsset *)imageAsset{
    ALAsset * asset = imageAsset;
    return [UIImage imageWithCGImage:[asset thumbnail]];
}

-(void)callingAlertViewControllerWithString:(NSString *)alertMessage{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:alertMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
