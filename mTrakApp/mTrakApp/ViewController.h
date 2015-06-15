//
//  ViewController.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Resetpassword.h"
#import "DatabseInstance.h"
//#import "MBProgressHUD.h"
@class AppDelegate;

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    DatabseInstance *ObjSharedDb;
    NSString *SelectedUser;
    UITextField *uname;
    UITextField *passwd;
    UITextField *Companycode;
    UIButton *Liteuser,*Prouser,*ForgotBtn;
    AppDelegate *mainDlegate;
    UIButton *LoginBtn;
    UILabel *Compnlbl;
    UIImageView *imagebg3;
    UIScrollView *view;
    int X;
    UIAlertView *HUD;

}

@end

