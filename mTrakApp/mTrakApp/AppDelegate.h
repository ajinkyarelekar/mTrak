//
//  AppDelegate.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "RootViewTabbar.h"
#import "DatabseInstance.h"
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    DatabseInstance *ObjSharedDb;

    }
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property(strong,nonatomic)UINavigationController *Rootnav;
@property(strong,nonatomic)NSString *flag,*resourceString,*Loginuser;
@property(nonatomic,strong)NSString *Companyid,*Selectedtable,*formid,*formTid;
@property(nonatomic,strong)NSMutableArray *SelectedRidearray,*Selectedidarray,*Levelnamearray;
@property(assign) BOOL Backflag,LogoutFlag,Firstloginflag,Comefromroot,Alldataflag,Recordflag,Initilaflag;
@property(nonatomic,strong)NSString *UserType,*LastSyncdate,*Uid;
@property(nonatomic,strong)NSString *companyCode;
@property(nonatomic,strong)NSString *NOofForms,*NOofSections,*NOofFields,*NOofimages,*NOofAudio,*NOofVideo;

-(BOOL)checkInternet;
-(void)Showrootview;
-(void)Logout:(UINavigationController*)view;
-(NSString*)Getcurrentdate;



@end
