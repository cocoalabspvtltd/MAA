//
//  HospitalAboutTVC.h
//  MAA
//
//  Created by kiran on 16/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalAboutTVC : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *aboutDescriptionLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *hospitalImagesCollectionView;

@end
