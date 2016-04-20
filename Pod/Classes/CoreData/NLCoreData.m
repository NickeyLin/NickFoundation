//
//  NLCoreData.m
//  Pods
//
//  Created by Nick.Lin on 16/4/20.
//
//

#import "NLCoreData.h"
#import "CHCommonDefine.h"

#define Defult_ModelFileName @"CoreData"
#define Defult_SqliteFileName @"CoreData.sqlite"

@implementation NLCoreData
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
#pragma mark - Life Cycle
+ (nonnull instancetype)instance{
    static NLCoreData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NLCoreData alloc]init];
    });
    return sharedInstance;
}

+ (id)instanceWithModelFileName:(NSString *)modelFileName databaseFileName:(NSString *)databaseFileName rootPath:(NSString *)rootPath{
    NLCoreData *instance = [[NLCoreData alloc]init];
    if (modelFileName) {
        instance.modelFileName = modelFileName;
    }
    if (databaseFileName) {
        instance.databaseFileName = databaseFileName;
    }
    if (rootPath) {
        instance.dataRootPath = rootPath;
    }
    return instance;
}

+ (nonnull id)instanceWithModelFileName:(nullable NSString *)modelFileName databaseFileName:(nullable NSString *)databaseFileName{
    return [self instanceWithModelFileName:modelFileName databaseFileName:databaseFileName rootPath:nil];
}
+ (nonnull id)instanceWithModelFileName:(nullable NSString *)modelFileName{
    return [self instanceWithModelFileName:modelFileName databaseFileName:nil rootPath:nil];
}

- (nonnull id)init{
    self = [super init];
    if (self) {
        self.modelFileName = Defult_ModelFileName;
        self.databaseFileName = Defult_SqliteFileName;
        self.dataRootPath = [self defaultCoreDataDirectory];
    }
    return self;
}
#pragma mark -

- (NSURL *)defaultCoreDataDirectory{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    url = [url URLByAppendingPathComponent:@"NLCoreData"];
    return url;
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.modelFileName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [self.dataRootPath URLByAppendingPathComponent:self.databaseFileName];

    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Getters
- (NSString *)modelFileName{
    if (!_modelFileName) {
        return Defult_ModelFileName;
    }
    return _modelFileName;
}
- (NSString *)databaseFileName{
    if (!_databaseFileName) {
        return Defult_SqliteFileName;
    }
    return _databaseFileName;
}
- (NSURL *)dataRootPath{
    if (!_dataRootPath) {
        return [self defaultCoreDataDirectory];
    }
    return _dataRootPath;
}
#pragma mark - Public
- (BOOL)saveContext{
    if (![self.managedObjectContext hasChanges]) {
        return YES;
    }
    BOOL result;
    [self.persistentStoreCoordinator lock];
    NSError *error = nil;
    
    result = [self.managedObjectContext save:&error];
    
    if (!result) {
        if (error != nil) {
            CHLog(@"%s, error:%@", __FUNCTION__, error);
        }
    }
    [self.persistentStoreCoordinator unlock];
    return result;
}
- (BOOL)deleteItem:(__kindof NSManagedObject *)item{
    if (!item) {
        return NO;
    }
    
    NSManagedObject *getObject = item;
    if (item.isFault) {
        getObject = [self managedObjectByManagedID:item.objectID];
    }
    if (!getObject) {
        return NO;
    }
    @try {
        [self.managedObjectContext deleteObject:getObject];
    }
    @catch (NSException *exception) {
        CHLog(@"exce :%@", [exception description]);
    }
    @finally {
        
    }

    return YES;
}
- (void)undoChanges{
    if (![self.managedObjectContext hasChanges]) {
        return;
    }
    
    [self.persistentStoreCoordinator lock];
    
    [self.managedObjectContext undo];

    [self.persistentStoreCoordinator unlock];
}
- (nullable NSManagedObject *)managedObjectByManagedID:(nonnull NSManagedObjectID *)managedID{
    if (!managedID || !self.managedObjectContext) {
        return nil;
    }
    
    NSManagedObject *item = nil;
    @try {
        item = [self.managedObjectContext objectWithID:managedID];
    }
    @catch (NSException *exception) {
        CHLog(@"exce :%@", [exception description]);
        item = nil;
    }
    @finally {
        
    }
    return item;
}

- (BOOL)deleteManagedObject:(nonnull NSManagedObject *)managedObject{
    if (!managedObject || !self.managedObjectContext) {
        return NO;
    }
    NSManagedObject *copyObject = managedObject;
    if (copyObject.isFault) {
        copyObject = [self managedObjectByManagedID:copyObject.objectID];
    }
    if (!copyObject) {
        return NO;
    }
    @try {
        [self.managedObjectContext deleteObject:copyObject];
    }
    @catch (NSException *exception) {
        CHLog(@"exce :%@", [exception description]);
    }
    @finally {
        
    }
    return YES;
}
#pragma mark -
- (NSManagedObject *)generateManagedObjectByClass:(Class)objectClass{
    return [self generateManagedObjectByEntityName:NSStringFromClass(objectClass)];
}

- (NSManagedObject *)generateManagedObjectByEntityName:(NSString *)entityName{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
}



@end


@implementation NLCoreData (FetchResults)

- (NSEntityDescription *)entityDescriptionByName:(NSString *)className{
    return [NSEntityDescription entityForName:className inManagedObjectContext:self.managedObjectContext];
}

- (NSArray *)fetchItemsByEntityDescriptionName:(NSString *)entityName{
    NSArray *items = nil;
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:[self entityDescriptionByName:entityName]];
    
    NSError *error = nil;
    items = [self.managedObjectContext executeFetchRequest:req error:&error];
    if (error) {
        NSLog(@"%s, error:%@, entityName:%@", __FUNCTION__, error, entityName);
    }
    
    return items;
}

- (NSArray *)fetchItemsByEntityDescriptionName:(NSString *)entityName usingPredicate:(NSPredicate *)predicate{
    NSArray *items = nil;
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setPredicate:predicate];
    [req setEntity:[self entityDescriptionByName:entityName]];
    
    NSError *error = nil;
    items = [self.managedObjectContext executeFetchRequest:req error:&error];
    if (error) {
        NSLog(@"%s, error:%@, entityName:%@", __FUNCTION__, error, entityName);
    }
    
    return items;
}

@end