//
//  HealthProfileUserPhotosCVC.m
//  MAA
//
//  Created by Cocoalabs India on 30/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "HealthProfileUserPhotosCVC.h"

@implementation HealthProfileUserPhotosCVC
-(void)setImageUrlString:(NSString *)imageUrlString{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]];
        UIImage *tempImage = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profilePhotosImageView.image = tempImage;
        }
                       );
    });
}

- (IBAction)plusButtonActions:(UIButton *)sender {
}
@end
