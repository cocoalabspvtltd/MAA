//
//  ImageFullView.h
//  MAA
//
//  Created by Cocoalabs India on 27/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFullView : UIView
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageFullImageView;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, assign) int selecetdIndex;
@end
