//
//  SubmitReviewView.h
//  MAA
//
//  Created by Kiran on 04/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SubmitReviewDelegate;
@interface SubmitReviewView : UIView
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIButton *firstStarButton;
@property (strong, nonatomic) IBOutlet UIButton *seconsStarButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdStarButton;
@property (strong, nonatomic) IBOutlet UIButton *fourthStarButton;
@property (strong, nonatomic) IBOutlet UIButton *fifthStarButton;
@property (nonatomic, assign) BOOL isFromReviewEdit;
@property (nonatomic, strong) NSString *reviewContent;
@property (nonatomic, strong) NSString *ratingString;
@property (nonatomic, assign) id<SubmitReviewDelegate>submitReviewDelegate;
@end

@protocol SubmitReviewDelegate <NSObject>

-(void)submitButtonActionWithReviewContent:(NSString *)reviewContent andRating:(float)reting;

@end
