

#import <Foundation/Foundation.h>
#import <Social/Social.h>

@interface CLFacebookWrapper : NSObject

+ (SLComposeViewController *)shareToFacebook:(NSString *) shareMessage withShareImage:(UIImage *) shareImage withShareUrl:(NSURL *) shareUrl;

@end
