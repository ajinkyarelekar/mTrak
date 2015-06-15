//
//  HomeScreen.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Help.h"
#import "CreateForm.h"
#import "DatabseInstance.h"
#import "Manageconnection.h"
@interface HomeScreen : UIViewController<UIAlertViewDelegate>
{
    DatabseInstance *ObjSharedDb;
    UITabBarController *objTabBarController;
    int Formcount;
    AppDelegate *mainDelegate;
    UIButton * ServerButton;
}
@end
