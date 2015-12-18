

#import <Foundation/Foundation.h>

@interface CLCacheHandler : NSObject

+ (CLCacheHandler *)standardUtilities;

- (void)removeCacheFolder:(NSString *) folderName;
- (NSString *)setCachePathInFolder:(NSString *)folderName;
- (int) checkNumberOfComponentsAtCacheFolder:(NSString *) folderName;
- (NSArray *) totalNumberOfComponentsAtCacheFolder:(NSString *) folderName;
- ( NSData *)dataFromFolder:(NSString *)folderName WithIdentifier:(NSString *)identifier;
- (NSString *)contentPathInFolder:(NSString *)folderName WithIdentifier:(NSString *)identifier;
- (BOOL)checkComponentAtCacheFolder:(NSString *) folderName WithIdentifier:(NSString *)identifier;
- (void)Write:(NSData *)data toCacheFolder:(NSString *) folderName WithIdentifier:(NSString *)identifier;

@end
