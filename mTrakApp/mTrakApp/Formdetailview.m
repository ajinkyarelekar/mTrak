//
//  Formdetailview.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "Formdetailview.h"

@interface Formdetailview ()

@end

@implementation Formdetailview
@synthesize MediaName,Headscroll,Globarray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //refresh media section contents
    if ([Selectedtab isEqualToString:@"Media"]) {
        [self MediaView];
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *backview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background.png"]];
    backview.frame=CGRectMake(0, 0, 320, self.view.frame.size.height);
    [self.view addSubview:backview];
    
    if (Adjust_Height ==20) {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];

    }
    
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    ObjdbInstance=[DatabseInstance sharedInstance];

    UIImageView *Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    Navbar.userInteractionEnabled=YES;
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=@"Form Details";
    Title.font=[UIFont boldSystemFontOfSize:18];
    Title.backgroundColor=[UIColor clearColor];
    Title.textAlignment=NSTextAlignmentCenter;
    Title.textColor=[UIColor whiteColor];
    [Navbar addSubview:Title];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+42, 320, self.view.frame.size.height-Adjust_Height)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,7,50,30);
    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:button];
    //top menu
    
    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:LogoutBtn];
    
    MediaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    MediaBtn.frame = CGRectMake(236,0,42,44);
    MediaBtn.tag=2;
        [MediaBtn setBackgroundImage:[UIImage imageNamed:@"media1.png"] forState:UIControlStateNormal];
    [MediaBtn addTarget:self action:@selector(Mediaclicked:) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:MediaBtn];
    
    NSString *querySQL= [NSString stringWithFormat:@"select section_name FROM SectionTable where formid=%@",mainDelegate.formTid]; //order by id DESC limit 1

    NSMutableArray *namearr= [self Getslectedleveldetail1:querySQL];
    
    //Left menu
    Headscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 55)];
    [view addSubview:Headscroll];
    float x=0;
    for (int i=0; i<namearr.count; i++)
    {
        UIButton *RideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            RideBtn.frame = CGRectMake(x,0,108,109/2);
        
        RideBtn.tag=i+1;
            NSString *str= [NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]];
            [RideBtn setTitle:str forState:UIControlStateNormal];
        
        RideBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        RideBtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        RideBtn.titleLabel.numberOfLines=0;
        [RideBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [RideBtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
        [RideBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
        
        [RideBtn addTarget:self action:@selector(Leftclicked:) forControlEvents:UIControlEventTouchUpInside];
        [Headscroll addSubview:RideBtn];
        x=x+108;
        
        Headscroll.contentSize=CGSizeMake(x+1, 55);

        if (i==0) {
            Prevbtn=RideBtn;
            [RideBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
        }
    }

    //need to save all section if not like 18 sept.sanjay
    
    for (int i=0; i<namearr.count; i++) {
        NSMutableArray *array=[self getSelectedLevelInitialfields :i+1];

        [self saveInitialdetails:i+1 values:array];

    }
    
    if (namearr.count>3)
    {
        UIButton *btnleft=[UIButton buttonWithType:UIButtonTypeCustom];
        btnleft.frame=CGRectMake(0, 0, 30, 50);
        [btnleft setBackgroundImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
        [btnleft addTarget:self action:@selector(scrolled:) forControlEvents:UIControlEventTouchUpInside];
        btnleft.tag=1;
        [view addSubview:btnleft];
        
        UIButton *btnright=[UIButton buttonWithType:UIButtonTypeCustom];
        btnright.frame=CGRectMake(290, 0, 30, 50);
        [btnright setBackgroundImage:[UIImage imageNamed:@"nextarrow.png"] forState:UIControlStateNormal];
        [btnright addTarget:self action:@selector(scrolled:) forControlEvents:UIControlEventTouchUpInside];
        btnright.tag=2;
        [view addSubview:btnright];
        
    }
   
    
    UIImageView *bacimgtitle=[[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 560/2, 71/2)];
    [view addSubview:bacimgtitle];
    bacimgtitle.image=[UIImage imageNamed:@"outline.png"];
    
    UIButton *Titlbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    Titlbtn1.frame = CGRectMake(20,60,75,30);
    Titlbtn1.tag=1;
    Titlbtn1.titleLabel.font=[UIFont systemFontOfSize:13];
    [Titlbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Titlbtn1.titleLabel.numberOfLines=2;
    Titlbtn1.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [Titlbtn1 addTarget:self action:@selector(GoToform:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Titlbtn1];
    
    UILabel *lbl11=[[UILabel alloc]initWithFrame:CGRectMake(90, 60, 10, 30)];
    lbl11.text=@"->";
    lbl11.font=[UIFont systemFontOfSize:13];
    lbl11.backgroundColor=[UIColor clearColor];
    [view addSubview:lbl11];
    
    UIButton *Titlbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    Titlbtn2.frame = CGRectMake(110,60,75,30);
    Titlbtn2.tag=2;
    Titlbtn2.titleLabel.font=[UIFont systemFontOfSize:13];
    Titlbtn2.titleLabel.numberOfLines=2;
    Titlbtn2.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [Titlbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Titlbtn2 addTarget:self action:@selector(GoToform:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Titlbtn2];
    
    UILabel *lbl22=[[UILabel alloc]initWithFrame:CGRectMake(185, 60, 15, 30)];
    lbl22.text=@"->";
    lbl22.font=[UIFont systemFontOfSize:13];
    lbl22.backgroundColor=[UIColor clearColor];
    [view addSubview:lbl22];
    
    UIButton *Titlbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    Titlbtn3.frame = CGRectMake(200,60,75,30);
    Titlbtn3.tag=3;
    Titlbtn3.titleLabel.font=[UIFont systemFontOfSize:13];
    Titlbtn3.backgroundColor=[UIColor clearColor];
    Titlbtn3.titleLabel.numberOfLines=2;
    Titlbtn3.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [Titlbtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Titlbtn3 addTarget:self action:@selector(GoToform:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Titlbtn3];
    
    if (mainDelegate.SelectedRidearray!=nil) {
        
        for (int i=0; i<mainDelegate.SelectedRidearray.count; i++) {
            NSString *Str=[mainDelegate.SelectedRidearray objectAtIndex:i];
            if (i==0) {
                [Titlbtn1 setTitle:Str forState:UIControlStateNormal];
            }
            else
                if (i==1) {
                    [Titlbtn2 setTitle:Str forState:UIControlStateNormal];
                }
                else
                    if (i==2)  {
                        [Titlbtn3 setTitle:Str forState:UIControlStateNormal];
                    }
        }
    }

    
    Globalview=[[UIView alloc]initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height-(Adjust_Height+200))];
    Globalview.backgroundColor=[UIColor clearColor];
    [view addSubview:Globalview];

    UIButton *SaveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SaveBtn.frame = CGRectMake(15,Globalview.frame.size.height-40,135,38);
    [SaveBtn setBackgroundImage:[UIImage imageNamed:@"Save.png"] forState:UIControlStateNormal];
    SaveBtn.tag=1000;
    [SaveBtn addTarget:self action:@selector(Save) forControlEvents:UIControlEventTouchUpInside];
    [Globalview addSubview:SaveBtn];
    
    UIButton *CancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CancelBtn.frame = CGRectMake(165,Globalview.frame.size.height-40,135,38);
    [CancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    CancelBtn.tag=1000;
    [CancelBtn addTarget:self action:@selector(cancelFields) forControlEvents:UIControlEventTouchUpInside];
    [Globalview addSubview:CancelBtn];

    Selectedtab=@"Rides";
    self.MediaName=@"";
    mediaType=@"";
    SelectedSection=@"Rides";
    Selectedsectionid=1;
    [self Formview:nil];

}

-(void)scrolled:(id)sender
{
    if ([sender tag]==1) {
        Headscroll.contentOffset=CGPointMake(0, 0);

    }
    else
    {
        Headscroll.contentOffset=CGPointMake(Headscroll.contentSize.width-320, 0);
    }
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
}

-(void)Logout
{
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [mainDelegate Showrootview];

}

-(void)cancelFields
{
    if ([Selectedtab isEqualToString:@"Inspection"] ) {
        if (SetstatusBtn!=nil)
        [SetstatusBtn setBackgroundImage:[UIImage imageNamed:@"gray.png"] forState:UIControlStateNormal];
    }
    
    for (UIView *views in Globalview.subviews) {
        if ([views isKindOfClass:[UIScrollView class]]) {
            for (UIView *view in views.subviews)
            {
                if ([view isKindOfClass:[UITextField class]]) {
                    UITextField *Txt=(UITextField*)view;
                   Txt.text=@"";
                    [Txt resignFirstResponder];
                }
            }
        }
    }
}

-(void)Leftclicked:(id)Sender
{
    [self SaveDetails];

    [MediaBtn setBackgroundImage:[UIImage imageNamed:@"media1.png"] forState:UIControlStateNormal];

    Selectedsectionid=[Sender tag];

    if (Prevbtn) {
        [Prevbtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];

    }
  
    UIButton *Btn=(UIButton*)Sender;
    if (Prevbtn.tag==[Sender tag]) {
        [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];

        return;
    }
    Prevbtn=Btn;
//autosave the previous section details

        for (__strong UIView *view in Globalview.subviews) {
            if (view.tag!=1000) {
                
                [view removeFromSuperview];
                view=nil;
            }
            else
            {
                view.hidden=NO;
            }
        }

        Selectedtab=@"Rides";
        SelectedSection=@"Rides";
    firstSaveflag=1;
    [self Formview:(id)Sender];
    [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
}

-(void)Mediaclicked:(id)Sender
{
    for (__strong UIView *view in Globalview.subviews) {
        if (view.tag!=1000) {
            [view removeFromSuperview];
            view=nil;
        }
      else
      {
          view.hidden=YES;
      }
        
    }

    if ([Selectedtab isEqualToString:@"Media"])
    {
        [MediaBtn setBackgroundImage:[UIImage imageNamed:@"media1.png"] forState:UIControlStateNormal];

        Selectedtab=@"Fields";
        if ([SelectedSection isEqualToString:@"Rides"]) {
            [self Formview:nil];
        
        }
        
    }
    else
    {
        [MediaBtn setBackgroundImage:[UIImage imageNamed:@"deta.png"] forState:UIControlStateNormal];

        Selectedtab=@"Media";
        [self MediaView];
    }
}

-(void)saveInitialdetails :(int)sectionid values:(NSMutableArray*)valarray
{
    NSString *Querydelete=[NSString stringWithFormat:@"select * from DetailTable where formid='%@' and level1id='%@' and level2id='%@' and level3id='%@' AND sectionid=%d",mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],sectionid];
    
    BOOL Updatflag=[ObjdbInstance isLevelPresentLocally:Querydelete];
    BOOL result=NO;
    for (int i=0; i<valarray.count ; i++) {
        
        NSString *Query=@"";
        if (Updatflag) {
        }
        else
            Query=[NSString stringWithFormat:@"INSERT INTO DetailTable (fieldId,fieldval,formid,level1id,level2id,level3id,sectionid,dateCreated,dateModified,usertype) VALUES('%d','','%@','%@','%@','%@','%d','%@','%@','%@') ",i+1,mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],sectionid,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
        
        result=[ObjdbInstance  ExexuteOperation:Query];
        
        NSLog(@"%d",result);
    }

}

#pragma mark:Save data
-(void)Save
{
    firstSaveflag=0;
        [self SaveDetails];
}

-(void)SaveDetails//data capture
{

    NSMutableArray *valarray=[[NSMutableArray alloc]init];
    
            for (UIView *views in Globalview.subviews)
            {
                if ([views isKindOfClass:[UIScrollView class]])
                {
                    for (UIView *view in views.subviews)
                    {
                        if ([view isKindOfClass:[UITextField class]])
                        {
                            UITextField *Txt=(UITextField*)view;
                            [valarray addObject:Txt.text];
                        }
                    }
                }
            }
 
    int cnt=0;
    for (NSString *str in valarray) {
        if (str.length>=1) {
            cnt++;
        }
    }

    if (!firstSaveflag) {
        if (cnt<1 ) {
            return;
        }
    }
    
    
//    int Recordscount=0;
//    [ObjSharedDb openDB];
//    
//    sqlite3 *Objsql=ObjSharedDb.sDB;
//    if (sqlite3_open(ObjSharedDb.dbpath, &Objsql) == SQLITE_OK)
//    {
//        NSString *querySQL = [NSString stringWithFormat:@"SELECT level3id from DetailTable where formid='%@' group by  level3id",mainDelegate.formid];
//            
//        sqlite3_stmt *statement = nil;
//        const char *query_stmt = [querySQL UTF8String];
//    
//        if (sqlite3_prepare_v2(ObjSharedDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
//        {
//            while (sqlite3_step(statement) == SQLITE_ROW)
//            {
//                Recordscount++;
//            }
//            
//            sqlite3_finalize(statement);
//        }
//    }
//    sqlite3_close(ObjSharedDb.sDB);
//
//    
//    //if ([mainDelegate.UserType isEqualToString:@"Prouser"])
//    //{
//        if (Recordscount==[mainDelegate.NOofFields intValue])
//        {
////            mainDelegate.Recordflag=1;
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"You have reached the max limit of %@ records per Form.",mainDelegate.NOofFields] message:@"To capture more records, you can :\n-  Clear Form data using the Delate Menu." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//            return;
//        }
//   // }

   
    
    NSString *Querydelete=[NSString stringWithFormat:@"select * from DetailTable where formid='%@' and level1id='%@' and level2id='%@' and level3id='%@' AND sectionid=%d",mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],Selectedsectionid];

  BOOL Updatflag= [ObjdbInstance isLevelPresentLocally:Querydelete];
    BOOL result=NO;
    for (int i=0; i<valarray.count ; i++)
    {
    
        NSString *Query=@"";
        if (Updatflag)
        {
            Query=[NSString stringWithFormat:@"UPDATE  DetailTable SET fieldval='%@',dateModified='%@' WHERE formid='%@' AND level1id='%@' AND level2id='%@' AND level3id='%@' AND  fieldId=%d AND sectionid=%d",[valarray objectAtIndex:i],[mainDelegate Getcurrentdate],mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],i+1,Selectedsectionid];

        }
    else
        Query=[NSString stringWithFormat:@"INSERT INTO DetailTable (fieldId,fieldval,formid,level1id,level2id,level3id,sectionid,dateCreated,dateModified,usertype) VALUES('%d','%@','%@','%@','%@','%@','%d','%@','%@','%@') ",i+1,[valarray objectAtIndex:i],mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],Selectedsectionid,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
    
     result=[ObjdbInstance  ExexuteOperation:Query];
    }
    
    if (result)
    {
        if (!firstSaveflag)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Data Saved Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }
    else
        NSLog(@"%c",result);

}



-(void)Savemedia
{
    int Tablename=0;
       //check if present aleready update else insert
    if ([SelectedSection isEqualToString:@"Rides"])
    {
        Tablename=1;//@"DetailTable";
    }
    else
        if ([SelectedSection isEqualToString:@"Inspection"])
        {
            Tablename=2;//@"Datacapture";

        }
    else
        if ([SelectedSection isEqualToString:@"Feedback"])
        {
            Tablename=3;//@"Feedback";

        }
    
    BOOL result=NO;

        NSString *Query=[NSString stringWithFormat:@"INSERT INTO mediaTable (medianame ,mediatype,formid,level1id,level2id,level3id,sectionid,dateCreated,dateModified,usertype) VALUES('%@','%@','%@','%@','%@','%@','%d','%@','%@','%@') ",MediaName,mediaType,mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],Selectedsectionid,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
        
        result=[ObjdbInstance ExexuteOperation:Query];

    
      
    if (result)
    {
        NSLog(@"%c",result);
    }
    else
        NSLog(@"%c",result);

}

-(BOOL)isLevelPresentLocally :(NSString *)Query
{
    [ObjdbInstance openDB];
    BOOL status=NO;
    
    
    const char *databasepath=ObjdbInstance.dbpath;
    
    sqlite3_stmt *statement;
    
    sqlite3 *dbref=ObjdbInstance.sDB;
    if(sqlite3_open(databasepath, &dbref)== SQLITE_OK)
    {
        
        const char *select_stmt=[Query UTF8String];
        
        if(sqlite3_prepare_v2(dbref,select_stmt, -1, &statement, NULL)== SQLITE_OK)
            
        {
            if (sqlite3_step(statement)== SQLITE_ROW)
                
            {
                
                status=YES;
                
            }
        }
        else  //prepare can not be executed
        {                     //some error
            
            NSLog(@"prepare can not be executed");
            
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"failed to open db");
    }
    sqlite3_close(dbref);
    
    
    return status;
    
}

#pragma mark:Getdetails
-(NSMutableArray*)Getslectedleveldetail
{
    [ObjdbInstance openDB];
    sqlite3_stmt *statement;
    sqlite3 *dbref=ObjdbInstance.sDB;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];

    if (sqlite3_open(ObjdbInstance.dbpath, &dbref) == SQLITE_OK)
    {
        //select user id
        NSString *querySQL=[NSString stringWithFormat:@"select fieldId,fieldval from DetailTable dt  where dt.formid='%@' and dt.level1id='%@' AND dt.level2id='%@' AND dt.level3id='%@' AND dt.sectionid='%d' order by fieldid",mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],Selectedsectionid];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                const char* name1 = (const char*)sqlite3_column_text(statement, 0);
                NSString *name = name1== NULL ? @"" : [[NSString alloc] initWithUTF8String:name1];
                [tempdict setObject:name forKey:@"id"];
                
                const char* cp1 = (const char*)sqlite3_column_text(statement, 1);
                NSString *capacity = cp1== NULL ? @"" : [[NSString alloc] initWithUTF8String:cp1];
                [tempdict setObject:capacity forKey:@"value"];
                

                [DetailArray1 addObject:tempdict];
                tempdict=nil;
            }
            sqlite3_finalize(statement);
        }
        
    }
    
    return DetailArray1;

}

-(NSMutableArray*)getSelectedLevelfields
{
    [ObjdbInstance openDB];
    sqlite3 *dbref=ObjdbInstance.sDB;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];

    sqlite3_stmt *statement1=nil;
    
    if (sqlite3_open(ObjdbInstance.dbpath, &dbref) == SQLITE_OK)
    {
        //select user id
        NSString *querySQL = [NSString stringWithFormat:@"select fieldtype,fieldname,fieldno,fieldsubtitle,fielddescription,editable from FieldDetailtable  where formid='%@' AND sectionid='%d' AND visible=1 order by fieldno",mainDelegate.formTid ,Selectedsectionid]; //order by id DESC limit 1
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement1) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* dtype = (const char*)sqlite3_column_text(statement1, 0);
                NSString *datatype = dtype== NULL ? @"" : [[NSString alloc] initWithUTF8String:dtype];
                [tempdict setObject:datatype forKey:@"type"];
                
                const char* fname = (const char*)sqlite3_column_text(statement1, 1);
                NSString *fieldname = fname== NULL ? @"" : [[NSString alloc] initWithUTF8String:fname];
                [tempdict setObject:fieldname forKey:@"fieldname"];
                
                const char* fno = (const char*)sqlite3_column_text(statement1, 2);
                NSString *forder = fno== NULL ? @"" : [[NSString alloc] initWithUTF8String:fno];
                [tempdict setObject:forder forKey:@"fieldno"];
                
                const char* ftno = (const char*)sqlite3_column_text(statement1, 3);
                NSString *ftorder = ftno== NULL ? @"" : [[NSString alloc] initWithUTF8String:ftno];
                [tempdict setObject:ftorder forKey:@"fieldsubtitle"];
                
                const char* fno1 = (const char*)sqlite3_column_text(statement1, 4);
                NSString *forder1 = fno1== NULL ? @"" : [[NSString alloc] initWithUTF8String:fno1];
                [tempdict setObject:forder1 forKey:@"fielddescription"];
                
                const char* fno2 = (const char*)sqlite3_column_text(statement1, 5);
                NSString *forder2 = fno2== NULL ? @"" : [[NSString alloc] initWithUTF8String:fno2];
                [tempdict setObject:forder2 forKey:@"editable"];
                [DetailArray1 addObject:tempdict];
                
                tempdict=nil;
            }
            sqlite3_finalize(statement1);
        }
        
    }
    sqlite3_close(ObjdbInstance.sDB);
    
    return DetailArray1;
}

-(NSMutableArray*)getSelectedLevelInitialfields:(int)section
{
    [ObjdbInstance openDB];
    sqlite3 *dbref=ObjdbInstance.sDB;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement1=nil;
    
    if (sqlite3_open(ObjdbInstance.dbpath, &dbref) == SQLITE_OK)
    {
        //select user id
        NSString *querySQL = [NSString stringWithFormat:@"select fieldtype,fieldname,fieldno,fieldsubtitle,fielddescription,editable from FieldDetailtable  where formid='%@' AND sectionid='%d' AND visible=1 order by fieldno",mainDelegate.formTid ,section]; //order by id DESC limit 1
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement1) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* dtype = (const char*)sqlite3_column_text(statement1, 0);
                NSString *datatype = dtype== NULL ? @"" : [[NSString alloc] initWithUTF8String:dtype];
                [tempdict setObject:datatype forKey:@"type"];
                
                const char* fname = (const char*)sqlite3_column_text(statement1, 1);
                NSString *fieldname = fname== NULL ? @"" : [[NSString alloc] initWithUTF8String:fname];
                [tempdict setObject:fieldname forKey:@"fieldname"];
                
                const char* fno = (const char*)sqlite3_column_text(statement1, 2);
                NSString *forder = fno== NULL ? @"" : [[NSString alloc] initWithUTF8String:fno];
                [tempdict setObject:forder forKey:@"fieldno"];
                
                const char* ftno = (const char*)sqlite3_column_text(statement1, 3);
                NSString *ftorder = ftno== NULL ? @"" : [[NSString alloc] initWithUTF8String:ftno];
                [tempdict setObject:ftorder forKey:@"fieldsubtitle"];
                
                const char* fno1 = (const char*)sqlite3_column_text(statement1, 4);
                NSString *forder1 = fno1== NULL ? @"" : [[NSString alloc] initWithUTF8String:fno1];
                [tempdict setObject:forder1 forKey:@"fielddescription"];
                
                const char* fno2 = (const char*)sqlite3_column_text(statement1, 5);
                NSString *forder2 = fno2== NULL ? @"" : [[NSString alloc] initWithUTF8String:fno2];
                [tempdict setObject:forder2 forKey:@"editable"];
                [DetailArray1 addObject:tempdict];
                
                tempdict=nil;
            }
            sqlite3_finalize(statement1);
        }
        
    }
    sqlite3_close(ObjdbInstance.sDB);
    
    return DetailArray1;
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
            }
            sqlite3_finalize(statement);
        }
        
    }
    sqlite3_close(ObjdbInstance.sDB);
    
    return DetailArray1;
    
}



#pragma mark Media view
-(void)MediaView
{
       UILabel *Headlbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 20)];
    Headlbl1.backgroundColor=[UIColor clearColor];
    Headlbl1.text=@"Attach media here";
    Headlbl1.textAlignment=NSTextAlignmentCenter;
    Headlbl1.font=[UIFont systemFontOfSize:16];
    [Globalview addSubview:Headlbl1];
    
    NSArray *namearr=[NSArray arrayWithObjects:@"Pictures",@"Audio Files",@"Video Files", nil];

    int y=55;
    for (int i=0; i<3; i++)
    {
        UIButton *checkboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        checkboxBtn.frame = CGRectMake(0,y,320,32);
        checkboxBtn.tag=i+1;
        [checkboxBtn setBackgroundImage:[UIImage imageNamed:@"Media.png"] forState:UIControlStateNormal];
        checkboxBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [checkboxBtn addTarget:self action:@selector(CheckBoxclik1:) forControlEvents:UIControlEventTouchUpInside];
        [Globalview addSubview:checkboxBtn];

        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10,5, 70, 25)];
        lbl1.textAlignment=NSTextAlignmentLeft;
        lbl1.lineBreakMode=NSLineBreakByCharWrapping;
        lbl1.numberOfLines=1;
        lbl1.text=[namearr objectAtIndex:i];
        lbl1.backgroundColor=[UIColor clearColor];
        lbl1.font=[UIFont systemFontOfSize:17];
        [checkboxBtn addSubview:lbl1];

        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(-90,5, 50, 20)];
        lbl.textAlignment=NSTextAlignmentLeft;
        lbl.lineBreakMode=NSLineBreakByCharWrapping;
        lbl.numberOfLines=1;
        lbl.tag=50;
        lbl.backgroundColor=[UIColor clearColor];
        lbl.font=[UIFont systemFontOfSize:16];
       
        int X=0;
        if (i==0)
        {
             X= [self GetcountOfmedia:@"image"];
        }
        else
            if (i==1)
            {
                X= [self GetcountOfmedia:@"audio"];

            }
        else
        {
            X= [self GetcountOfmedia:@"video"];

        }
        
        lbl.text=[NSString stringWithFormat:@"(%d)",X];

        
        UIButton *checkboxBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        checkboxBtn1.frame = CGRectMake(250,0,70,32);
        checkboxBtn1.tag=i+1;
        checkboxBtn1.titleLabel.font=[UIFont systemFontOfSize:15];
        [checkboxBtn1 addTarget:self action:@selector(CheckBoxclik:) forControlEvents:UIControlEventTouchUpInside];
        checkboxBtn1.titleLabel.textColor=[UIColor blackColor];
        [checkboxBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [checkboxBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [checkboxBtn addSubview:checkboxBtn1];
        [checkboxBtn1 addSubview:lbl];
        y=y+45;
    }
    
       
}

-(void)GoToform:(id)Sender
{
    if ([Sender tag]==1) {
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            
                    if ([viewController isKindOfClass:[ZoneSelection class]] ) {
                
                               ZoneSelection *groupViewController = (ZoneSelection*)viewController;
                [self.navigationController popToViewController:groupViewController animated:YES];
            }
        }
    }
    else
        if ([Sender tag]==2) {
            for (UIViewController* viewController in self.navigationController.viewControllers) {
                
                if ([viewController isKindOfClass:[Level2rides class]] ) {
                    
                    ZoneSelection *groupViewController = (ZoneSelection*)viewController;
                    [self.navigationController popToViewController:groupViewController animated:YES];
                }
            }

        }
    else
    {
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            
            if ([viewController isKindOfClass:[Level3ViewController class]] ) {
                
                ZoneSelection *groupViewController = (ZoneSelection*)viewController;
                [self.navigationController popToViewController:groupViewController animated:YES];
            }
        }

    }
    
}

-(int)GetcountOfmedia:(NSString*)Mediatype
{
    int n=0;
    int Tabalename=0;
    if ([SelectedSection isEqualToString:@"Rides"]) {
        Tabalename=1;//@"DetailTable";
    }
    else
    if ([SelectedSection isEqualToString:@"Inspection"]) {
        Tabalename=2;//@"Datacapture";
      
    }
    else
        if ([SelectedSection isEqualToString:@"Feedback"]) {
            Tabalename=3;//@"Feedback";
        }
    
    sqlite3_stmt    *statement;
	
	[ObjdbInstance openDB];
    sqlite3 *sDB=ObjdbInstance.sDB;
    
	if (sqlite3_open(ObjdbInstance.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"select count(medianame) from MediaTable where mediatype='%@' AND formid='%@' AND level1id='%@' AND level2id='%@' AND level3id='%@' AND sectionid='%d'",Mediatype,mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],Selectedsectionid];
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *DetailLabelStr = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                n=[DetailLabelStr integerValue];
			
            }
			sqlite3_finalize(statement);
		}
		sqlite3_close(sDB);
	}
    
    
    return n;

}
#pragma mark:formview

-(void)Formview:(id)Sender
{
    DetailArray= [self getSelectedLevelfields];
    
    NSMutableArray *Detailarray1=[self Getslectedleveldetail];
    
    UIScrollView *Scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 320, 190)];
    Scroll.scrollEnabled=YES;
    Scroll.userInteractionEnabled=YES;
    Scroll.tag=100;
    Scroll.delegate=self;
    Scroll.backgroundColor=[UIColor clearColor];
    Scroll.contentSize=CGSizeMake(320, 300);
    [Globalview addSubview:Scroll];
    if (IS_IPHONE_5) {
        Scroll.frame=CGRectMake(0, 20, 320, 265);
    }
    UILabel *Headlbl1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 20)];
    Headlbl1.backgroundColor=[UIColor clearColor];
    Headlbl1.font=[UIFont systemFontOfSize:16];
    Headlbl1.lineBreakMode=NSLineBreakByWordWrapping;
    Headlbl1.textAlignment=NSTextAlignmentCenter;
    Headlbl1.numberOfLines=1;
    Headlbl1.text=@"Enter Details";
    
    Headlbl1.textAlignment=NSTextAlignmentCenter;
    [Globalview addSubview:Headlbl1];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 19, 320, 1)];
    image.image=[UIImage imageNamed:@"line.png"];
    [Globalview addSubview:image];
    
    if (datepicker) {
        datepicker=nil;
    }
    datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    datepicker.datePickerMode=UIDatePickerModeDate;
    datepicker.date=[NSDate date];
    UIToolbar *pickertool=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [pickertool setBarStyle:UIBarStyleBlackOpaque];
    [pickertool sizeToFit];
    
    NSMutableArray *btnarray=[[NSMutableArray alloc]init];
    
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    [btnarray addObject:cancel];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [btnarray addObject:space];
    
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    [btnarray addObject:done];
    
    [pickertool setItems:btnarray];

    int Y=-10;
    int Contentsize=0;
    for (int i=0; i<[DetailArray count]; i++)
    {
        NSDictionary *tempdict=nil;
        NSDictionary *tempdict1=nil;
        if (Detailarray1.count>i) {
            tempdict=[Detailarray1 objectAtIndex:i];

        }
            tempdict1=[DetailArray objectAtIndex:i];

        NSString *str1=tempdict1[@"fieldsubtitle"];

        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10, Y+10, 300, 30)];
        if (str1.length>1) {
            lbl1.frame=CGRectMake(10, Y+10, 300, 30);
        }
        lbl1.backgroundColor=[UIColor clearColor];
            NSString *str=[tempdict1 valueForKey:@"fieldname"];
        if (str!=nil) {
            lbl1.text=str;
        }
        else
            lbl1.text=[NSString stringWithFormat:@"Field%d name",i+1 ];
        
        lbl1.font=[UIFont boldSystemFontOfSize:15];
        lbl1.lineBreakMode=NSLineBreakByWordWrapping;
        lbl1.numberOfLines=2;
        lbl1.textAlignment=NSTextAlignmentLeft;
        [Scroll addSubview:lbl1];
        
        if (str1.length>1) {
            UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(10, Y+35, 300, 30)];
            lbl2.backgroundColor=[UIColor clearColor];
            lbl2.text=str1;
            lbl2.font=[UIFont systemFontOfSize:14];
            lbl2.lineBreakMode=NSLineBreakByWordWrapping;
            lbl2.numberOfLines=2;
            lbl2.textAlignment=NSTextAlignmentLeft;
            [Scroll addSubview:lbl2];

            Y+=30;
        }
     
        UITextField *lbl1val=[[UITextField alloc]initWithFrame:CGRectMake(10, Y+41, 300, 40)];
        lbl1val.background=[UIImage imageNamed:@"Textf1.png"];
        lbl1val.delegate=self;
        lbl1val.tag=i+1;
        UILabel * leftViews = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftViews.backgroundColor = [UIColor clearColor];
        lbl1val.leftView = leftViews;
        lbl1val.font=[UIFont systemFontOfSize:16];
        lbl1val.leftViewMode = UITextFieldViewModeAlways;
        lbl1val.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        lbl1val.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [Scroll addSubview:lbl1val];
        lbl1val.text=tempdict[@"value"];
        
        if ( [[tempdict1 valueForKey:@"editable"] isEqualToString:@"0"]) {
            lbl1val.userInteractionEnabled=NO;
        }
        
            UIImageView *imgline=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.png"]];
            imgline.frame=CGRectMake(0, Y+86, 320, 1);
            [Scroll addSubview:imgline];

             //check for field data types
        if ([[[DetailArray objectAtIndex:i] valueForKey:@"type"]isEqualToString:@"Date"]) {
            
            lbl1val.inputView=datepicker;
            lbl1val.inputAccessoryView=pickertool;
            
        }
        else if ([[[DetailArray objectAtIndex:i] valueForKey:@"type"]isEqualToString:@"Numeric"])
        {
            lbl1val.keyboardType=UIKeyboardTypeDecimalPad;
            
        }
        else if ([[[DetailArray objectAtIndex:i] valueForKey:@"type"]isEqualToString:@"Dropdown(S)"] || [[[DetailArray objectAtIndex:i] valueForKey:@"type"]isEqualToString:@"Dropdown(M)"] || [[[DetailArray objectAtIndex:i] valueForKey:@"type"]isEqualToString:@"MstSelect"])
        {
            
            lbl1val.background=[UIImage imageNamed:@"selectform.png"];
        }

        Y+=77;
         if (str1.length>1)
        Contentsize+=135;
        else
            Contentsize+=105;

    }

    if (Contentsize<250) {
        Contentsize=255;
    }
    else if (Contentsize>405)
    {
        if (!IS_IPHONE_5) {
            Contentsize=Contentsize-50;

        }
    }
    Scroll.contentSize=CGSizeMake(Scroll.frame.size.width,Contentsize);
    //save empty fields for export csv
    
    firstSaveflag=1;

    if (DetailArray.count<1) {
        Headlbl1.frame= CGRectMake(10, 20, 300, 40);
        Headlbl1.backgroundColor=[UIColor clearColor];
        Headlbl1.textAlignment=NSTextAlignmentCenter;
        Headlbl1.lineBreakMode=NSLineBreakByWordWrapping;
        Headlbl1.numberOfLines=0;
        Headlbl1.text=@"No Fields configured plese configure fields in form setting";
    }
    
}

-(NSMutableArray*)GettfieldDetail:(NSString*)querySQL
{
    sqlite3_stmt *statement=nil;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
    const char *query_stmt = [querySQL UTF8String];
    int i=0;
    [ObjdbInstance openDB];
    if (sqlite3_prepare_v2(ObjdbInstance.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            i++;
            NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
            
            const char* Lvl1 = (const char*)sqlite3_column_text(statement, 0);
            NSString *level1 = Lvl1== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl1];
            NSString *key=[NSString stringWithFormat:@"level%d",i];
            [tempdict setObject:level1 forKey:key];
            
            const char* Lvl2 = (const char*)sqlite3_column_text(statement, 1);
            NSString *level2 = Lvl2== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl2];
            [tempdict setObject:level2 forKey:@"fieldtype"];
            [DetailArray1 addObject:tempdict];
            tempdict=nil;
        }
       
        
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(ObjdbInstance.sDB);
    return DetailArray1;

}


#pragma mark:media methods
-(void)CheckBoxclik1:(id)Sender
{
    
    int Tabalename=0;//@"";
    if ([SelectedSection isEqualToString:@"Rides"]) {
        Tabalename=1;//@"DetailTable";
    }
    else
        if ([SelectedSection isEqualToString:@"Inspection"]) {
            Tabalename=2;//@"Datacapture";
            
        }
        else
            if ([SelectedSection isEqualToString:@"Feedback"]) {
                Tabalename=3;//@"Feedback";
            }

  
    MediaviewController *Objmedia=[[MediaviewController alloc]init];
    Objmedia.Selectedtable=[NSString stringWithFormat:@"%d",Selectedsectionid];

    int n=[Sender tag];
    if (n==1)
    {
        Objmedia.Mediatype=@"image";

    }
    else
        if (n==2)
        {
            Objmedia.Mediatype=@"audio";

        }
    else
    {
        Objmedia.Mediatype=@"video";

    }

    [self.navigationController pushViewController:Objmedia animated:YES];
    
}

-(void)CheckBoxclik:(id)Sender
{
    NSString *maxval=@"";
    int Max=0;
    UIButton *btn=(UIButton*)Sender;
    NSLog(@"%@",btn.subviews);
    
    for (UIView *view in btn.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lbl=(UILabel*)view;
            if (lbl.tag==50) {
                maxval=lbl.text;
                maxval=[maxval stringByReplacingOccurrencesOfString:@"(" withString:@""];
                maxval=[maxval stringByReplacingOccurrencesOfString:@")" withString:@""];
                Max=[maxval integerValue];
            }
        }
    }
    
    int count=0;
    if (btn.tag==1) {
        count=[mainDelegate.NOofimages integerValue];
    }
    else
        if (btn.tag==2) {
            count=[mainDelegate.NOofAudio integerValue];
        }
        else
            if (btn.tag==3) {
                count=[mainDelegate.NOofVideo integerValue];
            }
    if (count<=Max) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Not Available" message:@"You cross the max  limit." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }

    
    int n= [Sender tag];
    if (n==1)
    {
        [self Selectiamge];
        
    }
    else
        if (n==2)
        {
            [self SelectAudio];
            
        }
        else
        {
            [self SelectVideo];
            
        }
    
}

#pragma mark textfield delegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Textview Delegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor=[UIColor darkTextColor];

    CGRect frame=self.view.frame;
    frame.origin.y-=80;
    self.view.frame=frame;
    if (Adjust_Height==20) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES
                                                withAnimation:UIStatusBarAnimationFade];

    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect frame=self.view.frame;
    frame.origin.y+=80;
    self.view.frame=frame;
    if (Adjust_Height==20) {

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    [textView resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (Currenttxtfield) {
        [Currenttxtfield resignFirstResponder];
    }
    
    for (UIView *view in InspectionScroll.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            if ([view isFirstResponder]) {
                [view resignFirstResponder];
            }

        }
    }
    
         for (UITextField *textfield in Globalview.subviews) {
            if ([textfield isFirstResponder])
            {
                [textfield resignFirstResponder];
            }
         }
        
    [super touchesBegan:touches withEvent:event];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView)
    {
        if (scrollView.tag==100)
        {
            for (__strong UITableView *table in Globalview.subviews) {
                if ([table isKindOfClass:[UITableView class]]) {
                    [table removeFromSuperview];
                    table=nil;
                }
            }
            if (Tbaleview) {
                [Tbaleview removeFromSuperview];
                Tbaleview=nil;
            }
        }

    }
}

#pragma mark textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (Tbaleview)
    {
        [Tbaleview removeFromSuperview];
        Tbaleview=nil;
    }
//    if (Currenttxtfield) {
//        if ([Currenttxtfield isFirstResponder]) {[Currenttxtfield resignFirstResponder];
//        }
//    }
    
    Currenttxtfield=textField;
    if (DetailArray.count>0)
    {
               NSString *str=[[DetailArray objectAtIndex:textField.tag-1] valueForKey:@"fielddescription"];

        if (str.length<1) {
            str=@"No values to select";
        }
        
        if ([[[DetailArray objectAtIndex:textField.tag-1] valueForKey:@"type"]isEqualToString:@"Dropdown(S)"] || [[[DetailArray objectAtIndex:textField.tag-1] valueForKey:@"type"]isEqualToString:@"Dropdown(M)"] || [[[DetailArray objectAtIndex:textField.tag-1] valueForKey:@"type"]isEqualToString:@"MstSelect"])
            {
                mtselectflag=1;
            
                if ([[[DetailArray objectAtIndex:textField.tag-1] valueForKey:@"type"]isEqualToString:@"Dropdown(S)"])
                    mtselectflag=0;
                
                
                 if (str.length>1)
                 {
                   
                    Tbaleview=[[UITableView alloc]init];
                    Tbaleview.delegate=self;
                    Tbaleview.dataSource=self;
                     
                     UIScrollView *scroll=nil;
                     for (id view in Globalview.subviews) {
                         if ([view isKindOfClass:[UIScrollView class]]) {
                             scroll=view;
                         }
                     }
                     if (scroll!=nil) {
                         [scroll addSubview:Tbaleview];
                     }
                     else
                    [Globalview addSubview:Tbaleview];

                    Tbaleview.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width, 100);
                    if (Globarray) {
                        Globarray=nil;
                    }
                    
                    self.Globarray=[NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"/"]];

                        [Tbaleview reloadData];
                     
                     
                 }
                return NO;
            }
       else
            mtselectflag=0;
      
    }
      return YES;
}

-(void)cancel
{
    [Currenttxtfield resignFirstResponder];
    
    
}

-(void)done
{
    [Currenttxtfield resignFirstResponder];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"dd-MMM-YYYY"];
    NSString *date=[formater stringFromDate:datepicker.date];
    Currenttxtfield.text=date;
    NSString *Datestr=Currenttxtfield.text;
    NSLog(@"selected date is:%@",Datestr);
}

-(void)popViewback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark imagepicker delegate
-(void)Selectiamge
{
    UIActionSheet *Sheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from gallery",@"Use Camera", nil];
    Sheet.tag=3;
       [Sheet showInView:mainDelegate.Rootnav.view];
    
}

#pragma mark Audio delegate

-(void)SelectAudio
{
    UIActionSheet *Sheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from gallery",@"Record Audio", nil];
    Sheet.tag=2;
    [Sheet showInView: mainDelegate.Rootnav.view];
}

- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
    
    if (mediaItemCollection.count == 1) {
        NSArray *items = mediaItemCollection.items;
        MPMediaItem *mediaItem =  [items objectAtIndex:0];
        [self mediaItemToData:mediaItem];
    }
    NSLog(@"You picked : %@",mediaItemCollection);
}

//record audio
-(void)startPushed
{
    View=[[UIView alloc]initWithFrame:CGRectMake(115, 100, 100, 100)];
    View.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [Globalview addSubview:View];
    
    Timelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 20)];
    Timelable.backgroundColor=[UIColor clearColor];
    Timelable.text=@"";
    Timelable.textColor=[UIColor whiteColor];
    Timelable.textAlignment=NSTextAlignmentCenter;
    [View addSubview:Timelable];
    
       UIButton *Stop=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    Stop.frame=CGRectMake(10, 50, 80, 40);
    [Stop addTarget:self action:@selector(playbackPushed) forControlEvents:UIControlEventTouchUpInside];
    [Stop setTitle:@"Stop" forState:UIControlStateNormal];
    [Stop setTag:3];
    [View addSubview:Stop];
    
    NSMutableDictionary *rs = [[NSMutableDictionary alloc] init];
    [rs setValue:[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    [rs setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [rs setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
    
    UIActivityIndicatorView *Actvity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    Actvity.frame=CGRectMake(40, 30, 20, 20);
    [View addSubview:Actvity];
    [Actvity startAnimating];

    if (recorder) {
        recorder =nil;
    }
    NSError *error=nil;
    recorder = [[AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:rs error:&error];
    [recorder setDelegate:self];
    [recorder prepareToRecord];
    [recorder record];
    Recordtimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];  //this is nstimer to initiate update method
    

    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docDir = [docPath objectAtIndex:0];
    NSString *fullPath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", recordedTmpFile]];
    NSLog(@"%@", fullPath);
    
}

- (void)updateSlider {
    // Update the slider about the music time
    if([recorder isRecording])
    {
        
        float minutes = floor(recorder.currentTime/60);
        float seconds = recorder.currentTime - (minutes * 60);
        
        NSString *time = [[NSString alloc]
                          initWithFormat:@"%0.0f.%0.0f",
                          minutes, seconds];
        Timelable.text = time;
        if (minutes==1.0) {
            [self playbackPushed];
        }

    }
}

-(void)playbackPushed
{
    [Globalview setUserInteractionEnabled:YES];
    [View removeFromSuperview];
    View=nil;
    NSError *error=nil;
    NSLog(@"Play Path:%@", recordedTmpFile);
    
    NSData *audioData=[NSData dataWithContentsOfURL:recordedTmpFile];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *n=[NSString stringWithFormat:@"%d",arc4random()];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.caf",n] ];
    
    NSLog(@"Play Path:%@", recordedTmpFile);
    [audioData writeToFile:savedImagePath atomically:NO];
    
    mediaType=@"audio";
    self.MediaName=[NSString stringWithFormat:@"%@",n];
    [recorder stop];

    [Recordtimer invalidate];
    Recordtimer=nil;
    
    [self Savemedia ];
    [self MediaView];

}

//select from music library
-(void)mediaItemToData:(MPMediaItem*)mediaItem
{
    // Implement in your project the media item picker
    
    MPMediaItem *curItem = mediaItem;
    
    NSURL *url = [curItem valueForProperty: MPMediaItemPropertyAssetURL];
    
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL: url options:nil];
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset
                                                                      presetName: AVAssetExportPresetPassthrough];
    
    NSArray *supportedTypeArray=exporter.supportedFileTypes;
    for (NSString *str in supportedTypeArray)
        NSLog(@"%@",str);
    
    exporter.outputFileType = AVFileTypeAppleM4A;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *exportFile = [documentsDirectory stringByAppendingPathComponent:
                            @"/exported.mp3"];
    
    NSURL *exportURL = [NSURL fileURLWithPath:exportFile] ;
    exporter.outputURL = exportURL;
    
    
    NSData *data = [NSData dataWithContentsOfFile: [documentsDirectory
                                                    stringByAppendingPathComponent: @"/exported.mp3"]];
    
    
    [exporter exportAsynchronouslyWithCompletionHandler:
     ^{
         NSLog(@"%d export status",exporter.status);
         if (exporter.status==AVAssetExportSessionStatusCompleted)
         {
             NSLog(@"successfull");
         }
         NSData *data = [NSData dataWithContentsOfFile: [documentsDirectory
                                                         stringByAppendingPathComponent: @"/exported.mp3"]];
         
         NSURL *audioUrl = exportURL;
         NSLog(@"Audio Url=%@",audioUrl);
         NSData  *audioData = [NSData dataWithContentsOfURL:audioUrl];
         NSLog(@"%@",audioData);
         //save in doc dirctory
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
         NSString *documentsDirectory = paths[0];
         NSString *n=[NSString stringWithFormat:@"%d",arc4random()];
         NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.mp3",n] ];
                  
         [audioData writeToFile:savedImagePath atomically:NO];
         mediaType=@"audio";
         self.MediaName=[NSString stringWithFormat:@"%@",n];
         
         [self Savemedia];
         [self MediaView];

         // Do with data something
         
     }];
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark Video delegate

-(void)SelectVideo
{
    UIActionSheet *Sheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from gallery",@"Record video", nil];
    Sheet.tag=1;
    [Sheet showInView:mainDelegate.Rootnav.view];
}

#pragma mark Action sheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1)
    {
        
        if (buttonIndex==0)
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
            imagePicker.videoMaximumDuration=20.0f;
            imagePicker.delegate = self;
            [mainDelegate.Rootnav presentViewController:imagePicker animated:YES completion:nil];
            
        }
        else
            if (buttonIndex==1)
            {
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
                    imagePicker.videoMaximumDuration=20.0f;

                    imagePicker.delegate = self;
                    [mainDelegate.Rootnav presentViewController:imagePicker animated:YES completion:nil];
                    
                }
                else
                {
                    NSLog(@"Not available");
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Not Available" message:@"Camera not supported." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                }
                
            }
    }
    else
        if (actionSheet.tag==2)
        {
            if (buttonIndex==0) {
                MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
                mediaPicker.delegate = self;
                mediaPicker.allowsPickingMultipleItems = NO;
                @try
                {
                    [mediaPicker loadView]; // Will throw an exception in iOS simulator
                    [mainDelegate.Rootnav presentViewController:mediaPicker animated:YES completion:nil];
                }
                @catch (NSException *exception)
                {
                    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Oops!",@"Error title")
                                                message:NSLocalizedString(@"The music library is not available.",@"Error message when MPMediaPickerController fails to load")
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil] show];
                }
                
                
            }
            else
                if (buttonIndex==1)
                {
                    [self startPushed];
                }
            
        }
        else
            if (actionSheet.tag==3)
            {
                if (buttonIndex==0) {
                    
                    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
                    {
                        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                        pickerController.delegate = self;
                        
                        [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                        pickerController.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                        pickerController.allowsEditing=TRUE;
                        [mainDelegate.Rootnav presentViewController:pickerController animated:YES completion:nil];

                    }
                    else
                    {
                        NSLog(@"Photos not available");
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Not Available" message:@"Photo functionalaity not supported." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        [alert show];
                    }
                }
                else
                    if (buttonIndex==1)
                    {
                        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                        {
                            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                            pickerController.delegate = self;
                            
                            [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                            pickerController.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
                            pickerController.allowsEditing=TRUE;
                            [mainDelegate.Rootnav presentViewController:pickerController animated:YES completion:nil];
                        }
                        else
                        {
                            NSLog(@"Camera not available");
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Not Available" message:@"Photo functionalaity not supported." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                            [alert show];
                        }
                        
                    }
            }
    
    
}

#pragma mark: Imagepicker delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    if (videoURL==nil)
    {
        UIImage *image=[info valueForKey:UIImagePickerControllerOriginalImage];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
       NSString *n=[NSString stringWithFormat:@"%d",arc4random()];

        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",n] ];
        
        UIImage*imageToSave=image;
        NSData *imageData = UIImageJPEGRepresentation(imageToSave, 0.1f);
        
        [imageData writeToFile:savedImagePath atomically:NO];

        NSLog(@"Picked image %@",image);
        mediaType=@"image";
        self.MediaName=[NSString stringWithFormat:@"%@",n];
    }
    else
    {
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *n=[NSString stringWithFormat:@"%d",arc4random()];

        NSString *tempPath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.mp4",n]];
        
        BOOL success = [videoData writeToFile:tempPath atomically:NO];
        if (success) {
            mediaType=@"video";
            self.MediaName=[NSString stringWithFormat:@"%@",n];
            NSLog(@"Saved");
        }
        else
        {
            NSLog(@"Error");
            
        }
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self Savemedia ];
    [self MediaView];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark:tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.Globarray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    cell=nil;
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSString *str1=[self.Globarray objectAtIndex:indexPath.row];
    cell.textLabel.text=str1;
    NSString *tempstr=Currenttxtfield.text;
    
    if (![tempstr isEqualToString:@""] && tempstr.length>1) {
        if ([tempstr rangeOfString:str1 ].location!=NSNotFound)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=[self.Globarray objectAtIndex:indexPath.row];
    if ([str isEqualToString:@"No values to select"]) {
        [Tbaleview removeFromSuperview];
        tableView=nil;

        return;
    }
    
    if (mtselectflag) {
        NSString *str= Currenttxtfield.text;
        NSArray *arr= [str componentsSeparatedByString:@"," ];
        NSMutableArray *arr1=[NSMutableArray arrayWithArray:arr];
        if (![arr containsObject:[self.Globarray objectAtIndex:indexPath.row]])
        {
            if (str.length<1) {
                Currenttxtfield.text=[NSString stringWithFormat:@"%@",[self.Globarray objectAtIndex:indexPath.row]];
            }
            else
            Currenttxtfield.text=[NSString stringWithFormat:@"%@,%@",str,[self.Globarray objectAtIndex:indexPath.row]];
        }
        else
        {
            [arr1 removeObject:[self.Globarray objectAtIndex:indexPath.row] ];
            Currenttxtfield.text=@"";
            for (int i=0; i<arr1.count; i++) {
                NSString *str=Currenttxtfield.text;
                if (str.length<1) {
                    Currenttxtfield.text=[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]];
                }
                else
                Currenttxtfield.text=[NSString stringWithFormat:@"%@,%@",str,[arr1 objectAtIndex:i]];

            }
        }
    }
    else
    Currenttxtfield.text=[self.Globarray objectAtIndex:indexPath.row];
    
    [Tbaleview removeFromSuperview];
    tableView=nil;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
    {
        
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        
    }
    else
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}

-(void)dealloc
{
          DetailArray=nil;
    Currenttxtfield=nil;
    datepicker=nil;
    Tbaleview=nil;
    recorder=nil;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"form detail memory warning");
    // Dispose of any resources that can be recreated.
}

@end
