//
//  MedicalDocumentsVC.h
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalDocumentsVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgFloat;
- (IBAction)floatButton:(id)sender;

- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *AddPopup;
@property (weak, nonatomic) IBOutlet UICollectionView *medicalDocumentsCollectionView;
@property (nonatomic, assign) BOOL isFromPrescriptions;
@property (nonatomic, assign) BOOL isFromMedicalDocuments;
@property (nonatomic, assign) BOOL isFromImages;
@property (nonatomic, assign) BOOL isFromAllergies;

@end
