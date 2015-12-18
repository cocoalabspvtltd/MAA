

#import <UIKit/UIKit.h>

@interface CLCustomTextField : UITextField

@property (nonatomic,assign) BOOL preventEdgeInsetLayouting;

- (void)setPlaceHolderFrame:(CGRect ) placeHolderFrame;

@end
