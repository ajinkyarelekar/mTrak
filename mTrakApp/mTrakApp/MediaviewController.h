//
//  MediaviewController.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 19/05/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DatabseInstance.h"
@interface MediaviewController : UIViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    AppDelegate *mainDelegate;
    int Totalrows;
    AVAudioPlayer *avPlayer;
    NSMutableArray *DetailsArray,*DetailIdArray;
    UIScrollView *MainUIview;
    DatabseInstance *Objshareddb;
    UIActionSheet *Sheet;
    NSString *SelectedID;
    UIView *RenameView,*Playview,*detailview;
    NSTimer *Recordtimer;
    UILabel *Timelable;
    int Selectedarrayid;

}
@property(strong,nonatomic)NSString *Mediatype,*Selectedtable;
@end
