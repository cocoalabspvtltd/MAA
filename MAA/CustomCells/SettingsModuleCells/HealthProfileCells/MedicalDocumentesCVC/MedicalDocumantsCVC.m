//
//  MedicalDocumantsCVC.m
//  MAA
//
//  Created by Cocoalabs India on 30/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MedicalDocumantsCVC.h"

@implementation MedicalDocumantsCVC

-(void)setMedicalDocumantImageUrlString:(NSString *)medicalDocumantImageUrlString{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:medicalDocumantImageUrlString]];
        UIImage *tempImage = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.medicalDocumentsImageView.image = tempImage;
        }
                       );
    });
 
}
@end
