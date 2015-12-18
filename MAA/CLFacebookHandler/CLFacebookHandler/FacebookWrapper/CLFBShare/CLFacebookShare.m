//
//  CLFacebookShare.m
//  FacebookSample
//
//  Created by Vaisakh krishnan on 3/12/15.
//  Copyright (c) 2015 CL. All rights reserved.
//

#import "CLFacebookShare.h"

@implementation CLFacebookShare

+ (CLFacebookShare *)shareHandler {
    static CLFacebookShare *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (id)shareToFacebook:(NSDictionary *)dataDictionary withComposerUI:(BOOL)isNeeded {
    if(isNeeded)
        return [self shareToFacebook:dataDictionary];
    else
        [self shareToFaceBookWithoutComposer:dataDictionary];
    return nil;
}

- (void)shareToFaceBookWithoutComposer:(NSDictionary *)dataDictionary {
    [[FacebookWrapper standardWrapper] publishStory:[dataDictionary valueForKey:@"Message"] completionHandler:^(BOOL result, NSError *error) {
        if(result) {
            if(self.CLShareDelegate && [self.CLShareDelegate respondsToSelector:@selector(CLFacebookShareViewItem:isSucces:withError:)]) {
                [self.CLShareDelegate CLFacebookShareViewItem:self isSucces:YES withError:nil];
            }
        }
        else {
            if(self.CLShareDelegate && [self.CLShareDelegate respondsToSelector:@selector(CLFacebookShareViewItem:isSucces:withError:)]) {
                [self.CLShareDelegate CLFacebookShareViewItem:self isSucces:NO withError:error.localizedDescription];
            }
        }
    }];
}


- (SLComposeViewController *)shareToFacebook:(NSDictionary *) dataDictionary {
    NSString * shareMessage = [dataDictionary valueForKey:@"Message"];
    UIImage * shareImage = [dataDictionary valueForKey:@"ShareImage"];
    NSURL * shareUrl = [dataDictionary valueForKey:@"ShareUrl"];
    
   // if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
     if(shareMessage)
        [facebookPost setInitialText:shareMessage];
    if(shareImage)
        [facebookPost addImage:shareImage];
    if(shareUrl)
        [facebookPost addURL:shareUrl];
        return facebookPost;
//    }
//    else
//        return nil;
}

@end
