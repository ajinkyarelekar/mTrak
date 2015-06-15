//
//  Resetpassword.h
//  Shpockpages
//
//  Created by Nanostuffs on 8/14/13.
//  Copyright (c) 2013 Trupti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;
@interface Resetpassword : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *Emailaddr;
    UIAlertView *indiAlter;
    AppDelegate *maindelegate;
}
@end
