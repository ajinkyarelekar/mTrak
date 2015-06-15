//
//  CreateForm.h
//  trackperformance
//
//  Created by Nanostuffs's Macbook on 21/04/14.
//  Copyright (c) 2014 Trupti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DatabseInstance.h"
@class AppDelegate;

@interface CreateForm : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
   AppDelegate *mainDelegate;
    NSString *Tablename;
    DatabseInstance *DbSharedObj;
    UITableView *Formtable;
    NSMutableArray *FieldArray,*FieldnameArray;
    NSString *SelectedRole,*Formname;
    UITextField *SelectFormTxt;
    NSString *selectedId;
    UIView *view;
    UIImageView *Navbar;
}

@property(strong,nonatomic)UITextField *FormnameTxt,*SelectFormTxt;

@end
