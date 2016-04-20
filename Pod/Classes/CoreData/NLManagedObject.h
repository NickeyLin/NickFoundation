//
//  NLManagedObject.h
//  Pods
//
//  Created by Nick.Lin on 16/4/20.
//
//

#import <CoreData/CoreData.h>

@class NLCoreData;

@interface NLManagedObject : NSManagedObject
+ (nonnull instancetype)insertNewItemInCoreData:(nonnull NLCoreData *)coreData;
+ (nonnull instancetype)insertNewItemInCoreData:(nonnull NLCoreData *)coreData fillContent:(void (^ _Nullable)(_Nullable id item))fillBlock;
- (BOOL)saveToContext:(nonnull NLCoreData *)coredata;
- (BOOL)removeFrom:(nonnull NLCoreData *)cda;

+ (nullable NSArray<__kindof NSManagedObject *> *)itemsInCoreData:(nonnull NLCoreData *)cda;
+ (nullable NSArray<__kindof NSManagedObject *> *)itemsInCoreData:(nonnull NLCoreData *)cda usingPredicate:(nullable NSPredicate *)predicate;

/**
 * Fetch record items by format string.
 */
+ (nullable NSArray<__kindof NSManagedObject *> *)itemsInCoreData:(nonnull NLCoreData *)cda withFormat:(nullable NSString *)fmt,...;

/**
 *  Fetch items by sort descriptions.
 *
 *  @param cde              CoreDataEnvir instance.
 *  @param sortDescriptions SortDescriptions
 *  @param fmt              Predicate format.
 *
 *  @return Array of items match the condition.
 */
//+ (nullable NSArray<__kindof NSManagedObject *> *)itemsInCoreData:(nonnull NLCoreData *)cda sortDescriptions:(nonnull NSArray *)sortDescriptions withFormat:(nonnull NSString *)fmt,...;

/**
 *  Fetch items addition by limited range.
 *
 *  @param cde              CoreDataEnvir instance
 *  @param sortDescriptions SortDescriptions
 *  @param offset           offset
 *  @param limtNumber       limted number
 *  @param fmt              Predicate format.
 *
 *  @return Array of items match the condition.
 */
//+ (NSArray<__kindof NSManagedObject *> *)itemsInCoreData:(nonnull NLCoreData *)cda sortDescriptions:(NSArray *)sortDescriptions fromOffset:(NSUInteger)offset limitedBy:(NSUInteger)limitNumber withFormat:(NSString *)fmt,...;

/**
 *  Fetch item in specified context.
 *
 *  @param cde CoreDataEnvir instance
 *
 *  @return Last item of the managed object in context.
 */
//+ (id)lastItemInCoreData:(nonnull NLCoreData *)cda;

/**
 *  Fetch item in specified context through predicate.
 *
 *  @param cde       CoreDataEnvir instance
 *  @param predicate Predicate.
 *
 *  @return Last item of the managed object in context.
 */
//+ (id)lastItemInCoreData:(nonnull NLCoreData *)cde usingPredicate:(NSPredicate *)predicate;

/**
 *  Fetch item in specified context through format string.
 *
 *  @param cde
 *  @param fmt Predicate format string.
 *
 *  @return Last item of the managed object in context.
 */
//+ (id)lastItemInCoreData:(nonnull NLCoreData *)cde withFormat:(NSString *)fmt,...;
@end
