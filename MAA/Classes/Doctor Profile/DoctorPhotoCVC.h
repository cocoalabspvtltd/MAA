//
//  DoctorPhotoCVC.h
//  MAA
//
//  Created by Cocoalabs India on 08/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorPhotoCVC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) NSString *profileImageUrl;
@end
