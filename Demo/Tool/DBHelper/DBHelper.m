//
//  DBHelper.m
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"
#import "FMDBMigrationManager.h"
@interface DBHelper ()
@property (nonatomic,strong)FMDatabase *db;
@end
@implementation DBHelper

+ (instancetype)SharedInstance {
    static DBHelper * dbHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!dbHandler) {
            dbHandler = [[DBHelper alloc] init];
            [dbHandler createDataBase];
        }
    });
    return dbHandler;
}
- (void)createDataBase{
    _db = [FMDatabase databaseWithPath:[self getDBPath]];
}
- (NSString *)getDBPath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    MLog(@"%@",path);
    return [path stringByAppendingPathComponent:DB_NAME];
}
- (void)updateDBVersion{
    FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabaseAtPath:[self getDBPath]  migrationsBundle:[NSBundle mainBundle]];
    BOOL resultState = NO;
    NSError *error = nil;
    if (!manager.hasMigrationsTable) {
        resultState = [manager createMigrationsTable:&error];
    }
    resultState = [manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];//迁移函数
    //    MLog(@"Has `schema_migrations` table?: %@", manager.hasMigrationsTable ? @"YES" : @"NO");
    //    MLog(@"Origin Version: %llu", manager.originVersion);
    //    MLog(@"Current version: %llu", manager.currentVersion);
    //    MLog(@"All migrations: %@", manager.migrations);
    //    MLog(@"Applied versions: %@", manager.appliedVersions);
    //    MLog(@"Pending versions: %@", manager.pendingVersions);
}



@end
