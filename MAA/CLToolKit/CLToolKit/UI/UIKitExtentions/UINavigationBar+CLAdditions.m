

#import "UINavigationBar+CLAdditions.h"

@implementation UINavigationBar (CLAdditions)

-(void) navigationApperance {
    self.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:22.0],UITextAttributeFont,[UIColor redColor],UITextAttributeTextColor, nil];

}
@end
