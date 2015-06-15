//
//  Level3ViewController.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 08/05/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DatabseInstance.h" //added by mayur
#import <sqlite3.h>

@interface Level3ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
    AppDelegate *mainDelegate;
    UITableView * Detailtable;
    NSMutableArray *DetailLabelArray,*Indexarray,*DetailidlArray;
    UIView *addfieldview;
    UITextField *txt;
    NSString *Currentid;
    DatabseInstance *ObjDb; ////added by mayur
    BOOL Addnewflg;
    const char *dbpath;
	sqlite3 *sDB;
    UILabel *label;
}
@property(strong,nonatomic)NSString *level1,*level2,*level1name,*level2name,*Detailname,*rideid;
@property BOOL manageflg;

@end
