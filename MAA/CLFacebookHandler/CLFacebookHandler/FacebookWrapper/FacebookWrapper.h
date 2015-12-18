//
//  FacebookWrapper.h
//  FacebookSample
//
//  Created by Vaisakh krishnan on 3/11/15.
//  Copyright (c) 2015 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FacebookWrapper : NSObject

+ (FacebookWrapper *)standardWrapper;

- (void)activateApp;
- (BOOL)isUserLoggedIn;
- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

- (void)addSessionChangedObserver:(id)observer;
- (void)removeSessionChangedObserver:(id)observer;
- (void)addUserCancelledObserver :(id)observer;
- (void)removeUserCancelledObserver:(id)observer;
- (void)addPublicActionObserver:(id)observer;
- (void)removePublicActionObserver:(id)observer;

- (void)publishStory:(NSString *)shareMessage completionHandler:(void (^) (BOOL result, NSError *error))handler;
- (BOOL)handleapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation ;
- (BOOL)handlerApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
