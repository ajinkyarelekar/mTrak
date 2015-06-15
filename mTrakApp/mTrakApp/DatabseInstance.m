//
//  DatabseInstance.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 30/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "DatabseInstance.h"
static DatabseInstance *_instance;

@implementation DatabseInstance
@synthesize dbpath,sDB;

+(DatabseInstance *)sharedInstance
{
    if (_instance == nil) {
        _instance = [[self alloc]init];
    }
    return _instance;
}


-(void)openDB
{
    [self initDatabase];
    
    if (sqlite3_open(dbpath, &sDB)!=SQLITE_OK)
    {
        sqlite3_close(sDB);
    }
}

- (void) initDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TrakDb.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    dbpath = [writableDBPath UTF8String];
    
    if (success) return;
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TrakDb.sqlite"];
    
    success = [fileManager fileExistsAtPath:defaultDBPath];
    
    
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
    
}

-(void)InsertRecord:(NSString *)Query
{
    NSString *insertQuery =Query;
    [self openDB];
    char *err;
    
    if (sqlite3_exec(sDB, [insertQuery UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    {
        sqlite3_close(sDB);
        NSLog(@"Insert Records Fail");
    }
    else
    {
        NSLog(@"Insert Records SuccessFull");
        sqlite3_close(sDB);
    }
    
}

-(NSMutableArray *)DisplaylevelData:(NSString *)Quuery
{
    sqlite3_stmt    *statement;
    NSDictionary *tempDict;
    NSMutableArray *ReturnArray=nil;
    
    [self initDatabase];
    
    if (sqlite3_open(dbpath, &sDB) == SQLITE_OK)
    {
        const char *query_stmt = [Quuery UTF8String];
        int rval = sqlite3_prepare_v2(sDB, query_stmt, -1, &statement, NULL);
        if(rval == SQLITE_OK)
        {
            ReturnArray=[[NSMutableArray alloc]init];
            NSString *LevelID,*Levelname;
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                if(tempDict)
                    tempDict=nil;
                tempDict=[[NSMutableDictionary alloc]init];
                
                if ([Quuery rangeOfString:@"level2"].location!=NSNotFound) {
                    
                    LevelID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    Levelname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    
                    [tempDict setValue:LevelID forKey:@"ID"];
                    
                    [tempDict setValue:Levelname forKey:@"LevelName"];
                    
                    [ReturnArray addObject:tempDict];
                    
                }
                else
                {
                    LevelID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    Levelname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    
                    [tempDict setValue:LevelID forKey:@"ID"];
                    
                    [tempDict setValue:Levelname forKey:@"LevelName"];
                    
                    [ReturnArray addObject:tempDict];
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(sDB);
    }
    else
        sqlite3_close(sDB);
    return ReturnArray;
}

-(void)UpdateRecord:(NSString *)Query
{
    NSString *Updatequery =Query;
    [self openDB];
    char *err;
    
    if (sqlite3_exec(sDB, [Updatequery UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    {
        sqlite3_close(sDB);
        NSLog(@"Update Records Fail");
    }
    else
    {
        NSLog(@"Update Records SuccessFull");
        sqlite3_close(sDB);
    }
    
}

-(BOOL)ExexuteOperation:(NSString *)Query
{
    NSString *Sqlquery =Query;
    [self openDB];
    char *err;
    
    if (sqlite3_exec(sDB, [Sqlquery UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    {
        sqlite3_close(sDB);
        NSLog(@"Operation Fail");
    
    }
    else
    {
        NSLog(@"Operation SuccessFull");
        sqlite3_close(sDB);
        return YES;
    }
    return NO;
}

-(BOOL)isLevelPresentLocally :(NSString *)Query
{
    [self openDB];
    BOOL status=NO;
    
    const char *databasepath=dbpath;
    
    sqlite3_stmt *statement=nil;
    
    if(sqlite3_open(databasepath, &sDB)== SQLITE_OK)
    {
        
        const char *select_stmt=[Query UTF8String];
        
        if(sqlite3_prepare_v2(sDB,select_stmt, -1, &statement, NULL)== SQLITE_OK)
            
        {
            if (sqlite3_step(statement)== SQLITE_ROW)
                
            {
                
                status=YES;
                
            }
        }
        else  //prepare can not be executed
        {                     //some error
            
            NSLog(@"prepare can not be executed");
            
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"failed to open db");
    }
    sqlite3_close(sDB);
    
    
    return status;
    
}

-(NSMutableArray*)GettableDetails:(NSString*)SelectedTable
{
    [self openDB];
    int cnt=0;
    NSMutableArray *FieldArray=[[NSMutableArray alloc]init];
    sqlite3_stmt *statement1 = nil;
    if (sqlite3_open(dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"PRAGMA table_info(%@)",SelectedTable]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
		{
            
			while (sqlite3_step(statement1) == SQLITE_ROW)
			{
                const char* Rolename1 = (const char*)sqlite3_column_text(statement1, 1);
                NSString *Columnname = Rolename1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Rolename1];
                if (cnt!=0) {
                    [FieldArray addObject:Columnname];
                }
                cnt++;
            }
        }
        sqlite3_finalize(statement1);
        
    }
    
    sqlite3_close(sDB);
    
    return FieldArray;
}

-(NSString*)Getmaxid:(NSString*)query ForTable:(NSString*)table
{
    [self openDB];
    NSString *maxid=@"0";

    sqlite3_stmt *statement1 = nil;
    if (sqlite3_open(dbpath, &sDB) == SQLITE_OK)
	{
      		
		const char *query_stmt = [query UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
		{
            
			while (sqlite3_step(statement1) == SQLITE_ROW)
			{
                NSString *Columnname = @"";
                if ([table isEqualToString:@"tp_forms"])
                {
                    const char* Rolename1 = (const char*)sqlite3_column_text(statement1, 0);
                    Columnname = Rolename1 == NULL ? @"L0" : [[NSString alloc] initWithUTF8String:Rolename1];
                }
                else if ([table isEqualToString:@"companyidTable"] || [table isEqualToString:@"Formtable"])
                {
                    const char* Rolename1 = (const char*)sqlite3_column_text(statement1, 0);
                    Columnname =Rolename1 == NULL ? @"0" : [[NSString alloc] initWithUTF8String:Rolename1];;
                }
                maxid=Columnname;
            }
        }
        sqlite3_finalize(statement1);
        
    }
    
    sqlite3_close(sDB);
    
    return maxid;
}


@end
