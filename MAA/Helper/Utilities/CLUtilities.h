//
//  CLUtilities.h
//  SixKick
//
//  Created by Aravind on 1/20/14.
//  Copyright (c) 2014 Codelynks. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CLUtilities : NSObject

+ (CLUtilities *)standardUtilities;
+(BOOL)isLoggedIn;
+ (void)showLogWithFormat:(NSString *)Format WithMessage:(NSString *)Message;

- (void)removeUserAnswer;
- (int) checkNumberOfComponentsAtPath;
- (void)removeFolder:(NSString *)folderName;
- (NSArray *) totalNumberOfComponentsAtPath;
- (void)removeSpecificUserAnswer:(NSString *)answer;
- (NSString *)convertDate:(NSDate *)currentDate toFormatedString:(NSString *)formateString;
- (NSData *)requestBodyGeneratorWith:(NSMutableDictionary *)contentDictionary;
- (NSString *)Write:(NSData *)answerdata toCacheWithIdentifier:(NSString *)identifier;
- ( NSData *)dataFromCacheWithIdentifier:(NSString *)identifier;

- (void)Write:(NSData *)data toCacheFolder:(NSString *) folderName WithIdentifier:(NSString *)identifier;
- ( NSData *)dataFromFolder:(NSString *)folderName WithIdentifier:(NSString *)identifier;
- (void)localNotificationWith:(NSDate *)notificationDate withBody:(NSString *)notificationBody withAlertAction:(NSString *)notificationAction;

- (NSDate *)convertToDate:(NSString *)dateString;
+ (NSString *)bindingAccessToken;
//-(void)reloadaccesstoken:(NSString *)refreshToken reloadWithCompleteWithBlock:(void(^) (BOOL isSuccess, id response,id errorRespnse) ) completed;

-(long long)timeInSecondsFromString:(NSString *)dateString;
-(NSString *)dateStringFromDatewithOtherformatInmilliseconds:(long long)dateInmilliseconds;
-(NSString *)dateStringFromDateInmilliseconds:(long long)dateInmilliseconds;
-(NSString *)getTimeFromDateInmilliseconds:(long long)dateInmilliseconds;
//-(CGFloat)calculateDistanceBetweenTwoPointsWithDestinationLatitude:(double)DesLat Longiltude:(double)DestLong;
-(NSDateComponents *)findingDifferenceBetweenEndDate:(NSString *)endDateString;
-(void)reloadaccesstokenWithCompleteWithBlock:(void(^) (BOOL isSuccess, id response,id errorRespnse) ) completed;
-(void)gettingProfileImageOfUserWithUrlString:(NSString *)profileImageUrlString CompletionBlock:(void(^)(BOOL isSuccess,UIImage *profileImage))completed;
- (BOOL)goToCamera;
-(void)goingToSettingsPage;
- (UIImage *)scaleAndRotateImage:(UIImage *) image;
@end
