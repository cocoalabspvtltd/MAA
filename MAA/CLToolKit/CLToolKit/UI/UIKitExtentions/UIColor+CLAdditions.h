

#import <UIKit/UIKit.h>

@interface UIColor (CLAdditions)

+ (UIColor *)colorFromString:(NSString *)value;

+ (UIColor *)colorFromHexValue:(NSInteger)hex;

@end
