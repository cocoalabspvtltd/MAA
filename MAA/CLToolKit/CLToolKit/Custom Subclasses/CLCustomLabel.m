

#import "CLCustomLabel.h"

@implementation CLCustomLabel

@synthesize textEdgeInset = _textEdgeInset;

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textEdgeInset)];
}



@end
