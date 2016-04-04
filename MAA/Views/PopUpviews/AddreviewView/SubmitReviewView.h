//
//  SubmitReviewView.h
//  MAA
//
//  Created by Kiran on 04/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitReviewView : UIView
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIButton *firstStarButton;
@property (strong, nonatomic) IBOutlet UIButton *seconsStarButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdStarButton;
@property (strong, nonatomic) IBOutlet UIButton *fourthStarButton;
@property (strong, nonatomic) IBOutlet UIButton *fifthStarButton;
@property (strong, nonatomic) IBOutlet UIImageView *firdtStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *thirdStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *fourthStarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *fifthStarImageView;

@end
