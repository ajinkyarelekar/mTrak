//
//  Help.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;
@interface Help : UIViewController<UIAlertViewDelegate,UIWebViewDelegate>
{
    AppDelegate *mainDelegate;
    UIButton *Prevbtn;
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicatorLoading;
}
@end
