//
//  AppDelegate.m
//  MAA
//
//  Created by Roshith Balendran on 27/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginPageVC.h"
#import "CLFacebookHandler/FacebookWrapper.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self addObserver];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        // iOS 8
        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [self initWindow];
    return [[FacebookWrapper standardWrapper] handlerApplication:application didFinishLaunchingWithOptions:launchOptions ];
    return YES;
}

#pragma mark - Remote Notification Delegates

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *newDeviceToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newDeviceToken = [newDeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"###### DEVICE TOKEN = %@ #########",newDeviceToken);
    [[NSUserDefaults standardUserDefaults ] setValue:newDeviceToken forKey:DeviceTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:AppName message:@"Registration Failure" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [errorAlert show];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
     NSLog(@"User Info:%@",[userInfo valueForKey:@"aps"]);
}

-(void)initWindow{
   UIStoryboard *sb = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    if(![self isLoggedIn]){
        UINavigationController *navigationController = [sb instantiateViewControllerWithIdentifier:@"LogInNavigationController"];
        self.window.rootViewController = navigationController;
    }
    else
    {
        UITabBarController *tabbarController = [sb instantiateViewControllerWithIdentifier:@"TabBarController"];
    self.window.rootViewController = tabbarController;
         [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"bar_b"]];
    }
    
}

-(BOOL)isLoggedIn{
    BOOL isLoggedIn = YES;
    if(![[[NSUserDefaults standardUserDefaults] valueForKey:kUserName] length]>0){
        isLoggedIn = NO;
    }
    return isLoggedIn;
}

#pragma mark - NSNotification Observer

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHomeView:) name:ShowLogInScreenObserver object:nil];
}

-(void)showHomeView:(id)sender{
    [self initWindow];
}


- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // iPad
        return UIInterfaceOrientationMaskAll;
    }
    else
    {
        // iPhone / iPod Touch
        return UIInterfaceOrientationMaskPortrait;
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FacebookWrapper standardWrapper]handleapplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[FacebookWrapper standardWrapper] activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
