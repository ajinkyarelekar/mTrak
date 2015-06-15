//
//  Manageconnection.h
//  trackperformance
//
//  Created by Nanostuffs's Macbook on 17/03/14.
//  Copyright (c) 2014 Trupti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
@interface Manageconnection : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,MBProgressHUDDelegate,MFMailComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *mainDelegate;
    UIAlertView *alert;
    NSMutableArray *IdArray;
    NSMutableArray *Tablearray,*LoginArray,*Imagesarray;
    UITextField *hostName,*Uname,*Passwd,*Companycode,*DatabaseName;
    BOOL Errorflag,SelectedFlag,otherdbflag,Firstflag,Alldataflag;
    UIButton *submitbtn,*fetchbtn,*_radio1,*_radio2;
    DatabseInstance *SharedobjDb;
    sqlite3 *sDB;
    MBProgressHUD *HUD;
    UIButton *Prevbtn;
    UIView *Globalview;
    NSMutableArray *FormNamearray,*Formidarray;
    UITextField *SelectFormTxt;
    NSString *Selectedformid,*SelectedformTid;
    UIButton *Csvbtn;
    UIScrollView *servertabScroll;
    NSMutableArray *FormTidarray;
}
@end
