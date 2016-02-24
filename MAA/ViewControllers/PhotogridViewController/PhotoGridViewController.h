//
//  PhotoGridViewController.h
//  MAA
//
//  Created by Cocoalabs India on 01/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoGridViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic, assign) BOOL isFromMedicalRegitrationFromDR;
@property (nonatomic, assign) BOOL isFromMedicalDegreeFromDR;
@property (nonatomic, assign) BOOL isFromGovernmentIdFromDR;
@property (weak, nonatomic) IBOutlet UIButton *uploadPhotosButton;
@property (nonatomic, assign) BOOL isFromPrescriptionLetterFromDR;

#pragma mark - HealthProfile

@property (nonatomic, assign) BOOL isFromePrescriptions;
@property (nonatomic, assign) BOOL isFromMedicalDocuments;
@property (nonatomic, assign) BOOL isFromImages;

@end
