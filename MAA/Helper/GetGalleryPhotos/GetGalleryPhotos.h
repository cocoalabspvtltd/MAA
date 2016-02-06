//
//  GetGalleryPhotos.h
//  Weekenter
//
//  Created by Bibin Mathew (OLD) on 12/14/15.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface GetGalleryPhotos : NSObject
+ (GetGalleryPhotos *)getGelleryPhotosUtilities;
-(void)gettingPhotosFromGallery:(void(^)(NSMutableArray *photos))picked;
@end
