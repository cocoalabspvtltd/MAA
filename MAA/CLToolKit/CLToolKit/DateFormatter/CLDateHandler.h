

#import <Foundation/Foundation.h>

@interface CLDateHandler : NSObject

+ (CLDateHandler *)standardUtilities;
- (NSString *)createTimeStampFor:(NSDate *)date;
- (NSString *)convertDate:(NSDate *)currentDate toFormatedString:(NSString *)formateString withTimeZone:(NSTimeZone *)timezone;
- (NSDate *)convertToDate:(NSString *)dateString corespondingTo:(NSString *)formatedDateString withTimeZone:(NSTimeZone *)timezone;


@end
