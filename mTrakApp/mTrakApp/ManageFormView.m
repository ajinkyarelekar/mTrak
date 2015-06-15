//
//  ManageFormView.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "ManageFormView.h"

@interface ManageFormView ()

@end

@implementation ManageFormView
@synthesize SelectedTbale,SelectedFormId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ObjdbInstance=[DatabseInstance sharedInstance];
    
    
    UIView *backview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background.png"]];
    backview.frame=CGRectMake(0, 0, 320, self.view.frame.size.height);
    [self.view addSubview:backview];
    
    if (Adjust_Height ==20) {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];

    }

    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    UIImageView *Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    Navbar.userInteractionEnabled=YES;
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=@"Manage Form";
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.backgroundColor=[UIColor clearColor];
    Title.textColor=[UIColor whiteColor];
    Title.textAlignment=NSTextAlignmentCenter;
    [Navbar addSubview:Title];
    
    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [Navbar addSubview:LogoutBtn];
    
//    UIButton *CsvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    CsvBtn.frame = CGRectMake(228,0,42,44);
//    [CsvBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
//    [CsvBtn addTarget:self action:@selector(ExportCSV) forControlEvents:UIControlEventTouchUpInside];
//    [CsvBtn setTitle:@"csv" forState:UIControlStateNormal];
//    [Navbar addSubview:CsvBtn];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+42, 320, self.view.frame.size.height-Adjust_Height)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,7,50,30);
    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [Navbar addSubview:button];
    
    //Left menu
    UIButton *RideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    RideBtn.frame = CGRectMake(0,0,215/2,109/2);
    RideBtn.tag=1;
    RideBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [RideBtn setTitle:@"Form Identifier labels" forState:UIControlStateNormal];
    RideBtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    RideBtn.titleLabel.numberOfLines=3;
    [RideBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [RideBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
    [RideBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
    [RideBtn addTarget:self action:@selector(Leftclicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:RideBtn];
    Prevbtn=RideBtn;

    UIButton *InspectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    InspectionBtn.frame = CGRectMake(214/2,0,215/2,109/2);
    InspectionBtn.tag=2;
    [InspectionBtn setTitle:@"Section Labels" forState:UIControlStateNormal];
    InspectionBtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    InspectionBtn.titleLabel.numberOfLines=2;
    InspectionBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [InspectionBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [InspectionBtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
    [InspectionBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];    [InspectionBtn addTarget:self action:@selector(Leftclicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:InspectionBtn];

    UIButton *FeedbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FeedbackBtn.frame = CGRectMake(428/2,0,213/2,109/2);
    FeedbackBtn.tag=3;
    FeedbackBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [FeedbackBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [FeedbackBtn setTitle:@"Field labels" forState:UIControlStateNormal];
    FeedbackBtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    FeedbackBtn.titleLabel.numberOfLines=2;
    [FeedbackBtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
    [FeedbackBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
    [FeedbackBtn addTarget:self action:@selector(Leftclicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:FeedbackBtn];

    UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 70)];
    lbl2.backgroundColor=[UIColor clearColor];
    lbl2.text=@"Here you can edit the label for your form";
    lbl2.lineBreakMode=NSLineBreakByWordWrapping;
    lbl2.numberOfLines=2;
    lbl2.font=[UIFont systemFontOfSize:13];
    lbl2.textAlignment=NSTextAlignmentCenter;
    [view addSubview:lbl2];

    
    Globalview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 80, 320, self.view.frame.size.height-(Adjust_Height+ 220))];
    Globalview.backgroundColor=[UIColor clearColor];
    Globalview.userInteractionEnabled=YES;
    Globalview.scrollEnabled=YES;
    Globalview.delegate=self;
    [view addSubview:Globalview];
    Globalview.contentSize=CGSizeMake(320, self.view.frame.size.height-220+50);
//    UITapGestureRecognizer *tap=[[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Resignontap:)] autorelease];
//    tap.numberOfTapsRequired=1;
//    tap.cancelsTouchesInView = NO;
//    [Globalview addGestureRecognizer:tap];
    
    UIButton *SaveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SaveBtn.frame = CGRectMake(15,Globalview.frame.size.height+85,135,38);
    [SaveBtn setBackgroundImage:[UIImage imageNamed:@"Save.png"] forState:UIControlStateNormal];
    //    [SaveBtn setTitle:@"Save" forState:UIControlStateNormal];
    SaveBtn.tag=1000;
    [SaveBtn addTarget:self action:@selector(Save) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:SaveBtn];
    
    UIButton *CancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CancelBtn.frame = CGRectMake(165,Globalview.frame.size.height+85,135,38);
    [CancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    //    [SaveBtn setTitle:@"Save" forState:UIControlStateNormal];
    CancelBtn.tag=1000;
    [CancelBtn addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:CancelBtn];

    SelectedTab=@"Identifier";
    [self Formview];

}

#pragma mark:logout
-(void)Logoutclicked
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to logout." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alert.tag=188;
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==188) {
        if (buttonIndex==1) {
            [self Logout];
        }
    }
    if (alertView.tag==-1) {
        [self Fielddenameview];
    }
}

-(void)Logout
{
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [mainDelegate Showrootview];

}

-(void)hideFieldNmedia:(BOOL)flg
{
    // Added by ajinkya.
//    MediaBtn.hidden=flg;
//    FieldBtn.hidden=flg;
}
-(void)popViewback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Cancel
{
    if ([SelectedTab isEqualToString:@"Field"]) {
        [self Fielddenameview];
        return;
    }
    
    if (Globalview!=nil)
    {
        
        for (UIView *view in Globalview.subviews) {
            if ([view isKindOfClass:[UITextField class]]) {
                UITextField *Txt=(UITextField*)view;
                Txt.text=@"";
                
            }
        }

    }
   
}

-(void)Leftclicked:(id)Sender
{
    SelectedSection=@"";

    if (Globalview) {
        [Globalview setContentOffset:CGPointMake(0, 0)];
        
    }
    [self hideFieldNmedia:YES];
    //    int n= [Sender tag];
    if (Prevbtn) {
        [Prevbtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
        
    }
    UIButton *Btn=(UIButton*)Sender;

    if (Prevbtn.tag==[Sender tag]) {
        [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
        return;
    }
    Prevbtn=Btn;
    for (__strong UIView *view in Globalview.subviews) {
        if (view.tag!=1000) {

        [view removeFromSuperview];
        view=nil;
        }
    }
    
    if ([Sender tag]==1) {
        SelectedTab=@"Identifier";
        [self Formview];
        [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
        
    }
    else
        if ([Sender tag]==2) {
            SelectedTab=@"Section";
            [self SectionView];

            [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            SelectedTab=@"Field";

//            [self Getfieldlabels];
            SelectedSection=@"1";
            [self FieldsView];
            [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
//            [self hideFieldNmedia:NO];
            
        }
}

-(void)TopmenuClicked:(id)Sender
{
    if (Globalview) {
        [Globalview setContentOffset:CGPointMake(0, 0)];
        
    }
    if ([Sender tag]==1)
    {
    
        if ([SelectedTab isEqualToString:@"Field"])
        {
            for (__strong UIView *view in Globalview.subviews) {
                if (view.tag!=1000) {
                    [view removeFromSuperview];
                    view=nil;
                }
               
            }
            [self FieldsView];

        }
    
//        [FieldBtn setBackgroundImage:[UIImage imageNamed:@"Fields_p.png"] forState:UIControlStateNormal];
//        [MediaBtn setBackgroundImage:[UIImage imageNamed:@"Media_n.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        for (__strong UIView *view in Globalview.subviews) {
            if (view.tag!=1000) {

            [view removeFromSuperview];
            view=nil;
            }
        }
        
//        [FieldBtn setBackgroundImage:[UIImage imageNamed:@"Fields_n.png"] forState:UIControlStateNormal];
//        [MediaBtn setBackgroundImage:[UIImage imageNamed:@"Media_p.png"] forState:UIControlStateNormal];
        
    }
}

#pragma mark :Save 
-(void)Save
{
    if ([SelectedTab isEqualToString:@"Identifier"])
    {
        [self SaveIdentifier];
        
    }
    else
        if ([SelectedTab isEqualToString:@"Section"])
        {
            [self SaveSectionlbl];
        }
    else
        if ([SelectedTab isEqualToString:@"Field"])
        {
            [self SaveFieldlbl];
            
        }
    
}

-(void)SaveIdentifier//section 1
{
    NSString *Ridename=@"";
    NSString *Capacity=@"";
    NSString *Inspectiondate=@"";
    for (UIView *view in Globalview.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *Txt=(UITextField*)view;
            if (Txt.tag==1) {
                Ridename=Txt.text;
            }
            if (Txt.tag==2) {
                Capacity=Txt.text;
            }
            if (Txt.tag==3) {
                Inspectiondate=Txt.text;
            }
            if (Txt.text.length<1) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                
                return;
            }

        }
    }
    
    
    NSString *Query=@"";
    
    [ObjdbInstance openDB];
    
           NSString *Query1=[NSString stringWithFormat:@"select * FROM Levels where formid='%@'",SelectedFormId ];
           BOOL ExistFlag=[ObjdbInstance isLevelPresentLocally:Query1];
    
        if (ExistFlag)
           {
    //Update
               Query=[NSString stringWithFormat:@"UPDATE Levels SET Level1_name ='%@',Level2_name ='%@',Level3_name ='%@',dateModified='%@' where formid='%@'",Ridename,Capacity,Inspectiondate,[mainDelegate Getcurrentdate],SelectedFormId ];
    
          }
    else
        Query=[NSString stringWithFormat:@"INSERT INTO Levels (Level1_name,Level2_name ,Level3_name,formid,dateCreated,dateModified,usertype) VALUES('%@','%@','%@','%@','%@','%@','%@') ",Ridename,Capacity,Inspectiondate,SelectedFormId ,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];

    BOOL flag=[ObjdbInstance ExexuteOperation:Query];
//    char *err;
//    if (sqlite3_exec(ObjdbInstance.sDB, [Query UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    if (!flag)
    {
        NSLog(@"Operation Fail");
    }
    else
    {
        NSLog(@"Operation successfully");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Data Saved Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    sqlite3_close(ObjdbInstance.sDB);
    
}

-(void)SaveSectionlbl//section 2
{
    NSString *Ridename=@"";

    NSMutableArray *temparray=[[NSMutableArray alloc]init];
    for (UIView *view in Globalview.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *Txt=(UITextField*)view;
//            if (Txt.tag==1) {
                Ridename=Txt.text;
            [temparray addObject:Ridename];

//            if (Txt.text.length<1) {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//                [alert show];
//                [alert release];
//                
//                return;
//            }
        }
    }
    
    NSString *Query=@"";
    
    [ObjdbInstance openDB];
    BOOL Flag=NO;
    BOOL no=0;
    for (int i=0; i<temparray.count; i++) {
        NSString *text=[temparray objectAtIndex:i];

        if (text.length<1) {
            no=0;
        }
        else
            no=1;
        
    NSString *Query1=[NSString stringWithFormat:@"select * FROM SectionTable where formid=%@ AND sid='%d'",mainDelegate.formTid,i+1];
    BOOL ExistFlag=[ObjdbInstance isLevelPresentLocally:Query1];
    
    if (ExistFlag)
    {
        //Update
        Query=[NSString stringWithFormat:@"UPDATE SectionTable SET section_name ='%@',hidden=%d where sid='%d' AND formid='%@'",[temparray objectAtIndex:i],no,i+1,mainDelegate.formTid];
        
    }
    else
        Query=[NSString stringWithFormat:@"INSERT INTO SectionTable (sid,section_name,formid,hidden,usertype) VALUES('%d','%@','%@',%d,'%@') ",i+1,[temparray objectAtIndex:i],mainDelegate.formTid,no,mainDelegate.UserType];
    
         Flag=[ObjdbInstance ExexuteOperation:Query];
    }

    if (!Flag)
    {
        NSLog(@"Operation Fail");
    }
    else
    {
        NSLog(@"Operation successfully");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Data Saved Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    sqlite3_close(ObjdbInstance.sDB);
    
}


-(void)Savecommentlbl//section 3
{
    NSString *Ridename=@"";
    NSString *Capacity=@"";
    NSString *Inspectiondate=@"";
    for (UIView *view in InspectionScroll.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *Txt=(UITextField*)view;
            if (Txt.tag==1) {
                Ridename=Txt.text;
            }
            if (Txt.tag==2) {
                Capacity=Txt.text;
            }
            if (Txt.tag==3) {
                Inspectiondate=Txt.text;
            }
            if (Txt.text.length<1) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                
                return;
            }
        }
    }
    
    NSString *Query=@"";
    
    [ObjdbInstance openDB];
    
    NSString *Query1=[NSString stringWithFormat:@"select * FROM Levels where formid='%@'",SelectedFormId ];
    BOOL ExistFlag=[ObjdbInstance isLevelPresentLocally:Query1];
    
    if (ExistFlag)
    {
        //Update
        Query=[NSString stringWithFormat:@"UPDATE Levels SET comment1 ='%@',comment2 ='%@',comment3 ='%@',dateModified='%@' where formid='%@'",Ridename,Capacity,Inspectiondate,[mainDelegate Getcurrentdate],SelectedFormId ];
        
    }
    else
        Query=[NSString stringWithFormat:@"INSERT INTO Levels (comment1,comment2 ,comment3,formid,dateCreated,dateModified,usertype) VALUES('%@','%@','%@','%@','%@','%@','%@') ",Ridename,Capacity,Inspectiondate,SelectedFormId ,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
    
    BOOL Flag=[ObjdbInstance ExexuteOperation:Query];
    
    //    char *err;
    //    if (sqlite3_exec(ObjdbInstance.sDB, [Query UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    if (!Flag)
    {
        NSLog(@"Operation Fail");
    }
    else
    {
        NSLog(@"Operation successfully");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Data Saved Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    sqlite3_close(ObjdbInstance.sDB);
    
}



-(void)SaveFieldlbl//section 2
{
    NSMutableArray *detailarr=[[NSMutableArray alloc]init];
    
    for (UIView *view in Globalview.subviews) {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField *Txt=(UITextField*)view;
            if (Txt.tag%11==0) {
                [detailarr addObject:Txt.text];
            }

//            if (Txt.text.length<1) {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//                [alert show];
//                [alert release];
//                
//                return;
//            }

        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            UITextView *Txt=(UITextView*)view;
            if (Txt.tag%11==0) {
                [detailarr addObject:Txt.text];
            }
        }

    }
    
    if (detailarr.count<1) {
        return;
    }
    NSString *Query=@"";
    
    [ObjdbInstance openDB];
    BOOL Flag=NO;
    int visibility=0;
    
//    NSString *Str=[detailarr objectAtIndex:0];
//    if (Str.length<1) {
//        visibility=0;
//    }
//    else
        visibility=1;
    
    NSString *Query1=[NSString stringWithFormat:@"select * FROM FieldDetailtable where formid=%@ AND fieldno='%d' AND sectionid=%d",mainDelegate.formTid ,Fieldno,Selectedsectionid];
    BOOL ExistFlag=[ObjdbInstance isLevelPresentLocally:Query1];
    if (ExistFlag)
    {
        //Update
        Query=[NSString stringWithFormat:@"UPDATE FieldDetailtable SET fieldname ='%@',fieldtype ='%@',fieldsubtitle='%@',dateModified='%@',editable=%d,visible=%d,fielddescription='%@' where formid='%@' AND fieldno='%d' AND sectionid='%d'",[detailarr objectAtIndex:0],[detailarr objectAtIndex:2],[detailarr objectAtIndex:1],[mainDelegate Getcurrentdate],Editstatus,visibility,[detailarr objectAtIndex:3],mainDelegate.formTid ,Fieldno,Selectedsectionid];
        
    }
    else
        Query=[NSString stringWithFormat:@"INSERT INTO FieldDetailtable (fieldname,fieldtype ,formid,fieldno,sectionid,fieldsubtitle,fielddescription,editable,visible,dateCreated,dateModified,usertype) VALUES('%@','%@','%@',%d,%d,'%@','%@','%d','%d','%@','%@','%@') ",[detailarr objectAtIndex:0],[detailarr objectAtIndex:2],mainDelegate.formTid,Fieldno,Selectedsectionid,[detailarr objectAtIndex:1],[detailarr objectAtIndex:3],Editstatus,visibility,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
    
         Flag=[ObjdbInstance ExexuteOperation:Query];

    if (!Flag)
    {
        NSLog(@"Operation Fail");
    }
    else
    {
        NSLog(@"Operation successfully");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Data Saved Successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alert.tag=-1;
        [alert show];
    }
    sqlite3_close(ObjdbInstance.sDB);
    
}

#pragma mark:Getdetails
-(NSMutableArray*)Getslectedleveldetail
{
    [ObjdbInstance openDB];
    sqlite3_stmt *statement;
    sqlite3 *dbref=ObjdbInstance.sDB;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
    NSString *querySQL =@"";
    
    if (sqlite3_open(ObjdbInstance.dbpath, &dbref) == SQLITE_OK)
    {
        //select user id
               if ([SelectedTab isEqualToString:@"Identifier"])
               {
                   if ([mainDelegate.UserType isEqualToString:@"Liteuser"])
                   {
                       querySQL= [NSString stringWithFormat:@"select * FROM Levels where formid='%@' ",mainDelegate.formTid];
                   }
                   else
                   {
                       querySQL= [NSString stringWithFormat:@"select * FROM Levels where formid='%@' ",mainDelegate.formTid]; //order by id DESC limit 1
                   }
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                    const char* Id = (const char*)sqlite3_column_text(statement, 0);
                    NSString *name = Id== NULL ? @"" : [[NSString alloc] initWithUTF8String:Id];
                    [tempdict setObject:name forKey:@"formid"];
                    
                    const char* Lvl1 = (const char*)sqlite3_column_text(statement, 1);
                    NSString *level1 = Lvl1== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl1];
                    [tempdict setObject:level1 forKey:@"level1"];
                    
                    const char* Lvl2 = (const char*)sqlite3_column_text(statement, 2);
                    NSString *level2 = Lvl2== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl2];
                    [tempdict setObject:level2 forKey:@"level2"];
                    
                    const char* Lvl3 = (const char*)sqlite3_column_text(statement, 3);
                    NSString *level3 = Lvl3== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl3];
                    [tempdict setObject:level3 forKey:@"level3"];
                    
                    
                    [DetailArray1 addObject:tempdict];
                    tempdict=nil;
                }
                sqlite3_finalize(statement);
            }
            
       
        sqlite3_close(ObjdbInstance.sDB);
        
        return DetailArray1;
    }
        else
            if ([SelectedTab isEqualToString:@"Section"])
            {
                querySQL= [NSString stringWithFormat:@"select id,section_name FROM SectionTable where formid='%@'",mainDelegate.formTid ]; //order by id DESC limit 1
            }
        else
            if ([SelectedTab isEqualToString:@"Field"])
            {
                querySQL= [NSString stringWithFormat:@"select formid,fieldname,fieldsubtitle,fieldtype,editable,fielddescription FROM FieldDetailtable where formid='%@' AND sectionid=%d AND visible='1'",mainDelegate.formTid ,Selectedsectionid]; //order by id DESC limit 1
            }
        
                const char *query_stmt = [querySQL UTF8String];
                int i=0;
                if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {

                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        i++;
                        NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];

                        const char* Id = (const char*)sqlite3_column_text(statement, 0);
                        NSString *name = Id== NULL ? @"" : [[NSString alloc] initWithUTF8String:Id];
                        [tempdict setObject:name forKey:@"formid"];
                        
                        const char* Lvl1 = (const char*)sqlite3_column_text(statement, 1);
                        NSString *level1 = Lvl1== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl1];
                        NSString *key=[NSString stringWithFormat:@"level%d",i];
                        if ([SelectedTab isEqualToString:@"Field"])
                        {
                            [tempdict setObject:level1 forKey:@"level"];

                        }
                        else
                        [tempdict setObject:level1 forKey:key];
                        
                        const char* Lvl3 = (const char*)sqlite3_column_text(statement, 2);
                        NSString *level3 = Lvl3== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl3];
                        [tempdict setObject:level3 forKey:@"fieldsubtitle"];

                        const char* Lvl2 = (const char*)sqlite3_column_text(statement, 3);
                        NSString *level2 = Lvl2== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl2];
                        [tempdict setObject:level2 forKey:@"fieldtype"];
                        
                        const char* Lvl5 = (const char*)sqlite3_column_text(statement, 4);
                        NSString *level5 = Lvl5== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl5];
                        [tempdict setObject:level5 forKey:@"editable"];

                        const char* Lvl6 = (const char*)sqlite3_column_text(statement, 5);
                        NSString *level6 = Lvl6== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl6];
                        level6=[level6 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        [tempdict setObject:level6 forKey:@"description"];
                        
                        [DetailArray1 addObject:tempdict];
                        tempdict=nil;
                }
                   

                    sqlite3_finalize(statement);
                }
                
        sqlite3_close(ObjdbInstance.sDB);
    }
        return DetailArray1;
                
        
}

-(NSMutableArray*)getcommentlabel
{
    [ObjdbInstance openDB];

   NSString *querySQL= [NSString stringWithFormat:@"select fieldno,fieldname FROM FieldDetailtable where formid='%@' AND sectionid=%d",mainDelegate.formTid,Selectedsectionid]; //order by id DESC limit 1
    sqlite3_stmt *statement=nil;
   NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
    const char *query_stmt = [querySQL UTF8String];
    if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        int i=0;
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            i++;
            NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
            const char* Id = (const char*)sqlite3_column_text(statement, 0);
            NSString *name = Id== NULL ? @"" : [[NSString alloc] initWithUTF8String:Id];
            [tempdict setObject:name forKey:@"formid"];
            
            const char* Lvl1 = (const char*)sqlite3_column_text(statement, 1);
            NSString *level1 = Lvl1== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl1];
            NSString *str=[NSString stringWithFormat:@"level%d",i];
            [tempdict setObject:level1 forKey:str];
            
//            const char* Lvl2 = (const char*)sqlite3_column_text(statement, 2);
//            NSString *level2 = Lvl2== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl2];
//            [tempdict setObject:level2 forKey:@"level2"];
//            
//            const char* Lvl3 = (const char*)sqlite3_column_text(statement, 3);
//            NSString *level3 = Lvl3== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl3];
//            [tempdict setObject:level3 forKey:@"level3"];
          
            [DetailArray1 addObject:tempdict];
            tempdict=nil;
            
        }
       
        
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(ObjdbInstance.sDB);
    return DetailArray1;
    

}

#pragma mark:Formview

-(void)Formview
{

UILabel *Headlbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 230, 20)];
Headlbl1.backgroundColor=[UIColor clearColor];
Headlbl1.text=@"Ride Details";

    
    int n=30;
UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 60-n, 100, 20)];
lbl1.backgroundColor=[UIColor clearColor];
lbl1.text=@"Identifier1:";
lbl1.lineBreakMode=NSLineBreakByWordWrapping;
lbl1.numberOfLines=2;
    lbl1.font=[UIFont systemFontOfSize:13];
lbl1.textAlignment=NSTextAlignmentCenter;
[Globalview addSubview:lbl1];

UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(0, 110-n, 100, 20)];
lbl2.backgroundColor=[UIColor clearColor];
lbl2.text=@"Identifier2:";
lbl2.lineBreakMode=NSLineBreakByWordWrapping;
lbl2.numberOfLines=2;
    lbl2.font=[UIFont systemFontOfSize:13];
lbl2.textAlignment=NSTextAlignmentCenter;
[Globalview addSubview:lbl2];

UILabel *lbl3=[[UILabel alloc]initWithFrame:CGRectMake(0, 160-n, 100, 40)];
lbl3.backgroundColor=[UIColor clearColor];
lbl3.text=@"Identifier3:";
lbl3.lineBreakMode=NSLineBreakByWordWrapping;
lbl3.numberOfLines=2;
    lbl3.font=[UIFont systemFontOfSize:13];
lbl3.textAlignment=NSTextAlignmentCenter;
[Globalview addSubview:lbl3];

UITextField *lbl1val=[[UITextField alloc]initWithFrame:CGRectMake(100, 60-n, 200, 36)];
lbl1val.backgroundColor=[UIColor clearColor];
lbl1val.placeholder=@"Identifier 1";
lbl1val.delegate=self;
lbl1val.tag=1;
    lbl1val.font=[UIFont systemFontOfSize:13];
    lbl1val.background=[UIImage imageNamed:@"Textf1.png"];
    UILabel * leftViews = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftViews.backgroundColor = [UIColor clearColor];
    lbl1val.leftView = leftViews;
    lbl1val.leftViewMode = UITextFieldViewModeAlways;
lbl1val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
[Globalview addSubview:lbl1val];

//    [lbl1val release];

    UITextField *labl2val=[[UITextField alloc]initWithFrame:CGRectMake(100, 110-n, 200, 36)];
    labl2val.backgroundColor=[UIColor clearColor];
    labl2val.placeholder=@"Identifier 2";
    labl2val.delegate=self;
    labl2val.tag=2;
    labl2val.font=[UIFont systemFontOfSize:13];
    labl2val.background=[UIImage imageNamed:@"Textf1.png"];
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView1.backgroundColor = [UIColor clearColor];
    labl2val.leftView = leftView1;
    labl2val.leftViewMode = UITextFieldViewModeAlways;
labl2val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
[Globalview addSubview:labl2val];

//    [lbl2val release];

    UITextField *lbl3val=[[UITextField alloc]initWithFrame:CGRectMake(100, 160-n, 200, 36)];
    lbl3val.backgroundColor=[UIColor clearColor];
    lbl3val.placeholder=@"Identifier 3";
    lbl3val.delegate=self;
    lbl3val.tag=3;
    lbl3val.font=[UIFont systemFontOfSize:13];
    lbl3val.background=[UIImage imageNamed:@"Textf1.png"];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    lbl3val.leftView = leftView;
    lbl3val.leftViewMode = UITextFieldViewModeAlways;

    lbl3val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [Globalview addSubview:lbl3val];
    
  NSMutableArray *DetailArrays= [self Getslectedleveldetail];
    if (DetailArrays.count>0) {
        
        NSDictionary *tempdict=[DetailArrays objectAtIndex:0];
        lbl1val.text=tempdict[@"level1"];
        labl2val.text=tempdict[@"level2"];
        lbl3val.text=tempdict[@"level3"];
        
    }
}

-(void)GoToform:(int)Sender
{
    Selectedsectionid=Sender+1;//[Sender tag];
    
    
    [self Fielddenameview];
    
}


#pragma mark-sectionview
-(void)SectionView
{
    int n=30;
    UILabel *Headlbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 230, 20)];
    Headlbl1.backgroundColor=[UIColor clearColor];
    Headlbl1.text=@"Click to change your section labels";
    
    NSMutableArray *DetailArray1= [self Getslectedleveldetail];
//    if (DetailArray1.count<1) {
//        for (int i=0; i<[mainDelegate.NOofSections integerValue]; i++) {
//            NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
//            
////            NSString *name =@"" ;
////            NSString *key1=[NSString stringWithFormat:@"Section%d",i+1];
////            [tempdict setObject:@"" forKey:key1];
//            
//            NSString *key=[NSString stringWithFormat:@"level%d",i];
//            [tempdict setObject:@"" forKey:key];
//            [DetailArray1 addObject:tempdict];
//            tempdict=nil;
//        }
//        
//    }
    
    int sY=60;
    for (int i=0; i<[mainDelegate.NOofSections integerValue]; i++) {
        NSDictionary *tempdict=nil;
        
        if (DetailArray1.count>i) {
             tempdict=[DetailArray1 objectAtIndex:i];
        }

        UILabel *lbl3=[[UILabel alloc]initWithFrame:CGRectMake(0, sY-n, 100, 40)];
        lbl3.backgroundColor=[UIColor clearColor];
        NSString *strlbl=[NSString stringWithFormat:@"Section%d",i+1];
        lbl3.text=strlbl;
        lbl3.lineBreakMode=NSLineBreakByWordWrapping;
        lbl3.numberOfLines=2;
        lbl3.font=[UIFont systemFontOfSize:13];
        lbl3.textAlignment=NSTextAlignmentCenter;
        [Globalview addSubview:lbl3];
        
        UITextField *lbl1val=[[UITextField alloc]initWithFrame:CGRectMake(100, sY-n, 200, 36)];
        lbl1val.backgroundColor=[UIColor clearColor];
        lbl1val.placeholder=@"Label";
        lbl1val.delegate=self;
        lbl1val.tag=1;
        lbl1val.font=[UIFont systemFontOfSize:13];
        lbl1val.background=[UIImage imageNamed:@"Textf1.png"];
        UILabel * leftViews = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftViews.backgroundColor = [UIColor clearColor];
        lbl1val.leftView = leftViews;
        lbl1val.leftViewMode = UITextFieldViewModeAlways;
        lbl1val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        [Globalview addSubview:lbl1val];
        NSString *str=[NSString stringWithFormat:@"level%d",i+1];
        lbl1val.text=tempdict[str];
        sY+=50;
    }
    
    Globalview.contentSize=CGSizeMake(320, [mainDelegate.NOofSections integerValue]*80);
  
}

#pragma mark-Fieldsview

-(void)FieldsView
{
//    UILabel *Headlbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 230, 20)];
//    Headlbl1.backgroundColor=[UIColor clearColor];
//    Headlbl1.text=@"Form Fields";
    
    NSString *querySQL= [NSString stringWithFormat:@"select section_name FROM SectionTable where formid=%@ ",mainDelegate.formTid ]; //order by id DESC limit 1                                                      //AND hidden=1 condition removed by ajinkya

    SectionArray=[self Getslectedleveldetail1:querySQL];
    
    SectionTxtfield=[[UITextField alloc]initWithFrame:CGRectMake(30, 0, 260, 35)];
    SectionTxtfield.delegate=self;
    SectionTxtfield.tag=1002;
    SectionTxtfield.background=[UIImage imageNamed:@"selectform.png"];
    UILabel * leftViews = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftViews.backgroundColor = [UIColor clearColor];
    SectionTxtfield.leftView = leftViews;
    SectionTxtfield.leftViewMode = UITextFieldViewModeAlways;
    SectionTxtfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
//    UIImageView * Rightview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,17,17)];
//    Rightview.image=[UIImage imageNamed:@"arrow.png"];
//    SectionTxtfield.rightView = Rightview;
    SectionTxtfield.rightViewMode = UITextFieldViewModeAlways;
//    [Rightview release];
    SectionTxtfield.placeholder=@"Select Section";
    [Globalview addSubview:SectionTxtfield];
    
    Globalview.contentSize=CGSizeZero;
    [self textFieldDidBeginEditing:SectionTxtfield];
//    [self Fielddenameview];
}

-(void)Fielddenameview
{
    //clear old contents
    for (__strong UIView *view in Globalview.subviews) {
        if (view.tag!=1002 && view.tag!=1000) {
            
            [view removeFromSuperview];
            view=nil;
        }
    }

    
     DetailArray= [self Getslectedleveldetail];
    if (DetailArray.count<[mainDelegate.NOofFields integerValue]) {
        int diff=[mainDelegate.NOofFields integerValue]-[DetailArray count];
        for (int i=0; i<diff; i++) {
            NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
            NSString *str=[NSString stringWithFormat:@"level%d",i+1];
            NSString *str1=[NSString stringWithFormat:@"Field%d Title",i+1];
            
            [temp setValue:str1 forKey:str];
            
            [DetailArray addObject:temp];
        }
        
    }

    int Xln=20;
    int Y=45;
    for (int i=0; i<DetailArray.count; i++) {
        
        NSDictionary *tempdict=[DetailArray objectAtIndex:i];
        UIImageView *imagback=[[UIImageView alloc]initWithFrame:CGRectMake(Xln, Y, 280, 40)];
        imagback.userInteractionEnabled=YES;
        imagback.layer.cornerRadius=6.0;
        imagback.layer.borderWidth=1.0;
        imagback.layer.borderColor=[UIColor grayColor].CGColor;
        [Globalview addSubview:imagback];
        
        UILabel *Headlbl1=[[UILabel alloc]initWithFrame:CGRectMake(5,5, 200, 35)];
        Headlbl1.backgroundColor=[UIColor clearColor];
        Headlbl1.font=[UIFont systemFontOfSize:13];
        Headlbl1.lineBreakMode=NSLineBreakByWordWrapping;
        Headlbl1.numberOfLines=2;
        Headlbl1.text=tempdict[@"level"];
        [imagback addSubview:Headlbl1];
        
        UIButton *cancelbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelbtn.frame=CGRectMake(200, 5, 30, 30);
        [cancelbtn addTarget:self action:@selector(ClearFielddata:) forControlEvents:UIControlEventTouchUpInside];
        [cancelbtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
            [cancelbtn setTag:i];
        [imagback addSubview:cancelbtn];
        
        UIButton *Editbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        Editbtn.frame=CGRectMake(245, 5, 30, 30);
        [Editbtn addTarget:self action:@selector(Fielddetailview:) forControlEvents:UIControlEventTouchUpInside];
        [Editbtn setBackgroundImage:[UIImage imageNamed:@"edit1.png"] forState:UIControlStateNormal];
              [Editbtn setTag:i];
        [imagback addSubview:Editbtn];
        
        Y+=45;
        }
    CGFloat size=50*[mainDelegate.NOofFields integerValue];
    if (size<550) {
        if (IS_IPHONE_5) {
            size=550;

        }
        else
            size=450;
    }

    Globalview.contentSize=CGSizeMake(Globalview.frame.size.width, size);
}

-(void)ClearFielddata:(id)Sender
{
    Fieldno=[Sender tag]+1;
    [ObjdbInstance openDB];
    BOOL Flag=NO;
   NSString *Query=[NSString stringWithFormat:@"UPDATE FieldDetailtable SET fieldname =' ',fieldtype =' ',fieldsubtitle=' ',dateModified='%@',editable='' where formid='%@' AND fieldno='%d' AND sectionid='%d'",[mainDelegate Getcurrentdate],mainDelegate.formTid,Fieldno,Selectedsectionid];
    Flag=[ObjdbInstance ExexuteOperation:Query];
    
    if (!Flag) {
        
        NSLog(@"Operation Fail");
    }
    else
    {
        NSLog(@"cleared successfully");
    }
}

-(void)Editoption:(UIButton*)Sender
{
    if (![Sender isSelected]) {
        Editstatus=1;
//        [Sender setImage:[UIImage imageNamed:@"Checkbox.png"] forState:UIControlStateNormal];
        [Sender setSelected:YES];
    }
    else
    {
//        [Sender setImage:[UIImage imageNamed:@"Checkbox1.png"] forState:UIControlStateNormal];
        [Sender setSelected:NO];
        Editstatus=0;

    }
    
}

-(void)Fielddetailview:(id)Sender
{
    Fieldno=[Sender tag]+1;
    for (__strong UIView *view in Globalview.subviews) {
        if (view.tag!=1002 && view.tag!=1000) {
            
            [view removeFromSuperview];
            view=nil;
        }
    }
    
    NSArray *fielddescarray=[NSArray arrayWithObjects:@"Fieldname",@"Field Description",@"Field Type",@"Allow Edits?",@"Selectionvalues",nil];
  
    int Y=45;
    int Xln=20;
    NSDictionary *tempdict=nil;
    tempdict=[DetailArray objectAtIndex:[Sender tag]];
    
    //field name
        UILabel *Headlbl1=[[UILabel alloc]initWithFrame:CGRectMake(Xln, Y+5, 100, 20)];
        Headlbl1.backgroundColor=[UIColor clearColor];
        Headlbl1.font=[UIFont systemFontOfSize:11.0f];
        Headlbl1.text=[fielddescarray objectAtIndex:0];
        [Globalview addSubview:Headlbl1];
        
            UITextField *lbl1val=[[UITextField alloc]initWithFrame:CGRectMake(Xln+70, Y, 200, 30)];
            lbl1val.backgroundColor=[UIColor clearColor];
            lbl1val.delegate=self;
            lbl1val.tag=11;
            lbl1val.font=[UIFont systemFontOfSize:13];
            lbl1val.background=[UIImage imageNamed:@"Textf1.png"];
            UILabel * leftViews = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
            leftViews.backgroundColor = [UIColor clearColor];
            lbl1val.leftView = leftViews;
            lbl1val.leftViewMode = UITextFieldViewModeAlways;
            lbl1val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            [Globalview addSubview:lbl1val];
                    lbl1val.text=tempdict[@"level"];
        //field detail
        UILabel *Headlbl2=[[UILabel alloc]initWithFrame:CGRectMake(Xln, Y+40, 80, 30)];
        Headlbl2.backgroundColor=[UIColor clearColor];
        Headlbl2.font=[UIFont systemFontOfSize:11.0f];
        Headlbl2.text=[fielddescarray objectAtIndex:1];
        Headlbl2.lineBreakMode=NSLineBreakByWordWrapping;
        Headlbl2.numberOfLines=2;
        [Globalview addSubview:Headlbl2];
        
         lbl2val=[[UITextView alloc]initWithFrame:CGRectMake(Xln+70, Y+40, 200, 40)];
        lbl2val.backgroundColor=[UIColor clearColor];
        lbl2val.delegate=self;
        lbl2val.tag=22;
    lbl2val.font=[UIFont systemFontOfSize:13];
    lbl2val.layer.cornerRadius=5.0;
    lbl2val.layer.borderWidth=1.5;
    lbl2val.layer.borderColor=[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0].CGColor;
        lbl2val.contentInset=UIEdgeInsetsMake(2, 2, 2, 0);
        [Globalview addSubview:lbl2val];
        lbl2val.text=tempdict[@"fieldsubtitle"];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Resignallfields)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, doneButton, nil];
    [toolbar setItems:itemsArray];
    
    lbl2val.inputAccessoryView=toolbar;
    
        //field type
        UILabel *Headlbl3=[[UILabel alloc]initWithFrame:CGRectMake(Xln, Y+95, 100, 20)];
        Headlbl3.backgroundColor=[UIColor clearColor];
        Headlbl3.font=[UIFont systemFontOfSize:11.0f];
        Headlbl3.text=[fielddescarray objectAtIndex:2];
        [Globalview addSubview:Headlbl3];
        
        UITextField *lbl3val=[[UITextField alloc]initWithFrame:CGRectMake(Xln+70, Y+90, 200, 30)];
        lbl3val.backgroundColor=[UIColor clearColor];
        lbl3val.delegate=self;
        lbl3val.tag=33;
        lbl3val.font=[UIFont systemFontOfSize:13];
        lbl3val.background=[UIImage imageNamed:@"selectform.png"];
        UILabel * leftViews3 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftViews3.backgroundColor = [UIColor clearColor];
        lbl3val.leftView = leftViews3;
        lbl3val.leftViewMode = UITextFieldViewModeAlways;
//        UIImageView * Rightview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,15,15)];
//        Rightview.image=[UIImage imageNamed:@"arrow.png"];
//        lbl3val.rightView = Rightview;
//        lbl3val.rightViewMode = UITextFieldViewModeAlways;
//        [Rightview release];
        lbl3val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        [Globalview addSubview:lbl3val];
        lbl3val.text=tempdict[@"fieldtype"];
        //editing option
        UILabel *Headlbl4=[[UILabel alloc]initWithFrame:CGRectMake(Xln, Y+135, 100, 20)];
        Headlbl4.backgroundColor=[UIColor clearColor];
        Headlbl4.font=[UIFont systemFontOfSize:11.0f];
        Headlbl4.text=[fielddescarray objectAtIndex:3];
        [Globalview addSubview:Headlbl4];
        
            UIButton *PrevBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            PrevBtn.frame=CGRectMake(Xln+75, Y+130, 30, 30);
            [PrevBtn addTarget:self action:@selector(Editoption:) forControlEvents:UIControlEventTouchUpInside];
        [PrevBtn setImage:[UIImage imageNamed:@"Checkbox1.png"] forState:UIControlStateSelected];
        [PrevBtn setImage:[UIImage imageNamed:@"Checkbox.png"] forState:UIControlStateNormal];

            if ([tempdict[@"editable"] isEqualToString:@"1"]) {
                PrevBtn.selected=YES;
            }
            else
            {
                PrevBtn.selected=NO;
            }
                [PrevBtn setTag:1];
            [Globalview addSubview:PrevBtn];
            
    //field detail
     Headlbl5=[[UILabel alloc]initWithFrame:CGRectMake(Xln, Y+180, 80, 30)];
    Headlbl5.backgroundColor=[UIColor clearColor];
    Headlbl5.text=@"Description";
    Headlbl5.font=[UIFont systemFontOfSize:11.0f];
    Headlbl5.text=[fielddescarray objectAtIndex:1];
    Headlbl5.lineBreakMode=NSLineBreakByWordWrapping;
    Headlbl5.numberOfLines=2;
    Headlbl5.hidden=YES;
    [Globalview addSubview:Headlbl5];
    
     lbl5val=[[UITextField alloc]initWithFrame:CGRectMake(Xln+70, Y+175, 200, 40)];
    lbl5val.backgroundColor=[UIColor clearColor];
    lbl5val.delegate=self;
    lbl5val.tag=11;
    lbl5val.placeholder=@"Yes/NO/NA..";
    lbl5val.font=[UIFont systemFontOfSize:13];
    lbl5val.background=[UIImage imageNamed:@"Textf1.png"];
    UILabel * leftViews5 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftViews5.backgroundColor = [UIColor clearColor];
    lbl5val.leftView = leftViews5;
    lbl5val.leftViewMode = UITextFieldViewModeAlways;
    lbl5val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [Globalview addSubview:lbl5val];
    lbl5val.hidden=YES;
    lbl5val.text=tempdict[@"description"];

    if ([tempdict[@"fieldtype"] isEqualToString:@"Dropdown(S)"] || [tempdict[@"fieldtype"] isEqualToString:@"Dropdown(M)"] )
    {
        lbl5val.hidden=NO;
    }
    
    CGFloat size=70*[mainDelegate.NOofFields integerValue];
    if (size<550) {
        if (!IS_IPHONE_5) {
            size=400;
        }
        else
        size=500;
        
    }
    if (IS_IPHONE_5) {
        size-=100;
    }
    
    Globalview.contentSize=CGSizeMake(Globalview.frame.size.width,size );
    
    if (Fieldnamesarray!=nil) {
        Fieldnamesarray=nil;
    }
    
    Fieldnamesarray= [[NSMutableArray alloc]initWithObjects:@"Numeric",@"Text",@"Date",@"Dropdown(S)",@"Dropdown(M)", nil];
   
}

-(NSMutableArray*)Getslectedleveldetail1:(NSString*)Query
{
    [ObjdbInstance openDB];
    sqlite3_stmt *statement;
    sqlite3 *dbref=ObjdbInstance.sDB;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
    
    if (sqlite3_open(ObjdbInstance.dbpath, &dbref) == SQLITE_OK)
    {
        //select user id
        NSString *querySQL =Query;
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                const char* Id = (const char*)sqlite3_column_text(statement, 0);
                NSString *name = Id== NULL ? @"" : [[NSString alloc] initWithUTF8String:Id];
                [DetailArray1 addObject:name];
                
                //                const char* Lvl1 = (const char*)sqlite3_column_text(statement, 1);
                //                NSString *level1 = Lvl1== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl1];
                //                [DetailArray1 addObject:level1];
                //
                //                const char* Lvl2 = (const char*)sqlite3_column_text(statement, 2);
                //                NSString *level2 = Lvl2== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl2];
                //                [DetailArray1 addObject:level2];
            }
            sqlite3_finalize(statement);
        }
        
    }
    sqlite3_close(ObjdbInstance.sDB);
    
    return DetailArray1;
    
}

#pragma mark-Scrollview delegate
-(void)ClickNavigation:(id)Sender
{
    if ([Sender tag]==1)
    {
        if (y>=0) {
            x=0;
            
            [InspectionScroll setContentOffset:CGPointMake(y ,0) animated:YES];
            y-=InspectionScroll.frame.size.width;
            
        }
    }
    else
    {
        if (x<InspectionScroll.contentSize.width-InspectionScroll.frame.size.width) {
            y=InspectionScroll.contentSize.width-(InspectionScroll.frame.size.width*2);
            [InspectionScroll setContentOffset:CGPointMake(InspectionScroll.frame.size.width+x ,0) animated:YES];
            x+=InspectionScroll.frame.size.width;
            
        }
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView)
    {
        if (scrollView.tag==19) {
            return;
        }
    }
    [self Resignontap:nil];
//        CGFloat pageWidth = InspectionScroll.frame.size.width;
//      int  page = floor((InspectionScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    
//    if (scrollView.tag==2) {
//        Nolbl.text=[NSString stringWithFormat:@"%d/3", page+1];
//    }
//    else
//        Nolbl.text=[NSString stringWithFormat:@"%d/%d", page+1,QuestionDetailArr.count];
    
        //setbtn color
}



#pragma mark-Section3 view
-(void)Editsection3label
{
   //    page=0;
    x=0;
    y=0;
    
    int n=0;
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 53-n, 320, 1)];
    [Globalview addSubview:image];
    [image setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
    
    
    InspectionScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 55-n, 300, 140)];
    InspectionScroll.pagingEnabled=YES;
    InspectionScroll.delegate=self;
    InspectionScroll.tag=2;
    InspectionScroll.userInteractionEnabled=YES;
    InspectionScroll.backgroundColor=[UIColor clearColor];
    [Globalview addSubview:InspectionScroll];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 185-n, 320, 1)];
    [image1 setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
    [Globalview addSubview:image1];
    
    NSMutableArray *Detatiarr=[self getcommentlabel];
    
    for (int i=0; i<3; i++)
    {
        CGRect frame;
        frame.origin.x = InspectionScroll.frame.size.width * i;
        frame.origin.y = 10;
        frame.size = InspectionScroll.frame.size;
        
        UITextField *lbl1val=[[UITextField alloc]initWithFrame:CGRectMake(frame.origin.x+20, 50, 270, 40)];
        lbl1val.background=[UIImage imageNamed:@"Textf1.png"];
        lbl1val.placeholder=@"Title";
        lbl1val.delegate=self;
        lbl1val.tag=1;
        if (Detatiarr.count>0) {
            lbl1val.text=[[Detatiarr objectAtIndex:0] valueForKey:[NSString stringWithFormat:@"level%d",i+1]];

        }
        else
        lbl1val.text=@"comments";
        lbl1val.tag=i+1;
        UILabel * leftViews = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,36)];
        leftViews.backgroundColor = [UIColor clearColor];
        lbl1val.leftView = leftViews;
        lbl1val.font=[UIFont systemFontOfSize:13];
        lbl1val.leftViewMode = UITextFieldViewModeAlways;
        lbl1val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        lbl1val.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [InspectionScroll addSubview:lbl1val];
    }
    
    UIButton *PrevBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    PrevBtn.frame=CGRectMake(5, 190-n, 30, 30);
    [PrevBtn addTarget:self action:@selector(ClickNavigation:) forControlEvents:UIControlEventTouchUpInside];
    [PrevBtn setBackgroundImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
    //    [PrevBtn setBackgroundImage:[UIImage imageNamed:@"Down_P.png"] forState:UIControlStateSelected];
    //    [PrevBtn setTitle:@"back1.png" forState:UIControlStateNormal];
    [PrevBtn setTag:1];
    [Globalview addSubview:PrevBtn];
    
    Nolbl=[[UILabel alloc]initWithFrame:CGRectMake(120,200-n, 80, 20)];
    Nolbl.backgroundColor=[UIColor clearColor];
    Nolbl.font=[UIFont systemFontOfSize:13];
    Nolbl.textAlignment=NSTextAlignmentCenter;
    [Globalview addSubview:Nolbl];
    //    [Headlbl release];
    Nolbl.text=[NSString stringWithFormat:@"1/3"];
    UIButton *NetBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    NetBtn.frame=CGRectMake(280, 190-n, 30, 30);
    [NetBtn addTarget:self action:@selector(ClickNavigation:) forControlEvents:UIControlEventTouchUpInside];
    [NetBtn setBackgroundImage:[UIImage imageNamed:@"next1.png"] forState:UIControlStateNormal];
    //    [NetBtn setBackgroundImage:[UIImage imageNamed:@"Down_P.png"] forState:UIControlStateSelected];
    //    [NetBtn setTitle:@"NEXT" forState:UIControlStateNormal];
    [NetBtn setTag:2];
    [Globalview addSubview:NetBtn];

    InspectionScroll.contentSize = CGSizeMake(InspectionScroll.frame.size.width * 3, InspectionScroll.frame.size.height);
}


#pragma Mark:Database methods

-(void)Getfieldlabels
{
    
   Fieldnamesarray= [ObjdbInstance GettableDetails:mainDelegate.Selectedtable];
    Table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 240, 240) style:UITableViewStylePlain];
    Table.delegate=self;
    Table.dataSource=self;
    [Globalview addSubview: Table];
//    UITapGestureRecognizer *tap=[[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TabletouchesBegan)] autorelease];
//    tap.numberOfTapsRequired=1;
//    tap.cancelsTouchesInView = NO;
//
//    [Table addGestureRecognizer:tap];

}

-(NSMutableArray*)GetFielnames
{
    return  Fieldnamesarray;

}



#pragma mark:Tableview delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (Sectionflag) {
        return SectionArray.count;
    }
    else
    return Fieldnamesarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell!=nil)
    {
        cell=nil;
    }
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        if (Sectionflag) {
            cell.textLabel.text=[SectionArray objectAtIndex:indexPath.row];
        }
        else
        cell.textLabel.text=[Fieldnamesarray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:11];
        
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (Sectionflag)
        {
            SectionTxtfield.text=[SectionArray objectAtIndex:indexPath.row];
            [self GoToform:indexPath.row];
        }
        else
        {
            Currentfield.text=[Fieldnamesarray objectAtIndex:indexPath.row];
            
            if ([[Fieldnamesarray objectAtIndex:indexPath.row] isEqualToString:@"Dropdown(S)"] || [[Fieldnamesarray objectAtIndex:indexPath.row] isEqualToString:@"Dropdown(M)"] || [[Fieldnamesarray objectAtIndex:indexPath.row] isEqualToString:@"Dropdown"]) {
                Headlbl5.hidden = NO;
                lbl5val.hidden = NO;
            }
            else
            {
                Headlbl5.hidden = YES;
                lbl5val.hidden = YES;

            }
        }

    Table.hidden=YES;
}


#pragma mark:Textfield delgate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [Globalview setContentOffset:CGPointMake(0, textField.frame.origin.y)];
     [UIView commitAnimations];
    
    if (Table!=nil) {
        Table=nil;
    }
    Table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 240, 240) style:UITableViewStylePlain];
    Table.delegate=self;
    Table.dataSource=self;
    Table.tag=19;
    Table.backgroundColor=[UIColor clearColor];
    [Globalview addSubview: Table];
    Table.hidden=YES;

    
    if (textField==SectionTxtfield) {
        [textField resignFirstResponder];
        Sectionflag=1;
        Table.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+35, textField.frame.size.width, 170);
        Table.hidden=NO;
        [Table reloadData];
    }
    
    if (textField.tag==33){
        Sectionflag=0;
        
        [textField resignFirstResponder];
        Table.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width, 130);
        Table.hidden=NO;
        [Table reloadData];
    }
    

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    Currentfield=textField;
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{    [Globalview setContentOffset:CGPointMake(0, 0)];

    [textField resignFirstResponder];
    return YES;
}

-(void)TabletouchesBegan
{
    if (Globalview) {
        [Globalview setContentOffset:CGPointMake(0, 0)];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    if (Table) {
        Table.hidden=YES;
    }

    [Globalview setContentOffset:CGPointMake(0, 0)];

    for (UITextField *textfield in Globalview.subviews) {
        if ([textfield isKindOfClass:[UITextField class]]) {

            if ([textfield isFirstResponder])
            {
                [textfield resignFirstResponder];
            }
        }
    }
    
}

-(void)Resignallfields
{
    [lbl2val resignFirstResponder];
//    [self.view endEditing:YES];
//    for (UITextView *textfield in Globalview.subviews) {
//        if ([textfield isKindOfClass:[UITextView class]]) {
////            if ([textfield isFirstResponder])
////            {
//                [textfield resignFirstResponder];
////            }
//        }
//    }

}

-(void)Resignontap:(UITapGestureRecognizer*)seneder
{
//    NSLog(@"%@",seneder.view);

   
    if (Table) {
            Table.hidden=YES;
        [Table removeFromSuperview];
        Table=nil;
     }
    
    }
#pragma mark:textview delegate
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self Resignallfields];
    [textView resignFirstResponder];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
