//
//  Formdetailview.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AppDelegate.h"
#import "DatabseInstance.h"
#import "MediaviewController.h"
@interface Formdetailview : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate,MPMediaPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIButton *FieldBtn,*MediaBtn;
    
    UIView *Globalview;
    UIActionSheet *popupview;
    UIDatePicker *datepicker;
    NSURL *recordedTmpFile;
    AVAudioRecorder *recorder;
    AppDelegate *mainDelegate;
    UILabel *Timelable;
    NSTimer *Recordtimer;
    UIView *View;
    UILabel *Nolbl;
    UIScrollView *InspectionScroll;
    NSMutableArray *QuestionArr,*DetailArray,*QAnsArray;
    int page,Selectedsectionid;
    UITextField *datetxt;
    UITextView *Textview;
    DatabseInstance *ObjdbInstance;
    NSString *MediaName,*mediaType,*Selectedtab,*SelectedSection;
    UIButton *Prevbtn,*Prevbtn1;
    UIPageControl *Pagecnt;
    BOOL pageControlBeingUsed;
    UIButton *SetstatusBtn;
    UITextField *Currenttxtfield;
    UITableView *Tbaleview;
    BOOL mtselectflag,singleselect;
    BOOL firstSaveflag;
    
    DatabseInstance *ObjSharedDb;
}

@property(strong,nonatomic)NSString *ridetypeid,*MediaName;
@property(strong,nonatomic)UIScrollView *Headscroll;
@property(strong,nonatomic) NSMutableArray *Globarray;

@end
