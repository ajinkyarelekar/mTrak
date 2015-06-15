//
//  RootViewTabbar.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 27/05/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "HomeScreen.h"
#import "FormView.h"
#import "AppDelegate.h"
#import "DatabseInstance.h"
@interface RootViewTabbar : UIViewController
{
    AppDelegate *mainDelegate;
    id SelectedViewController;
    UIButton *InappBtn,*FormBtn,*HomeBtn,*HelpBtn;
    UIView *Baseview,*currentView;
     DatabseInstance *ObjSharedDb;
}
@property(strong,nonatomic)    UINavigationController *nav0,*nav1,*nav2,*nav3;

@end
