
#import <Foundation/Foundation.h>
#import <Social/Social.h>
@interface CLTwitterWrapper : NSObject
+ (SLComposeViewController *)shareToTwitter:(NSString *) shareMessage withShareImage:(UIImage *) shareImage withShareUrl:(NSURL *) shareUrl;
@end
