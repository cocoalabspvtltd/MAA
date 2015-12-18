

#import <Foundation/Foundation.h>

#import <MessageUI/MFMailComposeViewController.h>

@interface CLEmailShare : NSObject<MFMailComposeViewControllerDelegate>

- (BOOL)canSendMail;
-(void) shareToEmail:(UIViewController *) viewController withImage:(UIImage *) image
          imageNamed:(NSString *)name  imageUrl:(NSString *) url;


@end
