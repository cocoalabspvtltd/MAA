//
//  MedicalDocumentsDetailVC.h
//  MAA
//
//  Created by Cocoalabs India on 24/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MedicalDocumentsDetailDelegate;
@interface MedicalDocumentsDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *medicalDocumentImageView;
@property (nonatomic, strong) UIImage *medicalDocumentImage;
@property (nonatomic, assign) id<MedicalDocumentsDetailDelegate>medicalDetailDelegate;
@end
@protocol MedicalDocumentsDetailDelegate <NSObject>

-(void)imageUploadedActionDelegateWithData:(id)uploadedImageDetails;

@end