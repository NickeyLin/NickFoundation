//
//  NLManagedObject.m
//  Pods
//
//  Created by Nick.Lin on 16/4/20.
//
//

#import "NLManagedObject.h"
#import "NLCoreData.h"

@implementation NLManagedObject
+(instancetype)insertNewItemInCoreData:(NLCoreData *)coreData{
    return [coreData generateManagedObjectByClass:[self class]];
}

+ (instancetype)insertNewItemInCoreData:(NLCoreData *)coreData fillContent:(void (^)(id))fillBlock{
    id item = [self insertNewItemInCoreData:coreData];
    if (fillBlock) {
        fillBlock(item);
    }
    return item;
}

- (BOOL)saveToContext:(NLCoreData *)coredata{
    if (!coredata) {
        return NO;
    }
    return [coredata saveContext];
}

- (BOOL)removeFrom:(NLCoreData *)cda{
    return [cda deleteItem:self];
}

#pragma mark - Fetch
+ (NSArray<__kindof NSManagedObject *> *)itemsInCoreData:(nonnull NLCoreData *)cda{
    return [cda fetchItemsByEntityDescriptionName:NSStringFromClass([self class])];
}
+ (NSArray<NSManagedObject *> *)itemsInCoreData:(NLCoreData *)cda usingPredicate:(NSPredicate *)predicate{
    return [cda fetchItemsByEntityDescriptionName:NSStringFromClass([self class]) usingPredicate:predicate];
}
+ (NSArray<NSManagedObject *> *)itemsInCoreData:(NLCoreData *)cda withFormat:(NSString *)fmt, ...{
    va_list args;
    va_start(args, fmt);
    NSPredicate *pred = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    
    return [cda fetchItemsByEntityDescriptionName:NSStringFromClass(self) usingPredicate:pred];

}
@end
