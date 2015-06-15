//
//  Level2rides.h
//  trackperformance
//
//  Created by Nanostuffs on 1/1/14.
//  Copyright (c) 2014 Trupti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Level3ViewController.h"
#import "DatabseInstance.h"
@class datepick,Ride;
@interface Level2rides : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
    DatabseInstance *ObjDb;
    datepick *dateobj;
    AppDelegate *mainDelegate;
    UIScrollView *Scrollvc;
    UIImageView *backview;
    UIAlertView *indiAlter;
    UITextField *txt;
    NSMutableArray *arrayOfStatusDown,*RideNameArray,*RideidArray;
    NSMutableArray *ZoneIDArr;
    UITableView *RideTable;
    int n;
    UIView *addfieldview;
    BOOL Addnewflag;
    //Added By Mayur
    NSString *Currentid;
    const char *dbpath;
}

@property(strong,nonatomic)Ride *rideObj;
@property(strong,nonatomic)NSString *Zonelabel,*Zonebtn,*Selectedzone,*zoneid;
@property(assign)BOOL flag,manageflag;
@property(assign)int SelectedBtn;
@property(strong,atomic)  UIButton *button;

@end
