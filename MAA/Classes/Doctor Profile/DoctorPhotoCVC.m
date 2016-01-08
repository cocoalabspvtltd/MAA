//
//  DoctorPhotoCVC.m
//  MAA
//
//  Created by Cocoalabs India on 08/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorPhotoCVC.h"
#import "CLToolKit/ImageCache.h"

@implementation DoctorPhotoCVC

-(void)setProfileImageUrl:(NSString *)profileImageUrl{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrl]];
        UIImage *tempImage = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoImageView.image = tempImage;
            [MBProgressHUD hideAllHUDsForView:self.photoImageView animated:YES];
        }
                       );
    });

}
@end