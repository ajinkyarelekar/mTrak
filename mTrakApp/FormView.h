//
//  FormView.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageFormView.h"
#import "Formdetailview.h"
#import "DatabseInstance.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
@interface FormView : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *Formtable;
    NSMutableArray *FormNamearray;
    NSMutableArray *Formidarray,*FormTidarray;
    NSMutableArray *Formdatacountarray;
    AppDelegate *maindelegate;
    DatabseInstance *ObjSharedDb;
    int deleteID;
    NSIndexPath *indexPath;
    UILabel *labl;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath1;

@end
