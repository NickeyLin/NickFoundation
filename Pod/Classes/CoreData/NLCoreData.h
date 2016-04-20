//
//  NLCoreData.h
//  Pods
//
//  Created by Nick.Lin on 16/4/20.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NLManagedObject.h"

@interface NLCoreData : NSObject
@property (readonly, strong, nonatomic, nonnull) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic, nonnull) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic, nonnull) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 Model file name. It normally be name.momd. Default is named 'CoreData'
 */
@property (nonnull, nonatomic, copy) NSString *modelFileName;

/**
 Data base file name. It can be whatever you want.Default is named 'CoreData.sqlite'
 */
@property (nonnull, nonatomic, copy) NSString *databaseFileName;

/**
 Data file root path.Default is document path.
 */
@property (nonnull, nonatomic, copy) NSURL *dataRootPath;

/** 
 instant with default params
 */
+ (nonnull instancetype)instance;

// factory methods
+ (nonnull id)instanceWithModelFileName:(nullable NSString *)modelFileName databaseFileName:(nullable NSString *)databaseFileName rootPath:(nullable NSString *)rootPath;
+ (nonnull id)instanceWithModelFileName:(nullable NSString *)modelFileName databaseFileName:(nullable NSString *)databaseFileName;
+ (nonnull id)instanceWithModelFileName:(nullable NSString *)modelFileName;

/**
 *  Save context, save changes
 */
- (BOOL)saveContext;

/**
 *  Delete item from coredata. you need call saveContext in order to apply changes
 */
- (BOOL)deleteItem:(nonnull __kindof NSManagedObject *)item;

/**
 *  Discard changes of context
 */
- (void)undoChanges;

/**
 *  Generate a managed-object by class or entityName. The managed-object will be inserted into context. If you generate a managed-object through class, this class name must be equal to an exist entity name in mom file.
 */
- (__kindof NSManagedObject * _Nonnull)generateManagedObjectByClass:(nonnull Class)objectClass;
- (__kindof NSManagedObject * _Nonnull)generateManagedObjectByEntityName:(nonnull NSString *)entityName;

@end


@interface NLCoreData (FetchResults)
- (nullable NSEntityDescription *)entityDescriptionByName:(nonnull NSString *)className;
- (nullable NSArray *)fetchItemsByEntityDescriptionName:(nonnull NSString *)entityName;
- (nullable NSArray *)fetchItemsByEntityDescriptionName:(nonnull NSString *)entityName usingPredicate:(nullable NSPredicate *)predicate;
@end