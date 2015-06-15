//
//  ZoneSelection.h
//  trackperformance
//
//  Created by Sanjay on 4/30/13.
//  Copyright (c) 2013 Trupti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Level2rides.h"
#import "DatabseInstance.h"
@class AppDelegate;
@interface ZoneSelection : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
    NSMutableArray *ZoneArray,*ZoneidArray,*Formsarray;
    UIButton *Zonetitlebtn;
    UIImageView *img;
    AppDelegate *mainDelegate;
    UIView *addfieldview,*detailview;
    UITextField *txt,*Levelmname,*Formname;
    DatabseInstance *ObjDb;
    NSMutableArray *FormnameArray;
    //Added By Mayur
    NSString *Levelname,*Forselectmname,*Selectedtable,*Selctedid;
//    const char *dbpath;
//	sqlite3 *sDB;
    UITableView *Table;
    BOOL Present;
}
@property(strong,nonatomic)UITableView *ZoneTable;
@property BOOL Manageflag;
@property(strong,nonatomic)NSString *Selectedform,*Selectedformid;
@property(assign,nonatomic)int formid;

@end
