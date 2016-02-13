//
//  CLUtilities.m
//  SixKick
//
//  Created by Aravind on 1/20/14.
//  Copyright (c) 2014 Codelynks. All rights reserved.
//

#import "CLUtilities.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "CLConstant.h"
//#import "ServiceHandler.h"


@implementation CLUtilities

+ (CLUtilities *)standardUtilities {
    static CLUtilities *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+(BOOL)isLoggedIn{
    BOOL loggedIn = YES;
    NSUserDefaults *localUsreDefaults = [NSUserDefaults standardUserDefaults];
    if (![[localUsreDefaults valueForKey:kUserName] length] > 0) {
        loggedIn = NO;
    }
//    else if (![[localUsreDefaults valueForKey:kPassword] length] > 0){
//        loggedIn = NO;
//    }
    return loggedIn;
}

#pragma mark - NSLog Message

+ (void)showLogWithFormat:(NSString *)Format WithMessage:(NSString *)Message {
    NSLog(Format,Message);
}



#pragma mark - Answer

- (NSString *)setCachePath {
    NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
    NSString *cachePath = [NSString stringWithFormat:@"Library/Caches/%@/UserAnser",applicationName];
    return [NSHomeDirectory() stringByAppendingPathComponent:cachePath];
}

- ( NSData *)dataFromCacheWithIdentifier:(NSString *)identifier {
    NSString *folderPath = [self setCachePath];
    NSString *fileName = [NSString stringWithFormat:@"%@.txt",identifier];
    fileName = [folderPath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    if(data) {
        return data;
    }
    return nil;
}

- (NSString *)Write:(NSData *)answerdata toCacheWithIdentifier:(NSString *)identifier {
    NSString *folderPath = [self setCachePath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@.txt",identifier];
    fileName = [folderPath stringByAppendingPathComponent:fileName];
    [answerdata writeToFile:fileName atomically:NO];
    return fileName;
}

- (void)removeUserAnswer {
    NSString *folderPath = [self setCachePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:folderPath error:&error];
//        //if(error)
//            //NSLog(@"error %@",[error localizedDescription]);
    }
}

- (void)removeSpecificUserAnswer:(NSString *)answer {
    NSString *fileName = [NSString stringWithFormat:@"%@.txt",answer];
    NSString *folderPath = [[self setCachePath] stringByAppendingPathComponent:fileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:folderPath error:&error];
//        if(error)
//            NSLog(@"error %@",[error localizedDescription]);
    }
}

- (int) checkNumberOfComponentsAtPath {
    int count = 0;
     NSString *folderPath = [self setCachePath];
         if([[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]) {
        count = (int)[[NSFileManager defaultManager] subpathsAtPath:folderPath].count;
     }
    //if([[NSFileManager defaultManager] fileExistsAtPath:[folderPath stringByAppendingPathComponent:@"6.txt"] isDirectory:nil]) {
       // count = count-1;
    //}
   // if([[NSFileManager defaultManager] fileExistsAtPath:[folderPath stringByAppendingPathComponent:@"7.txt"] isDirectory:nil]) {
   //     count = count-1;
   // }
    return count;
}


- (NSArray *) totalNumberOfComponentsAtPath {
    NSArray * count ;
    NSString *folderPath = [self setCachePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]) {
        count = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
    }
    return count;
}

#pragma mark - User Profile

- (void)Write:(NSData *)data toCacheFolder:(NSString *) folderName WithIdentifier:(NSString *)identifier {
    NSString *folderPath = [self setCachePathInFolder:folderName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@.txt",identifier];
    fileName = [folderPath stringByAppendingPathComponent:fileName];
    [data writeToFile:fileName atomically:NO];
   
}

- (NSString *)setCachePathInFolder:(NSString *)folderName {
    NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
    NSString *cachePath = [NSString stringWithFormat:@"Library/Caches/%@/%@",applicationName,folderName];
    return [NSHomeDirectory() stringByAppendingPathComponent:cachePath];
}

- ( NSData *)dataFromFolder:(NSString *)folderName WithIdentifier:(NSString *)identifier {
    NSString *folderPath = [self setCachePathInFolder:folderName];
    NSString *fileName = [NSString stringWithFormat:@"%@.txt",identifier];
    fileName = [folderPath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    if(data) {
        return data;
    }
    return nil;
}

- (void)removeFolder:(NSString *)folderName {
    NSString *folderPath = [self setCachePathInFolder:folderName];
    if([[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:nil]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:folderPath error:&error];
//        if(error)
//            NSLog(@"error %@",[error localizedDescription]);
    }
}

#pragma mark - Request body Generator

- (NSData *)requestBodyGeneratorWith:(NSMutableDictionary *)contentDictionary {
    NSString * string = nil;
    if ([NSJSONSerialization isValidJSONObject:contentDictionary]) {
        string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:contentDictionary
                                                                                options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    NSLog(@"%@",string);
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - UILocal Notification

- (void)localNotificationWith:(NSDate *)notificationDate withBody:(NSString *)notificationBody withAlertAction:(NSString *)notificationAction {
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
//    NSDate *currentDate = [NSDate date];
//    NSLog(@"currentDate %@",currentDate);
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    [dateComponents setMinute:+1];
//    NSDate *sevenDaysAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
//    NSLog(@"\ncurrentDate: %@\nseven days ago: %@", currentDate, sevenDaysAgo);
    localNotification.fireDate = notificationDate;
    localNotification.alertBody = notificationBody;
    localNotification.alertAction = notificationAction;
    localNotification.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    //localNotification.timeZone = [NSTimeZone systemTimeZone];
    //localNotification.repeatInterval = NSCalendarUnitMinute;
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (NSDate *)convertToDate:(NSString *)dateString {
    NSDateFormatter* dayFormatterTemp = [[NSDateFormatter alloc] init] ;
    [dayFormatterTemp setDateFormat:@"MMM dd yyyy"];
    [dayFormatterTemp setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *dateTemp =[[NSDate alloc]init];
    dateTemp =[dayFormatterTemp dateFromString:dateString];
    return dateTemp;
}

- (NSString *)convertDate:(NSDate *)currentDate toFormatedString:(NSString *)formateString {
    //NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init] ;
    NSDateFormatter* dayFormatterTemp = [[NSDateFormatter alloc] init] ;
    [dayFormatterTemp setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dayFormatterTemp setDateFormat:formateString];
    return [dayFormatterTemp stringFromDate:currentDate];
}

+(NSString*)bindingAccessToken
{
    NSString *binderString = [NSString stringWithFormat:@"Beare  %@",@"12345678"];
    return binderString;
}

//-(void)reloadaccesstoken:(NSString *)refreshToken reloadWithCompleteWithBlock:(void(^) (BOOL isSuccess, id response,id errorRespnse) ) completed{
//    
//    //error Request failed: unauthorized (401)
//    
//    NSString *refreshTokenString =[NSString stringWithFormat:@"%@%@%@",BaseUrlProd,refreshTokenUrl,refreshToken];
//    NSLog(@"Refresh Token Url:%@",refreshTokenString);
//    [[NetworkHandler sharedHandler]requestWithRequestUrl:[NSURL URLWithString:refreshTokenString] withBody:nil withMethodType:HTTPMethodGET  withAccessToken:nil];
//    [[NetworkHandler sharedHandler]startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
//        [[NSUserDefaults standardUserDefaults]setValue:[[responseObject valueForKey:PayLoadKey] valueForKey:AccessTokenKey]  forKey:ACCESS_TOKEN];
//        [[NSUserDefaults standardUserDefaults]setValue:[[responseObject valueForKey:PayLoadKey] valueForKey:RefreshTokenKey]  forKey:REFRESH_TOKEN];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        completed(YES,responseObject,nil);
//        
//    } FailureBlock:^(NSString *errorDescription,id errorResponse) {
//        completed(NO,errorDescription,errorResponse);
//    }];
//
//}

-(long long)timeInSecondsFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    long long int dateInSeconds = (long long)([dateFromString timeIntervalSince1970] * 1000.0);
    return dateInSeconds;
}

-(NSString *)dateStringFromDatewithOtherformatInmilliseconds:(long long)dateInmilliseconds{
    NSDate *dobdate = [NSDate dateWithTimeIntervalSince1970:dateInmilliseconds/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //[dateFormatter setDateFormat:@"dd/MM/yyyy 'T' HH:mm:ssZZZ a"];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    return [dateFormatter stringFromDate:dobdate];
}

-(NSString *)dateStringFromDateInmilliseconds:(long long)dateInmilliseconds{
    NSDate *dobdate = [NSDate dateWithTimeIntervalSince1970:dateInmilliseconds/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //[dateFormatter setDateFormat:@"dd/MM/yyyy 'T' HH:mm:ssZZZ a"];
    [dateFormatter setDateFormat:@"EE, d, LLLL yyyy"];
    //[dateFormatter setDateFormat:@"d, EE, LLLL yyyy"];
    return [dateFormatter stringFromDate:dobdate];
}

-(NSString *)getTimeFromDateInmilliseconds:(long long)dateInmilliseconds{
    NSDate *dobdate = [NSDate dateWithTimeIntervalSince1970:dateInmilliseconds/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
    return [dateFormatter stringFromDate:dobdate];
}

//-(CGFloat)calculateDistanceBetweenTwoPointsWithDestinationLatitude:(double)DesLat Longiltude:(double)DestLong{
//    CLLocationDegrees currentLatitude = [[[NSUserDefaults standardUserDefaults] valueForKey:LATITUDE] doubleValue];
//    CLLocationDegrees currentLongitude = [[[NSUserDefaults standardUserDefaults] valueForKey:LONGITUDE] doubleValue];
//    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:currentLatitude longitude:currentLongitude];
//    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:DesLat longitude:DestLong];
//    double distnceInKilometer = [location1 distanceFromLocation:location2]/1000;
//    return distnceInKilometer;
//}

-(NSDateComponents *)findingDifferenceBetweenEndDate:(NSString *)endDateString{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [f dateFromString:endDateString];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitMonth|NSCalendarUnitSecond|NSCalendarUnitYear|NSCalendarWrapComponents
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    return components;
}

#pragma mark - Reload Access Token Api

//-(void)reloadaccesstokenWithCompleteWithBlock:(void(^) (BOOL isSuccess, id response,id errorRespnse) ) completed{
//    NSString *refreshTokenString = [[NSUserDefaults standardUserDefaults] valueForKey:REFRESH_TOKEN];
//    NSString *refreshTokenUrlString =[NSString stringWithFormat:@"%@%@%@",BaseUrl,refreshTokenUrl,refreshTokenString];
//    [[NetworkHandler sharedHandler]requestWithRequestUrl:[NSURL URLWithString:refreshTokenUrlString] withBody:nil withMethodType:HTTPMethodGET  withAccessToken:nil];
//    [[NetworkHandler sharedHandler]startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
//        [[NSUserDefaults standardUserDefaults]setValue:[responseObject valueForKey:AccessTokenKey] forKey:ACCESS_TOKEN];
//        [[NSUserDefaults standardUserDefaults]setValue:[responseObject valueForKey:RefreshTokenKey] forKey:REFRESH_TOKEN];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        completed(YES,responseObject,nil);
//        
//    } FailureBlock:^(NSString *errorDescription,id errorResponse) {
//        NSLog(@"Error Response:%@",errorResponse);
//        completed(NO,errorDescription,errorResponse);
//    }];
//}
//
//#pragma mark - Getting Profile Image
//
//-(void)gettingProfileImageOfUserWithUrlString:(NSString *)profileImageUrlString CompletionBlock:(void(^)(BOOL isSuccess,UIImage *profileImage))completed{
//    NSString *profileIdString = [[NSUserDefaults standardUserDefaults] valueForKey:PROFILE_ID];
//    NSString *folderPath = [NSString stringWithFormat:@"Ribbn/Photos/profileImages"];
//    NSString *profileImageIdentifier = [NSString stringWithFormat:@"%@_%@",profileIdString,[NSNumber numberWithInt:1]];
//    NSURL *profileImageUrl = [NSURL URLWithString:profileImageUrlString];
//    UIImage *localImage;
//    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:profileImageIdentifier];
//    if(localImage){
//        completed(YES,localImage);
//    }
//    else{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSData *imageData = [NSData dataWithContentsOfURL:profileImageUrl];
//            UIImage *tempImage = [UIImage imageWithData:imageData];
//            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:profileImageIdentifier];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completed(YES,tempImage);
//            }
//                           );
//        });
//    }
//}

- (BOOL)goToCamera {
    __block BOOL isSuccess = false;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        isSuccess = true;
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined)  {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted) {
                isSuccess = true;
            }
            else {
                [self camDenied];
            }
        }];
    }
    else if (authStatus == AVAuthorizationStatusRestricted) {
        UIAlertView *cameraAlertView = [[UIAlertView alloc] initWithTitle:AppName message:@"You've been restricted from using the camera on this device. Without camera access this feature won't work. Please contact the device owner so they can give you access." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [cameraAlertView show];
    }
    else {
        [self camDenied];
    }
    return isSuccess;
}

- (void)camDenied {
//    NSString *alertText;
//    BOOL canOpenSettings = (UIApplicationOpenSettingsURLString != NULL);
//    
//    int count = [[NSUserDefaults standardUserDefaults] valueForKey:ribbnCameraAccessCount] == NULL? 0:[[[NSUserDefaults standardUserDefaults] valueForKey:ribbnCameraAccessCount] intValue];
//    
//    if (canOpenSettings) {
//        alertText = ribbnCameraDisabledMessage;
//    }
//    else {
//        alertText = ribbnCameraDisabledMessage;
//    }
//    if(count == 3) {
//        UIAlertView *cameraAlert = [[UIAlertView alloc] initWithTitle:AppName message:alertText delegate:self cancelButtonTitle:@"Don't Allow" otherButtonTitles:@"OK", nil];
//        cameraAlert.tag = 3001;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [cameraAlert show];
//        });
//    } else {
//        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:count+1] forKey:ribbnCameraAccessCount];
//        UIAlertView *cameraAlert = [[UIAlertView alloc] initWithTitle:AppName message:ribbnCameraEnabledMessage delegate:self cancelButtonTitle:@"Don't Allow" otherButtonTitles:@"OK", nil];
//        cameraAlert.tag = 3001;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [cameraAlert show];
//        });
//    }
    
}

#pragma mark -UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 3001 && buttonIndex == 1) {
        BOOL canOpenSettings = (UIApplicationOpenSettingsURLString != NULL);
        if (canOpenSettings)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

-(void)goingToSettingsPage{
    BOOL canOpenSettings = (UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (UIImage *)scaleAndRotateImage:(UIImage *) image {
    int kMaxResolution = 320;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

@end
