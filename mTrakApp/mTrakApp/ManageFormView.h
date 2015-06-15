//
//  ManageFormView.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "ZoneSelection.h"
#import "DatabseInstance.h"
#import <MessageUI/MessageUI.h>
@interface ManageFormView : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextViewDelegate,MFMailComposeViewControllerDelegate,UIScrollViewDelegate>
{
//    UIButton *FieldBtn,*MediaBtn;
    AppDelegate *mainDelegate;
//    UIView *Globalview;
    UITableView *Table;
    DatabseInstance *ObjdbInstance;
    NSMutableArray *Fieldnamesarray,*QuestionDetailArr;
    NSString *SelectedTab,*SelectedSection;
    UIScrollView *Globalview,*InspectionScroll;
    UIButton *Prevbtn;
    UILabel *Nolbl;
    int x;
    int y;
    int Selectedtype,Selectedsectionid,Selectedsectionsubid;
    UITextField *Currentfield,*SectionTxtfield;
    NSMutableArray *SectionArray,*DetailArray;
    BOOL Sectionflag,Editstatus;
    int Fieldno;
    UILabel *Headlbl5;
    UITextField *lbl5val;
    UITextView *lbl2val;
}

@property(strong,nonatomic)NSString *SelectedTbale,*SelectedFormId;
//@property int ;
@end
