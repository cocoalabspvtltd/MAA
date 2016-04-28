//
//  SubmitReviewView.m
//  MAA
//
//  Created by Kiran on 04/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#define StarEmptyImageName @"star_empty_x"
#define HalfStarImageName @"starhalf"
#define FullStarImageName @"star-sel"

#import "SubmitReviewView.h"
@interface SubmitReviewView()
@end
@implementation SubmitReviewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:singleTapGesture];
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tapgesture{
    [self endEditing:NO];
}

- (IBAction)submitButtonAction:(UIButton *)sender {
    if(self.submitReviewDelegate && [self.submitReviewDelegate respondsToSelector:@selector(submitButtonActionWithReviewContent:andRating:)]){
        [self.submitReviewDelegate submitButtonActionWithReviewContent:self.contentTextView.text andRating:[self gettingRating]];
    }
}

-(CGFloat)gettingRating{
    CGFloat rating;
    if(self.fifthStarButton.tag !=0){
        if(self.fifthStarButton.tag == 2){
            rating = 5.0;
        }
        else{
            rating = 4.5;
        }
    }
    else if (self.fourthStarButton.tag != 0){
        if(self.fourthStarButton.tag == 2){
            rating = 4.0;
        }
        else{
            rating = 3.5;
        }
    }
    else if (self.thirdStarButton.tag != 0){
        if(self.thirdStarButton.tag == 2){
            rating = 3.0;
        }
        else{
            rating = 2.5;
        }
    }
    else if (self.seconsStarButton.tag != 0){
        if(self.seconsStarButton.tag == 2){
            rating = 2.0;
        }
        else{
            rating = 1.5;
        }
    }
    else if (self.firstStarButton.tag != 0){
        if(self.firstStarButton.tag == 2){
            rating = 1.0;
        }
        else{
            rating = 0.5;
        }
    }
    return rating;
}

- (IBAction)firstButtonAction:(UIButton *)sender {
    sender.tag++;
    if(sender.tag == 0){
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 1){
        [sender setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 2){
         [sender setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 3){
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        [self.seconsStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.seconsStarButton.tag = 0;
        [self.thirdStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.thirdStarButton.tag = 0;
        [self.fourthStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.fourthStarButton.tag = 0;
        [self.fifthStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.fifthStarButton.tag = 0;
    }
}
- (IBAction)secondButtonAction:(UIButton *)sender {
     sender.tag++;
    self.firstStarButton.tag = 2;
    [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    if(sender.tag == 0){
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 1){
        [sender setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 2){
        [sender setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 3){
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        [self.thirdStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.thirdStarButton.tag = 0;
        [self.fourthStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.fourthStarButton.tag = 0;
        [self.fifthStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.fifthStarButton.tag = 0;
    }
}
- (IBAction)thirdButtonAction:(UIButton *)sender {
     sender.tag++;
    self.firstStarButton.tag = 2;
    [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    self.seconsStarButton.tag = 2;
    [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    if(sender.tag == 0){
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 1){
        [sender setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 2){
        [sender setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 3){
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        [self.fourthStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.fourthStarButton.tag = 0;
        [self.fifthStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.fifthStarButton.tag = 0;
    }
}
- (IBAction)fourthButtonAction:(UIButton *)sender {
     sender.tag++;
    self.firstStarButton.tag = 2;
    [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    self.seconsStarButton.tag = 2;
     [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    [self.thirdStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    self.thirdStarButton.tag = 2;
    if(sender.tag == 0){
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 1){
        [sender setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 2){
        [sender setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 3){
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        [self.fifthStarButton setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
        self.fifthStarButton.tag = 0;
    }
}
- (IBAction)fifthButtonAction:(UIButton *)sender {
     sender.tag++;
    self.firstStarButton.tag = 2;
    [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    self.seconsStarButton.tag = 2;
    [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    [self.thirdStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    self.thirdStarButton.tag = 2;
    [self.fourthStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    self.fourthStarButton.tag = 2;
    if(sender.tag == 0){
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 1){
        [sender setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 2){
        [sender setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
    }
    else if (sender.tag == 3){
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed:StarEmptyImageName] forState:UIControlStateNormal];
    }
}

-(void)setIsFromReviewEdit:(BOOL)isFromReviewEdit{
    self.contentTextView.text = self.reviewContent;
    if(isFromReviewEdit){
        if([self.ratingString isEqualToString:@"0.5"]){
            self.firstStarButton.tag = 1;
            [self.firstStarButton setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
        }
        if([self.ratingString isEqualToString:@"1"]){
            self.firstStarButton.tag = 2;
             [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"1.5"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 1;
             [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"2"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 2;
            [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"2.5"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 2;
            self.thirdStarButton.tag = 1;
            [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.thirdStarButton setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"3"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 2;
            self.thirdStarButton.tag = 2;
            [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.thirdStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"3.5"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 2;
            self.thirdStarButton.tag = 2;
            self.fourthStarButton.tag = 1;
            [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.thirdStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
             [self.fourthStarButton setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"4"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 2;
            self.thirdStarButton.tag = 2;
            self.fourthStarButton.tag = 2;
            [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.thirdStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.fourthStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"4.5"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 2;
            self.thirdStarButton.tag = 2;
            self.fourthStarButton.tag = 2;
            self.fifthStarButton.tag = 1;
            [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.thirdStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.fourthStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.fifthStarButton setImage:[UIImage imageNamed:HalfStarImageName] forState:UIControlStateNormal];
        }
        else if ([self.ratingString isEqualToString:@"5"]){
            self.firstStarButton.tag = 2;
            self.seconsStarButton.tag = 2;
            self.thirdStarButton.tag = 2;
            self.fourthStarButton.tag = 2;
            self.fifthStarButton.tag = 2;
            [self.firstStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.seconsStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.thirdStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.fourthStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
            [self.fifthStarButton setImage:[UIImage imageNamed:FullStarImageName] forState:UIControlStateNormal];
        }
    }
}


@end
