//
//  GetGalleryPhotos.m
//  Weekenter
//
//  Created by Bibin Mathew (OLD) on 12/14/15.
//
//

#import "GetGalleryPhotos.h"
@interface GetGalleryPhotos()
@property (nonatomic,strong) ALAssetsLibrary *library;
@property (nonatomic, strong) NSMutableArray *assetArray;
@end
@implementation GetGalleryPhotos
+ (GetGalleryPhotos *)getGelleryPhotosUtilities {
    static GetGalleryPhotos *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)gettingPhotosFromGallery:(void(^)(NSMutableArray *photos))picked{
    self.assetArray = [[NSMutableArray alloc] init];
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    self.library = assetLibrary;
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       @autoreleasepool {
                           // Group enumerator Block
                           void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                           {
                               if (group == nil) {
                                   picked(self.assetArray);
                                   //[self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
                                   return;
                               }
                               // added fix for camera albums order
                               NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                               NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                               
                               if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                                   [self getAsset:group];
                                   //[self.assetGroups insertObject:group atIndex:0];
                               }
                               else {
                                   [self getAsset:group];
                                   //[self.assetGroups addObject:group];
                               }
                               // Reload albums
                               picked(self.assetArray);
                               //[self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
                           };
                           
                           // Group Enumerator Failure Block
                           void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                               
                               UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                               [alert show];
                               
                               NSLog(@"A problem occured %@", [error description]);
                           };
                           
                           // Enumerate Albums
                           [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                                       usingBlock:assetGroupEnumerator
                                                     failureBlock:assetGroupEnumberatorFailure];
                           
                       }
                   });
    
}

- (void)getAsset:(ALAssetsGroup *)group {
    [group enumerateAssetsUsingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
        // The end of the enumeration is signaled by asset == nil.
        if (alAsset) {
            @autoreleasepool {
                [self.assetArray addObject:alAsset];
            }
            
        }
        
    }];
}

@end
