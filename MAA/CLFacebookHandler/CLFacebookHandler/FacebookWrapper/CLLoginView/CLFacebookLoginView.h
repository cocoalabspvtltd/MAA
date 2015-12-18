//
//  CLFacebookLoginView.h
//  FacebookSample
//
//  Created by Vaisakh krishnan on 3/12/15.
//  Copyright (c) 2015 CL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@protocol CLFacebookViewDelegate ;

@interface CLFacebookLoginView : UIView

@property (strong, nonatomic) FBSDKLoginButton *loginView;
@property (nonatomic,strong)id<CLFacebookViewDelegate>CLDelegate;

@end


@protocol CLFacebookViewDelegate <NSObject>

- (void)CLFacebookLoginViewItem:(CLFacebookLoginView *)facebookView userISLoggedOUT:(id)session;
- (void)CLFacebookLoginViewItem:(CLFacebookLoginView *)facebookView fetchUserDetails:(id)user;
- (void)CLFacebookLoginViewItem:(CLFacebookLoginView *)facebookView handleError:(NSString *)error;


@end