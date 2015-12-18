

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIImage;
@interface ImageCache : NSObject

+ (ImageCache *)sharedCache;
- (void)removeImagesFromLocal;
- (NSMutableArray *) checkimagesAtComponentsPath;
- (void)removeSpecificImagesFromLocal:(NSString *)imageName;
- (BOOL) checkNumberOfComponentsAtPath:(NSString *)identifier;
- (UIImage *)imageFromCacheWithIdentifier:(NSString *)identifier;
- (NSString*)addImage:(UIImage *)image toCacheWithIdentifier:(NSString *)identifier;
- (NSString *)addOrginalImage:(UIImage *)image toCacheWithIdentifier:(NSString *)identifier;


- (NSString *)addImage:(UIImage *)image toFolder:(NSString *)folderName toCacheWithIdentifier:(NSString *)identifier;
- (UIImage *)imageFromFolder:(NSString *)folderName WithIdentifier:(NSString *)identifier;
@end
