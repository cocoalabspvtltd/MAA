

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

#pragma mark - NSManagedObjectContext + Additions

@interface NSManagedObjectContext (Additions)

+(NSManagedObjectContext *)newContextForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator;
@end

#pragma mark

@interface CLCoreDataAdditions : NSObject     {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property(nonatomic, strong) NSURL *modelURL;
@property(nonatomic, strong) NSURL *storeURL;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark - Interfaces

+ (CLCoreDataAdditions *)sharedInstance;
- (void)refreshObject:(NSManagedObject *)managedObject;
- (void)resetContext;
- (id)entityForName:(NSString *)entityName;
- (id)newEntityForName:(NSString *)entityName;
- (void)deleteObject:(NSManagedObject *)object;
- (BOOL)saveEntity;
- (NSArray *)getAllDocuments:(NSString *)entity;
- (NSArray *)getAllDocumentsFor:(NSString *)entity withPredicate:(NSPredicate *)predicate;

@end
