//
//  FacebookWrapper.m
//  FacebookSample
//
//  Created by Vaisakh krishnan on 3/11/15.
//  Copyright (c) 2015 CL. All rights reserved.
//

#import "FacebookWrapper.h"

NSString *const FBSessionStateChangedNotification = @"com.CL.FBLogin:FBSessionStateChangedNotification";
NSString *const FBUserCancelledNotification = @"com.CL.FBLogin:FBUserCancelledNotification";
NSString *const FBPublicActionNotification = @"com.CL.FBLogin:FBPublicActionNotification";

@implementation FacebookWrapper

+ (FacebookWrapper *)standardWrapper {
    static FacebookWrapper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Facebook Handles

- (BOOL)handleapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    BOOL facebookOpenURL =  [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                           openURL:url
                                                                 sourceApplication:sourceApplication
                                                                        annotation:annotation];
    
    if (facebookOpenURL) {
        //[self notifySessionChanged];
    } else {
        NSLog(@"FacebookWrapper handleOpenURL : which is not supported by Facebook Skipped...");
    }
    return facebookOpenURL;
}

#pragma mark -Activate App

- (void)activateApp {
    [FBSDKAppEvents activateApp];
}


#pragma -

- (BOOL)handlerApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   return [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark - Open New Session with or without UI

- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"user_birthday",
                            @"user_location",
                            @"user_likes",
                            @"email",
                            @"user_photos",
                            nil];//@"publish_actions",
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:permissions handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {

        if (error) {

        } else if (result.isCancelled) {
            [self notifyUserCancelled];
        } else {
            [self fetchFacebookUserInfo];
        }
    }];
}

#pragma -

- (void)getPublicAction {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithPublishPermissions:@[@"publish_actions"]
                                      handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (result.isCancelled) {
            [self notifyUserCancelled];
         }
         else
         {
             [self notifyPublicActionResult];
         }
     }];
}

#pragma mark - Request User Details

- (void)fetchFacebookUserInfo {
    if ([self isUserLoggedIn]) {        
        NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"picture, email,first_name,gender,last_name,link,locale,location,name,timezone,updated_time,verified,birthday",@"fields", nil];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:dict]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 [self notifySessionChangedFor:result WithAnyError:nil];
             }
             else {
             }
         }];
    }
}

#pragma mark -  Check User is Logged in

- (BOOL)isUserLoggedIn {
    if([FBSDKAccessToken currentAccessToken]) {
        return YES;
    }
    return NO;
}


#pragma mark - Session Change Observers

- (void)addSessionChangedObserver:(id)observer {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(fbSessionChanged:) name:FBSessionStateChangedNotification object:nil];
}

- (void)removeSessionChangedObserver:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:FBSessionStateChangedNotification object:nil];
}

- (void)notifySessionChangedFor:(id)result WithAnyError:(NSString * ) error {
    [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:result];
}

#pragma mark - AddUser Cancell Observer

- (void)addUserCancelledObserver :(id)observer {
     [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(fbUserCancelled:) name:FBUserCancelledNotification object:nil];
}

- (void)removeUserCancelledObserver:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:FBUserCancelledNotification object:nil];
}

- (void)notifyUserCancelled {
    [[NSNotificationCenter defaultCenter] postNotificationName:FBUserCancelledNotification object:nil];
}

#pragma mark - Session Change Observers

- (void)addPublicActionObserver:(id)observer {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(publicActionCompleted:) name:FBPublicActionNotification object:nil];
}

- (void)removePublicActionObserver:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:FBPublicActionNotification object:nil];
}

- (void)notifyPublicActionResult {
    [[NSNotificationCenter defaultCenter] postNotificationName:FBPublicActionNotification object:nil];
}

#pragma mark -

- (void)fbSessionChanged:(NSNotification *)notification {
}

- (void)fbUserCancelled:(NSNotification *)notification {
}

- (void)publicActionCompleted:(NSNotification *)notification {
}

#pragma mark - Publishing a message For this user needs "publish_actions" permision from facebook

- (void)publishStory:(NSString *)shareMessage completionHandler:(void (^) (BOOL result, NSError *error))handler {
    [self checkForPermission:@"publish_actions" completionHandler:^(BOOL result, NSError *error) {
        if (! result) {
            handler(NO,error);
            return;
        }
        
        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
            [[[FBSDKGraphRequest alloc]
              initWithGraphPath:@"me/feed"
              parameters: @{ @"message" : shareMessage}
              HTTPMethod:@"POST"]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSLog(@"Post id:%@", result[@"id"]);
                      handler(YES,nil);
                 }
                 else {
                     handler(NO,error);
                 }
             }];
        }
        else {
            [self getPublicAction];
        }
        
   }];
}

#pragma mark - Check wether user granted a permision if not request it

- (void)checkForPermission:(NSString *)permission completionHandler:(void (^) (BOOL result, NSError *error))handler {
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];

    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me/permissions"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (!error) {
            NSArray *tempSecondArray;
            NSLog(@"result === %@",result);
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.status == %@",@"declined"];
            tempSecondArray = [[result objectForKey:@"data"] filteredArrayUsingPredicate:predicate];
            if(tempSecondArray.count == 0) {
                handler(YES,nil);
            }
            else {
                for (int i=0; i<tempSecondArray.count; i++) {
                    [tempArray addObject:[[tempSecondArray objectAtIndex:i]valueForKey:@"permission"]];
                    
                    if(i == tempSecondArray.count-1) {
                        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
                        [loginManager logInWithPublishPermissions:[NSArray arrayWithArray:tempArray]
                                                          handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
                         {
                             if ([result.declinedPermissions containsObject:permission])
                             {
                                   handler(NO,error);
                             }
                             else
                             {
                                  handler(YES,nil);
                             }
                         }];
                        
                    }
                }
            }
        }
        else {
            handler(NO,nil);
        }
    }];
}



#pragma mark -  Sync With AccountStore

-(void)fbResync {
    ACAccountStore *accountStore;
    ACAccountType *accountTypeFB;
    if ((accountStore = [[ACAccountStore alloc] init]) && (accountTypeFB = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook] ) ){
        NSArray *fbAccounts = [accountStore accountsWithAccountType:accountTypeFB];
        id account;
        if (fbAccounts && [fbAccounts count] > 0 && (account = [fbAccounts objectAtIndex:0])) {
            [accountStore renewCredentialsForAccount:account completion:^(ACAccountCredentialRenewResult renewResult, NSError *error) {
                if (error){
                }
            }];
        }
    }
}


#pragma mark - Checks Permision granted by user

- (void)checkGrantedPermisionWithCompletionBlock:(void(^)(BOOL success, NSArray * dataArray)) responseObject {
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me/permissions"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (!error) {
            NSArray *tempSecondArray;
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.status == %@",@"declined"];
            tempSecondArray = [[result objectForKey:@"data"] filteredArrayUsingPredicate:predicate];
            if(tempSecondArray.count == 0) {
                //[self notifySessionChanged];
                responseObject(YES,nil);
            }
            else {
                for (int i=0; i<tempSecondArray.count; i++) {
                    [tempArray addObject:[[tempSecondArray objectAtIndex:i]valueForKey:@"permission"]];
                    if(i == tempSecondArray.count-1) {
                        responseObject (NO,tempArray);
                    }
                }
                
            }
            
        }
        else {
            //[self notifySessionChanged];
            responseObject(YES,nil);
        }
    }];
    
}

@end
