//
//  TMDCollectionViewCell.h
//  MAA
//
//  Created by Cocoalabs India on 24/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMDCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *medicalDocumentImageView;
@property (nonatomic, strong) NSString *documentUrlString;
@end
