//
//  ImageFullView.m
//  MAA
//
//  Created by Cocoalabs India on 27/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "ImageFullView.h"
@interface ImageFullView()<UIScrollViewDelegate>
@property (nonatomic, assign) int currentSelectedIndex;
@property (nonatomic, strong) NSArray *currentImagesArray;

@end
@implementation ImageFullView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    self.scroller.minimumZoomScale = 1.0;
    self.scroller.maximumZoomScale = 2.0;
    self.scroller.contentSize = self.imageFullImageView.frame.size;
    self.scroller.delegate = self;
    
    
    //    _scroller.delegate=self;
    
}
- (IBAction)leftSwipeGestureActions:(UISwipeGestureRecognizer *)sender {
    CATransition *transition = nil;
    if(self.currentSelectedIndex+1<self.currentImagesArray.count){
        self.currentSelectedIndex++;
        transition = [CATransition animation];
        transition.duration = .3;//kAnimationDuration
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        NSString *imageUrlString = [[self.currentImagesArray objectAtIndex:self.currentSelectedIndex] valueForKey:@"url"];
        self.headingLabel.text = [[self.currentImagesArray objectAtIndex:self.currentSelectedIndex] valueForKey:@"title"];
        [self.imageFullImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
        [self.imageFullImageView.layer addAnimation:transition forKey:nil];
    }
}
- (IBAction)rightSwipegestureActions:(UISwipeGestureRecognizer *)sender {
    if(self.currentSelectedIndex>0){
        self.currentSelectedIndex --;
        CATransition *transition = nil;
        transition = [CATransition animation];
        transition.duration = .3;//kAnimationDuration
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        NSString *imageUrlString = [[self.currentImagesArray objectAtIndex:self.currentSelectedIndex] valueForKey:@"url"];
        self.headingLabel.text = [[self.currentImagesArray objectAtIndex:self.currentSelectedIndex] valueForKey:@"title"];
        [self.imageFullImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
        [self.imageFullImageView.layer addAnimation:transition forKey:nil];
    }
}

-(void)setSelecetdIndex:(int)selecetdIndex{
    self.currentSelectedIndex = selecetdIndex;
}

- (IBAction)closeButtonAction:(UIButton *)sender {
    [self removeFromSuperview];
}

-(void)setImagesArray:(NSArray *)imagesArray{
    NSLog(@"Images Array:%@",imagesArray);
    self.headingLabel.text = [[imagesArray objectAtIndex:self.currentSelectedIndex] valueForKey:@"title"];
    NSString *imageUrlString = [[imagesArray objectAtIndex:self.currentSelectedIndex] valueForKey:@"url"];
    [self.imageFullImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    self.currentImagesArray = imagesArray;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageFullImageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.imageFullImageView.center=CGPointMake(CGRectGetMidX(self.scroller.bounds), CGRectGetMidY(self.scroller.bounds));
}
@end
