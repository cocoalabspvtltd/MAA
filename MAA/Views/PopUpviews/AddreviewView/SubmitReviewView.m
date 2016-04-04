//
//  SubmitReviewView.m
//  MAA
//
//  Created by Kiran on 04/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "SubmitReviewView.h"
@interface SubmitReviewView()
@property (nonatomic, assign) int reviewRating;
@end
@implementation SubmitReviewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)submitButtonAction:(UIButton *)sender {
    if(self.submitReviewDelegate && [self.submitReviewDelegate respondsToSelector:@selector(submitButtonActionWithReviewContent:andRating:)]){
        [self.submitReviewDelegate submitButtonActionWithReviewContent:self.contentTextView.text andRating:self.reviewRating];
    }
}

- (IBAction)starButtonAction:(UIButton *)sender {
}

@end
