//
//  DatabseInstance.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 30/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DatabseInstance : NSObject
{
    const char *dbpath;
	sqlite3 *sDB;
}
@property(assign,nonatomic)const char *dbpath;
@property(assign,nonatomic)sqlite3 *sDB;

+(DatabseInstance *)sharedInstance;
- (void) initDatabase;
-(void)openDB;
-(void)InsertRecord:(NSString *)Query;
-(void)UpdateRecord:(NSString *)Query;
-(BOOL)isLevelPresentLocally :(NSString *)Query;
-(NSMutableArray *)DisplaylevelData:(NSString *)Quuery;
-(BOOL)ExexuteOperation:(NSString *)Query;
-(NSMutableArray*)GettableDetails:(NSString*)SelectedTable;
-(NSString*)Getmaxid:(NSString*)query ForTable:(NSString*)table;

@end
