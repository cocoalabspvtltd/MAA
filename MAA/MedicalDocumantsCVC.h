//
//  MedicalDocumantsCVC.h
//  MAA
//
//  Created by Cocoalabs India on 30/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalDocumantsCVC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *medicalDocumentsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *medicalDocumantsCoverImageview;
@property (weak, nonatomic) IBOutlet UILabel *documantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *documantDatLabel;
@property (nonatomic, strong) NSString *medicalDocumantImageUrlString;
@end
