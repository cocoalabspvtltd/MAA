

#import <UIKit/UIKit.h>

@interface UITableView (CLAdditions)

- (void)setEmptyHeaderView;
- (void)setEmptyFooterView;
- (void)setFooterViewWithHeight:(CGFloat)height;
- (void)setHeaderViewWithHeight:(CGFloat)height;

@end
