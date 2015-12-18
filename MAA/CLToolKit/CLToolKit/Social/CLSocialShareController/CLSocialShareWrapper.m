

#import "CLSocialShareWrapper.h"

@implementation CLSocialShareWrapper

+ (UIActivityViewController *)shareToAll:(NSArray *) array{
     UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
    return activityController;
}
@end
