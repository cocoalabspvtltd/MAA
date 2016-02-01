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

@end
