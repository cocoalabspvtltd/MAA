

#import <Foundation/Foundation.h>

#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface CLSocialShareHandler : NSObject

+ (NSString *)customizeLikeButton;
+ (SLComposeViewController *)shareToFacebook:(NSString *) shareMessage withShareImage:(UIImage *) shareImage withShareUrl:(NSURL *) shareUrl;
+ (SLComposeViewController *)shareToTwitter:(NSString *) shareMessage withShareImage:(UIImage *) shareImage withShareUrl:(NSURL *) shareUrl;
+ (MFMailComposeViewController *)sendEmailWithImage:(UIImage *)image imageName:(NSString *)filename imageUrl:(NSString *)url subject:(NSString *)subject message:(NSString *)message ToRecipients:(NSArray *)recipients;

@end
