//
//  CLFacebookShare.h
//  FacebookSample
//
//  Created by Vaisakh krishnan on 3/12/15.
//  Copyright (c) 2015 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FacebookWrapper.h"

#import <Social/Social.h>

@protocol CLFacebookShareDelegate ;

@interface CLFacebookShare : NSObject

@property (nonatomic,strong)id<CLFacebookShareDelegate>CLShareDelegate;

+ (CLFacebookShare *)shareHandler;
- (id)shareToFacebook:(NSDictionary *)dataDictionary withComposerUI:(BOOL)isNeeded;

@end


@protocol CLFacebookShareDelegate <NSObject>

- (void)CLFacebookShareViewItem:(CLFacebookShare *)facebookShareView isSucces:(BOOL)isSuccess withError:(NSString *)error;

@end