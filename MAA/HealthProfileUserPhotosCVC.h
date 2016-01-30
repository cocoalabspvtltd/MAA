//
//  HealthProfileUserPhotosCVC.h
//  MAA
//
//  Created by Cocoalabs India on 30/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthProfileUserPhotosCVC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotosImageView;
@property (nonatomic, strong) NSString *imageUrlString;
@end
