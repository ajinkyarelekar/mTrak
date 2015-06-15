//
//  Manageconnection.m
//  trackperformance
//
//  Created by Nanostuffs's Macbook on 17/03/14.
//  Copyright (c) 2014 Trupti. All rights reserved.
//

#import "Manageconnection.h"
#import "DatabseInstance.h"
@interface Manageconnection ()
{
    DatabseInstance *ObjSharedDb;
}
@end

@implementation Manageconnection

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
	// Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    UIImageView *img;
    img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    img.image=[UIImage imageNamed:@"Background.png"];
    [self.view addSubview:img];
    if (Adjust_Height ==20) {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];
        
    }
    
    self.view.userInteractionEnabled=YES;

    UIImageView *Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    Navbar.userInteractionEnabled=YES;
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=@"Sync Options";
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.backgroundColor=[UIColor clearColor];
    Title.textColor=[UIColor whiteColor];
    Title.textAlignment=NSTextAlignmentCenter;
    [Navbar addSubview:Title];
    
    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:LogoutBtn];
    
    
    // menu options
     Csvbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    Csvbtn.frame = CGRectMake(0,Adjust_Height+43,215/2,109/2);
    Csvbtn.tag=1;
    Csvbtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [Csvbtn setTitle:@"Export Csv" forState:UIControlStateNormal];
    Csvbtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    Csvbtn.titleLabel.numberOfLines=1;
    [Csvbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [Csvbtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
    [Csvbtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
    [Csvbtn addTarget:self action:@selector(Menuclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Csvbtn];
    
    UIButton *setServerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setServerBtn.frame = CGRectMake(214/2,Adjust_Height+43,215/2,109/2);
    setServerBtn.tag=2;
    [setServerBtn setTitle:@"Set Server" forState:UIControlStateNormal];
    setServerBtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    setServerBtn.titleLabel.numberOfLines=2;
    setServerBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [setServerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [setServerBtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
    [setServerBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];    [setServerBtn addTarget:self action:@selector(Menuclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setServerBtn];
    
    UIButton *SyncBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SyncBtn.frame = CGRectMake(428/2,Adjust_Height+43,213/2,109/2);
    SyncBtn.tag=3;
    SyncBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [SyncBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [SyncBtn setTitle:@"Sync Data" forState:UIControlStateNormal];
    SyncBtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    SyncBtn.titleLabel.numberOfLines=2;
    [SyncBtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
    [SyncBtn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
    [SyncBtn addTarget:self action:@selector(Menuclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SyncBtn];

    Globalview=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+101, 320, self.view.frame.size.height-(Adjust_Height+101))];
    Globalview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:Globalview];
    
   
    SharedobjDb=[DatabseInstance sharedInstance];
    sDB=SharedobjDb.sDB;

    [self Menuclicked:Csvbtn];
}

#pragma mark Menuview
-(void)Menuclicked:(id)Sender
{
    if (Prevbtn) {
        [Prevbtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
        
    }
    UIButton *Btn=(UIButton*)Sender;
    
    if (Prevbtn.tag==[Sender tag]) {
        [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
        return;
    }
    Prevbtn=Btn;

    [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];

    for (__strong id view in Globalview.subviews) {
        [view removeFromSuperview];
        view=nil;
    }
    
    if (servertabScroll) {
        [servertabScroll removeFromSuperview];
        servertabScroll=nil;
    }
    
    if ([Sender tag]==3) {
        if ([mainDelegate.UserType isEqualToString:@"Liteuser"])
        {
            UIAlertView *alertpro=[[UIAlertView alloc]initWithTitle:@"" message:@"In the Lite version, you can only export to csv. Please register for PRO to use other Sync options." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
            alertpro.tag=100;
            [alertpro show];
        }
        else
        [self Synctab];
    }
    else
        if ([Sender tag]==2) {
            
            [self ServerTab];
        }
    else
       {
               [self ExportCsvtab];
        }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        
        [self Menuclicked:Csvbtn];

    }
    if (alertView.tag==188) {
        if (buttonIndex==1) {
            [self Logout];
        }
    }

}

-(void)ExportCsvtab
{
    [self getformsname ];
    if (SelectFormTxt) {
        SelectFormTxt=nil;
    }

    SelectFormTxt=[[UITextField alloc]initWithFrame:CGRectMake(35, 50, 255, 35)];
    SelectFormTxt.backgroundColor=[UIColor clearColor];
    SelectFormTxt.placeholder=@"Select a Form" ;
    SelectFormTxt.delegate=self;
    SelectFormTxt.autocapitalizationType=UITextAutocapitalizationTypeNone;
    SelectFormTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    SelectFormTxt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    SelectFormTxt.autocorrectionType=UITextAutocorrectionTypeNo;
    SelectFormTxt.leftView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 15, 10)];
    SelectFormTxt.rightView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 10, 10)];
    SelectFormTxt.leftViewMode=UITextFieldViewModeAlways;
    SelectFormTxt.background=[UIImage imageNamed:@"selectform.png"];
    [Globalview addSubview:SelectFormTxt];
   
    UIButton *SetupConnectionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SetupConnectionbtn.frame = CGRectMake(33,120,255,35);
    [SetupConnectionbtn setTitle:@"Export CSV" forState:UIControlStateNormal];
    SetupConnectionbtn.layer.borderWidth=1.0;
    SetupConnectionbtn.layer.cornerRadius=5.0;
    SetupConnectionbtn.layer.borderColor=[UIColor grayColor].CGColor;
    [SetupConnectionbtn setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
    [SetupConnectionbtn addTarget:self action:@selector(exportCsvFile) forControlEvents:UIControlEventTouchUpInside];
    [Globalview addSubview:SetupConnectionbtn];


}

#pragma mark:Export csv
-(void)exportCsvFile
{
        NSMutableArray *OldValueArray=[self Getformdata];
        NSMutableArray *FieldArray=[[NSMutableArray alloc]init];
        [FieldArray addObject:@"RECORD ID"];
        [FieldArray addObject:@"LEVEL1 NAME"];
        [FieldArray addObject:@"LEVEL2 NAME"];
        [FieldArray addObject:@"LEVEL3 NAME"];
        [FieldArray addObject:@"SECTION NAME"];
        [FieldArray addObject:@"FIELD NAME"];
        [FieldArray addObject:@"FIELD VALUE"];
        [FieldArray addObject:@"USER TYPE"];
        [FieldArray addObject:@"DATE CREATED"];
        [FieldArray addObject:@"DATE MODIFIED"];
        
        if (OldValueArray.count<1) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"No Data Found."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            
            [alertView show];
            return;
        }
        
        NSDate *date=[NSDate date];
        NSString *Fieldnames=@"";
        NSString *Values=@"";
        NSString *tablename=[NSString stringWithFormat:@"%@_%@",SelectFormTxt.text,date];
        
        for (int i=0; i<FieldArray.count; i++)
        {
            if (i==0) {
                Fieldnames=[Fieldnames stringByAppendingString: [NSString stringWithFormat:@"%@",[FieldArray objectAtIndex:i]]];
            }
            else
                Fieldnames=[Fieldnames stringByAppendingString:[NSString stringWithFormat:@",%@",[FieldArray objectAtIndex:i]]];
        }
        
        for (int i=0; i<OldValueArray.count; i++)
        {
            NSDictionary *Tempdict=[OldValueArray objectAtIndex:i];
            if (i==0)
            {
                Values=[NSString stringWithFormat:@"\n%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",Tempdict[@"record"],Tempdict[@"field3"],Tempdict[@"lvl1"],Tempdict[@"lvl2"],Tempdict[@"section"],Tempdict[@"field1"],Tempdict[@"field2"],Tempdict[@"usertype"],Tempdict[@"lvl3"],Tempdict[@"cm1"]];
            }
            else
                Values=[Values stringByAppendingString: [NSString stringWithFormat:@"\n%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",Tempdict[@"record"],Tempdict[@"field3"],Tempdict[@"lvl1"],Tempdict[@"lvl2"],Tempdict[@"section"],Tempdict[@"field1"],Tempdict[@"field2"],Tempdict[@"usertype"],Tempdict[@"lvl3"],Tempdict[@"cm1"]]];
        }
        
        NSArray *array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",Fieldnames],[NSString stringWithFormat:@"%@",Values], nil];
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filename=[NSString stringWithFormat:@"%@.csv",tablename];
        NSString *filePathLib = [NSString stringWithFormat:@"%@",[docDir stringByAppendingPathComponent:filename]];
        
        [[array componentsJoinedByString:@","] writeToFile:filePathLib atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        
        if ([MFMailComposeViewController canSendMail]) {
            
            NSString *recipient = @"";
            NSArray *recipients = [NSArray arrayWithObjects:recipient, nil];
            
            MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
            mailViewController.mailComposeDelegate = self;
            [mailViewController setSubject:@"CSV Export"];
            [mailViewController setToRecipients:recipients];
            [mailViewController setMessageBody:@"" isHTML:NO];
            
            NSData *myData = [NSData dataWithContentsOfFile:filePathLib];
            
            [mailViewController addAttachmentData:myData
                                         mimeType:@"text/csv"
                                         fileName:tablename];
            
            [self presentViewController:mailViewController animated:YES completion:nil];
            
        }
        //Display alert to the user
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't Send Mail"
                                                                message:@"Device is unable to send email in its current state."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            
            [alertView show];
        }
        
}

-(NSMutableArray*)Getformdata
{
    
    [SharedobjDb openDB];
    sqlite3_stmt *statement=nil;
    sqlite3 *dbref=SharedobjDb.sDB;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
    
    if (sqlite3_open(SharedobjDb.dbpath, &dbref) == SQLITE_OK)
    {
        NSString *Query=[NSString stringWithFormat:@"SELECT st.section_name,fld.fieldname,dt.fieldval,level1_data,level2_data,level3_data,dt.dateCreated,dt.dateModified,tl3.rowid  From DetailTable dt LEFT JOIN  tp_level1_master tl1 ON dt.level1id=tl1.rowid  INNER JOIN  tp_level2_master tl2 ON dt.level2id=tl2.rowid INNER JOIN  tp_level3_master tl3 ON dt.level3id=tl3.rowid LEFT JOIN  FieldDetailtable fld ON dt.fieldId=fld.fieldno AND dt.sectionid=fld.sectionid AND fld.formid='%@' INNER JOIN SectionTable St ON st.sid=dt.sectionid AND st.formid='%@' WHERE dt.formid='%@' order by tl3.rowid asc",SelectedformTid,SelectedformTid,Selectedformid];
        
        const char *query_stmt = [Query UTF8String];
          int i=1;
        if (sqlite3_prepare_v2(SharedobjDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* sect = (const char*)sqlite3_column_text(statement, 0);
                NSString *sectionnname = sect== NULL ? @"" : [[NSString alloc] initWithUTF8String:sect];
                
                [tempdict setObject:sectionnname forKey:@"section"];
                
                const char* Id = (const char*)sqlite3_column_text(statement, 1);
                NSString *name = Id== NULL ? @"" : [[NSString alloc] initWithUTF8String:Id];
                
                [tempdict setObject:name forKey:@"field1"];
                
                const char* Lvl1 = (const char*)sqlite3_column_text(statement, 2);
                NSString *level1 = Lvl1== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl1];
                NSString *key=[NSString stringWithFormat:@"field2"];
                [tempdict setObject:level1 forKey:key];
                
                const char* Lvl2 = (const char*)sqlite3_column_text(statement, 3);
                NSString *level2 = Lvl2== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl2];
                [tempdict setObject:level2 forKey:@"field3"];
                
                const char* lvl1nam = (const char*)sqlite3_column_text(statement, 4);
                NSString *l1name = lvl1nam== NULL ? @"" : [[NSString alloc] initWithUTF8String:lvl1nam];
                [tempdict setObject:l1name forKey:@"lvl1"];
                
                const char* lvl2nam = (const char*)sqlite3_column_text(statement, 5);
                NSString *level2name = lvl2nam== NULL ? @"" : [[NSString alloc] initWithUTF8String:lvl2nam];
                [tempdict setObject:level2name forKey:@"lvl2"];
                
                const char* lvl3nam = (const char*)sqlite3_column_text(statement, 6);
                NSString *level3name = lvl3nam== NULL ? @"" : [[NSString alloc] initWithUTF8String:lvl3nam];
                [tempdict setObject:level3name forKey:@"lvl3"];
                
                const char* cm1 = (const char*)sqlite3_column_text(statement, 7);
                NSString *comment1 = cm1== NULL ? @"" : [[NSString alloc] initWithUTF8String:cm1];
                [comment1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                [tempdict setObject:comment1 forKey:@"cm1"];
                
                const char* rowid1 = (const char*)sqlite3_column_text(statement, 8);
                NSString *tempid = rowid1== NULL ? @"" : [[NSString alloc] initWithUTF8String:rowid1];
                [tempdict setObject:tempid forKey:@"uniqueid"];

                [tempdict setObject:mainDelegate.UserType forKey:@"usertype"];


                if (DetailArray1.count>1)
                {
                    NSDictionary *dict1=[DetailArray1 objectAtIndex:DetailArray1.count-2];
                    if (![[dict1 valueForKey:@"uniqueid"] isEqualToString:[tempdict valueForKey:@"uniqueid"]])
                    {
                        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
                        [tempDict setObject:@"" forKey:@"section"];
                        [tempDict setObject:@"" forKey:@"field1"];
                        [tempDict setObject:@"" forKey:@"field2"];
                        [tempDict setObject:@"" forKey:@"field3"];
                        [tempDict setObject:@"" forKey:@"lvl1"];
                        [tempDict setObject:@"" forKey:@"lvl2"];
                        [tempDict setObject:@"" forKey:@"lvl3"];
                        [tempDict setObject:@"" forKey:@"cm1"];
                        [tempDict setObject:@"" forKey:@"usertype"];
                        [tempDict setObject:@"" forKey:@"record"];

                        if (dict1[@"uniqueid"])
                        {
                            [DetailArray1 addObject:tempDict];
                            i+=1;
  
                        }
                    }
                }
                [tempdict setObject:[NSString stringWithFormat:@"Record %d",i] forKey:@"record"];

                [DetailArray1 addObject:tempdict];
                tempdict=nil;
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(SharedobjDb.sDB);
    }
    
    return DetailArray1;
    
    
    
}

-(NSMutableArray*)GEtfieldnames
{
    [SharedobjDb openDB];
    sqlite3_stmt *statement=nil;
    sqlite3 *dbref=SharedobjDb.sDB;
    NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
    
    if (sqlite3_open(SharedobjDb.dbpath, &dbref) == SQLITE_OK)
    {
        
        NSString *Query=[NSString stringWithFormat:@"SELECT fieldname From FieldDetailtable  WHERE formid='%@'",Selectedformid];
        
        const char *query_stmt = [Query UTF8String];
        if (sqlite3_prepare_v2(SharedobjDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                const char* Id = (const char*)sqlite3_column_text(statement, 0);
                NSString *name = Id== NULL ? @"" : [[NSString alloc] initWithUTF8String:Id];
                
                [DetailArray1 addObject:name];
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(SharedobjDb.sDB);
    }
    
    return DetailArray1;
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [[controller presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    if (result==MFMailComposeResultSent) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mail Sent Successfully."
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
    }
    else
    {
        NSLog(@"error %@",error);
        
    }
    
}

#pragma mark:
-(void)Synctab
{
    [self getformsname ];
    if (SelectFormTxt) {
        SelectFormTxt=nil;
    }
    SelectFormTxt=[[UITextField alloc]initWithFrame:CGRectMake(33, 10, 255, 35)];
    SelectFormTxt.backgroundColor=[UIColor clearColor];
    SelectFormTxt.placeholder=@"Select a Form" ;
    SelectFormTxt.delegate=self;
    SelectFormTxt.autocapitalizationType=UITextAutocapitalizationTypeNone;
    SelectFormTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    SelectFormTxt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    SelectFormTxt.autocorrectionType=UITextAutocorrectionTypeNo;
    SelectFormTxt.leftView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 10, 10)];
    SelectFormTxt.rightView=[[UIView alloc]initWithFrame:CGRectMake(15, 0, 10, 10)];
    SelectFormTxt.leftViewMode=UITextFieldViewModeAlways;
    SelectFormTxt.background=[UIImage imageNamed:@"selectform.png"];
    [Globalview addSubview:SelectFormTxt];
    SelectFormTxt.hidden=YES;
    
    UILabel *sublabl1=[[UILabel alloc]initWithFrame:CGRectMake(10,100, 200, 26)];
    sublabl1.text=@"Sync All data";
    sublabl1.font=[UIFont systemFontOfSize:13.0f];
    sublabl1.numberOfLines=0;
    sublabl1.textAlignment=NSTextAlignmentCenter;
    sublabl1.lineBreakMode=NSLineBreakByWordWrapping;
    sublabl1.backgroundColor=[UIColor clearColor];
    [Globalview addSubview:sublabl1];
    
    UILabel *sublabl2=[[UILabel alloc]initWithFrame:CGRectMake(10,55, 200, 26)];
    sublabl2.text=@"Sync Selected form data";
    sublabl2.font=[UIFont systemFontOfSize:13.0f];
    sublabl2.numberOfLines=0;
    sublabl2.textAlignment=NSTextAlignmentCenter;
    sublabl2.lineBreakMode=NSLineBreakByWordWrapping;
    sublabl2.backgroundColor=[UIColor clearColor];
    [Globalview addSubview:sublabl2];
    
    _radio1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _radio1.frame=CGRectMake(210,90, 26, 26);
    _radio1.tag=1;
    [_radio1 addTarget:self action:@selector(Btnpressed:) forControlEvents:UIControlEventTouchUpInside];
    [_radio1 setBackgroundImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateNormal];
    [Globalview addSubview:_radio1];
    
    _radio2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _radio2.frame=CGRectMake(210,50, 26, 26);
    _radio2.tag=2;
    [_radio2 addTarget:self action:@selector(Btnpressed:) forControlEvents:UIControlEventTouchUpInside];
    [_radio2 setBackgroundImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];
    [Globalview addSubview:_radio2];
    
    UILabel *labl1=[[UILabel alloc]initWithFrame:CGRectMake(10,150,190, 34)];
    labl1.text=@"Click to fetch data from server";
    labl1.font=[UIFont systemFontOfSize:13.0f];
    labl1.numberOfLines=0;
    labl1.textAlignment=NSTextAlignmentCenter;
    labl1.lineBreakMode=NSLineBreakByWordWrapping;
    labl1.backgroundColor=[UIColor clearColor];
    [Globalview addSubview:labl1];
    
    fetchbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    fetchbtn.frame=CGRectMake(210,150, 80, 34);
    fetchbtn.layer.borderWidth=1.0;
    fetchbtn.layer.cornerRadius=5.0;
    fetchbtn.layer.borderColor=[UIColor grayColor].CGColor;
    [fetchbtn addTarget:self action:@selector(Fetchrecord) forControlEvents:UIControlEventTouchUpInside];
    [fetchbtn setTitle:@"Fetch" forState:UIControlStateNormal];
    [fetchbtn setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
    [Globalview addSubview:fetchbtn];
    
    UILabel *labl2=[[UILabel alloc]initWithFrame:CGRectMake(10,200,190, 34)];
    labl2.text=@"Click to Submit data To server database";
    labl2.font=[UIFont systemFontOfSize:13.0f];
    labl2.numberOfLines=0;
    labl2.textAlignment=NSTextAlignmentCenter;
    labl2.lineBreakMode=NSLineBreakByWordWrapping;
    labl2.backgroundColor=[UIColor clearColor];
    [Globalview addSubview:labl2];
    
    submitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitbtn.frame=CGRectMake(210,200, 80, 34);
    submitbtn.layer.cornerRadius=5.0;
    [submitbtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitbtn.layer.borderWidth=1.0;
    submitbtn.layer.borderColor=[UIColor grayColor].CGColor;
    [submitbtn addTarget:self action:@selector(SubmitUpdatedata) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
    [Globalview addSubview:submitbtn];
    
    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10,280, 300, 20)];
    lbl1.text=@"Please be careful before clicking any of these options.";
    lbl1.font=[UIFont systemFontOfSize:11.0f];
    lbl1.textAlignment=NSTextAlignmentCenter;
    lbl1.lineBreakMode=NSLineBreakByWordWrapping;
    lbl1.backgroundColor=[UIColor clearColor];
    [Globalview addSubview:lbl1];
    
    //check if databse connected
    if (mainDelegate.Companyid==nil)
    {
        [submitbtn setBackgroundImage:[UIImage imageNamed:@"Submit_d.png"] forState:UIControlStateNormal];
        [fetchbtn setBackgroundImage:[UIImage imageNamed:@"fetch_d.png"] forState:UIControlStateNormal];
      
    }
    
    mainDelegate.Alldataflag=1;
}



-(void)ServerTab
{
    
    servertabScroll=[[UIScrollView alloc]init ];
    servertabScroll.frame=Globalview.frame;
    servertabScroll.backgroundColor=[UIColor clearColor];
    [self.view addSubview:servertabScroll];
    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image.frame=CGRectMake(50,20, 230, 30);
    [servertabScroll addSubview:image];
    
    hostName=[[UITextField alloc]initWithFrame:CGRectMake(55,20, 220, 30)];
    hostName.backgroundColor=[UIColor clearColor];
    hostName.placeholder=@"HostName" ;
    hostName.autocapitalizationType=UITextAutocapitalizationTypeNone;
    hostName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    hostName.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    [servertabScroll addSubview:hostName];
    hostName.delegate=self;
    
    
    UIImageView *image1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image1.frame=CGRectMake(50,60, 230, 30);
    [servertabScroll addSubview:image1];
    
    Uname=[[UITextField alloc]initWithFrame:CGRectMake(55, 60, 220, 30)];
    Uname.backgroundColor=[UIColor clearColor];
    Uname.placeholder=@"Username" ;
    Uname.autocapitalizationType=UITextAutocapitalizationTypeNone;
    Uname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Uname.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    [servertabScroll addSubview:Uname];
    Uname.delegate=self;
    
    UIImageView *image2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image2.frame=CGRectMake(50,100, 230, 30);
    [servertabScroll addSubview:image2];
    
    Passwd=[[UITextField alloc]initWithFrame:CGRectMake(55, 100, 220, 30)];
    Passwd.backgroundColor=[UIColor clearColor];
    Passwd.placeholder=@"Password" ;
    Passwd.autocapitalizationType=UITextAutocapitalizationTypeNone;
    Passwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Passwd.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    Passwd.secureTextEntry=YES;
    [servertabScroll addSubview:Passwd];
    Passwd.delegate=self;
    
    UIImageView *image3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image3.frame=CGRectMake(50,140, 230, 30);
    [servertabScroll addSubview:image3];
    
    DatabaseName=[[UITextField alloc]initWithFrame:CGRectMake(55, 140, 220, 30)];
    DatabaseName.backgroundColor=[UIColor clearColor];
    DatabaseName.placeholder=@"Database name";
    DatabaseName.autocapitalizationType=UITextAutocapitalizationTypeNone;
    DatabaseName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    DatabaseName.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    [servertabScroll addSubview:DatabaseName];
    DatabaseName.delegate=self;
    
    
    UIImageView *image4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image4.frame=CGRectMake(50,180, 230, 30);
    [servertabScroll addSubview:image4];
    
    Companycode=[[UITextField alloc]initWithFrame:CGRectMake(55, 180, 220, 30)];
    Companycode.backgroundColor=[UIColor clearColor];
    Companycode.placeholder=@"Company code";
    Companycode.autocapitalizationType=UITextAutocapitalizationTypeNone;
    Companycode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Companycode.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    [servertabScroll addSubview:Companycode];
    Companycode.delegate=self;
    
    UIButton *submitbtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    submitbtn2.frame=CGRectMake(50,230, 230, 36);
    [submitbtn2 addTarget:self action:@selector(SubmitAction) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn2 setBackgroundImage:[UIImage imageNamed:@"save1.png"] forState:UIControlStateNormal];
    [servertabScroll addSubview:submitbtn2];
    
    
    NSString *Dbhostname=[[NSUserDefaults standardUserDefaults] valueForKey:@"Dbhostname"];
    NSString *DbUsername=[[NSUserDefaults standardUserDefaults]valueForKey:@"Dbuname"];
    NSString *Dbpasswd=[[NSUserDefaults standardUserDefaults]valueForKey:@"Dbpasswd"];
    NSString *Databasename=[[NSUserDefaults standardUserDefaults]valueForKey:@"Dbname"];
    NSString *Companyid=[[NSUserDefaults standardUserDefaults]valueForKey:@"Companycode"];
    
    servertabScroll.contentSize=CGSizeMake(0, servertabScroll.frame.size.height+80);
    
    if (![DbUsername isEqualToString:@"Liteuser"])
    {
        if (Databasename!=nil)
        {
            hostName.text=Dbhostname;
            Uname.text=DbUsername;
            Passwd.text=Dbpasswd;
            DatabaseName.text=Databasename;
            Companycode.text=Companyid;
        }
    }
    else
    {
           hostName.text=@"localhost";
        Uname.text=DbUsername;
        Passwd.text=Dbpasswd;
        DatabaseName.text=Databasename;
        Companycode.text=Companyid;
    }

}

-(void)getformsname
{
    [SharedobjDb openDB];
    
    if (Formidarray) {
        FormNamearray=nil;
        Formidarray=nil;
    }
    FormNamearray=[[NSMutableArray alloc]init];
    Formidarray=[[NSMutableArray alloc]init];
    FormTidarray=[[NSMutableArray alloc]init];

    sqlite3_stmt *statement = nil;
    sqlite3 *Objsql=SharedobjDb.sDB;
    if (sqlite3_open(SharedobjDb.dbpath, &Objsql) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT form_name,id,ftid  FROM tp_forms  where usertype='%@' order by id ",mainDelegate.UserType]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(SharedobjDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *formname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                [FormNamearray addObject:formname ];
                NSString *formid = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                [Formidarray addObject:formid ];
                
                NSString *formtid = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                [FormTidarray addObject:formtid ];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(SharedobjDb.sDB);
}


#pragma mark:logout
-(void)Logoutclicked
{
    UIAlertView *alerts=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to logout." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alerts.tag=188;
    [alerts show];
    
}


-(void)Logout
{
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [mainDelegate Showrootview];
    
}


#pragma mark: radiobtndelegate & methods
-(void)Btnpressed:(id)Sender
{
    if ([Sender tag]==1)
    {
        mainDelegate.Alldataflag=1;
        Alldataflag=1;
        [_radio1 setBackgroundImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateNormal];
        [_radio2 setBackgroundImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];
        SelectFormTxt.hidden=YES;
    }
    else
    {
        mainDelegate.Alldataflag=0;
        SelectFormTxt.hidden=NO;
          Alldataflag=0;
        [_radio2 setBackgroundImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateNormal];
        [_radio1 setBackgroundImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];

    }
}




-(void)SubmitAction
{
    if (!mainDelegate.checkInternet)
    {
        UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"We are unable to make a internet connection at this time. Some functionality will not work until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerts show];
        return;
    }

    if (hostName.text.length<2 || Uname.text.length<2 || Passwd.text.length<2) // || DatabaseName.text.length<2
    {
        UIAlertView *alert10=[[UIAlertView alloc]initWithTitle:@"" message:@"Please fill the details." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert10 show];

        return;
    }
    if (mainDelegate.Companyid!=nil && !mainDelegate.Companyid.length<2)
    {
        UIAlertView *alert10=[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"All your previous work will be deleted.Do you want to continue." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alert10.tag=1234;
        [alert10 show];
    }
    else
    {
        [self submitdataservice];
    }
}

-(void)submitdataservice
{
    NSString *urlStr = [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/add_db.php?dbuser=%@&dbpassword=%@&dbhost=%@&cid=%@",Uname.text,Passwd.text,hostName.text,Companycode.text];
    
    NSLog(@" URL : %@",urlStr);
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Return Data is:%@", returnString);
    
    NSString *error=[self exctractStringFromTags:returnString :@"<error>" :@"</error>"];
    
    NSString *configerror1=[self exctractStringFromTags:returnString :@"<config>" :@"</config>"];
    
    if (error!=nil)
    {
        UIAlertView *alert1;
        if (configerror1!=nil) {
            alert1=[[UIAlertView alloc]initWithTitle:@"Incorrect information." message:@"Could not connect to server.please check the details." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
        }
        else
            alert1=[[UIAlertView alloc]initWithTitle:@"Incorrect information." message:@"Could not connect to server.please check the details." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert1 show];
        
        

    }
    else
    {
        
        NSString *str=[self exctractStringFromTags:returnString :@"<company_name>" :@"</company_name>"];
        if (str==nil || str.length<1)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Incorrect information" message:@"Could not connect to server." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [alert1 show];
            
            if (mainDelegate.Companyid==nil)
            {
                [submitbtn setBackgroundImage:[UIImage imageNamed:@"Submit_d.png"] forState:UIControlStateNormal];
                [fetchbtn setBackgroundImage:[UIImage imageNamed:@"fetch_d.png"] forState:UIControlStateNormal];
            }

            return;
        }

        mainDelegate.Companyid=[self exctractStringFromTags:returnString :@"<company_name>" :@"</company_name>"];
        [[NSUserDefaults standardUserDefaults] setValue: mainDelegate.Companyid forKey:@"Companycode"];
        [[NSUserDefaults standardUserDefaults] setValue:hostName.text forKey:@"Dbhostname"];
        [[NSUserDefaults standardUserDefaults] setValue:Uname.text forKey:@"Dbuname"];
        [[NSUserDefaults standardUserDefaults]setValue:Passwd.text forKey:@"Dbpasswd"];
        [[NSUserDefaults standardUserDefaults]setValue:DatabaseName.text forKey:@"Dbname"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        NSString *msg=[NSString stringWithFormat:@"Your company code is %@",mainDelegate.Companyid];
               UIAlertView *alert10=[[UIAlertView alloc]initWithTitle:@"Please logout from this Lite version and login as a PRO user to use the advanced features of PRO" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alert10.tag=88;
        [alert10 show];
        
        [self saveCompanycode:mainDelegate.Companyid];
        
        [self Getquetiondatafromserver];
        
        if (mainDelegate.Companyid!=nil)
        {
        }
        else
        {
            [self Removealldata1];
        }
    }

}

-(void)Getquetiondatafromserver
{
    if (!mainDelegate.checkInternet) {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load Initial data.App will not work correctly untill you load initial data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert1 show];
        return;
    }
    NSString*urlString1;
    
    urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_initial_company_form.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error=nil;
    if(data)
    {
        NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"urlResponse: %@",returnString);
        if (returnString==nil) {
            returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        }
        NSLog(@"%@",returnString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSArray *strretun1=[dataDictionary valueForKey:@"tp_forms"];
        NSArray *strretun2=[dataDictionary valueForKey:@"form_names"];
        NSArray *strretun3=[dataDictionary valueForKey:@"labels"];
        NSArray *strretun4=[dataDictionary valueForKey:@"field_detail"];
        NSArray *strretun5=[dataDictionary valueForKey:@"appDetails"];
        NSArray *strretun6=[dataDictionary valueForKey:@"section"];
        NSArray *strretun7=[dataDictionary valueForKey:@"tp_level1_master"];
        NSArray *strretun8=[dataDictionary valueForKey:@"tp_level2_master"];
        NSArray *strretun9=[dataDictionary valueForKey:@"tp_level3_master"];
        
        NSArray *array=[NSArray arrayWithObjects:strretun1,strretun2,strretun3,strretun4,strretun5,strretun6,strretun7,strretun8,strretun9, nil];
            [self Insertintotable:array];
    }
    else
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert1 show];
    }
    
}

-(void)saveCompanycode:(NSString*)companyid
{
    
    NSString *queryMax=@"SELECT MAX(id) FROM companyidTable";
    int mid= [[SharedobjDb Getmaxid:queryMax ForTable:@"companyidTable"] intValue];
    mid++;
    
    NSString *query=[NSString stringWithFormat:@"INSERT INTO companyidTable (id,companyid) VALUES(%d,'%@')",mid,companyid];
    [SharedobjDb openDB];
    
    BOOL flag= [SharedobjDb ExexuteOperation:query];
    
    NSLog(@"%d",flag);
}


-(void)popViewback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark textfield delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    servertabScroll.contentOffset=CGPointMake(0, textField.frame.origin.y);
    if (textField==SelectFormTxt) {
            
            [textField resignFirstResponder];
            UITableView  *table=[[UITableView alloc]initWithFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width, 100) style:UITableViewStylePlain];
            table.delegate=self;
            table.dataSource=self;
            [Globalview addSubview:table];
        }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    servertabScroll.contentOffset=CGPointZero;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [hostName resignFirstResponder];
    [Uname resignFirstResponder];
    [Passwd resignFirstResponder];
    [DatabaseName resignFirstResponder];
    [Companycode resignFirstResponder];
    for (__strong UITableView *View in Globalview.subviews) {
        if ([View isKindOfClass:[UITableView class]]) {
            [View removeFromSuperview];
            View=nil;
        }
    }
    
    
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1234) {
        if (buttonIndex==1) {
            [self submitdataservice];
        }

    }
    if (alertView.tag==88)
    {
                [self Logout];
    }
}

#pragma mark-tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Formidarray.count;
    
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
    cell.backgroundView=nil;
    
    cell.textLabel.text=[FormNamearray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
    {
        
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        
    }
    else
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    SelectFormTxt.text=[FormNamearray objectAtIndex:indexPath.row];
    Selectedformid=[Formidarray objectAtIndex:indexPath.row];
    SelectedformTid=[FormTidarray objectAtIndex:indexPath.row];
    [tableView removeFromSuperview];
    tableView=nil;
    
}

#pragma mark:sync methods

-(void)Fetchrecord
{
    if (mainDelegate.Companyid==nil) {
        UIAlertView *alert11=[[UIAlertView alloc]initWithTitle:@"Please Set Up Server Connection First." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert11 show];
        return;
        
    }

    if (!mainDelegate.checkInternet)
    {
        UIAlertView *alert11=[[UIAlertView alloc]initWithTitle:@"You need to be connected to the net for first time logging in’.." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert11 show];
        return;
    }
   

    NSLog(@"Fetch record from server.");
    [self removeimagesfromdocdirectory];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	// Set determinate bar mode
	HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
	HUD.delegate = self;
	// myProgressTask uses the HUD instance to update progress
//	[HUD showWhileExecuting:@selector(Backgoundprocess) onTarget:self withObject:nil animated:YES];
    
    [HUD show:YES];
    
    [self performSelectorInBackground:@selector(Backgoundprocess) withObject:nil];
    
}

-(void)SubmitUpdatedata
{
    if (mainDelegate.Companyid==nil) {
        UIAlertView *alert11=[[UIAlertView alloc]initWithTitle:@"Please select database first." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert11 show];
        return;

    }
    
    if (!mainDelegate.checkInternet)
    {
        UIAlertView *alert11=[[UIAlertView alloc]initWithTitle:@"No internet connection." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert11 show];
        return;
    }

    if (!mainDelegate.Alldataflag)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        // Set determinate bar mode
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.delegate = self;
        [HUD showAnimated:YES whileExecutingBlock:^{
            [self Senddetailtabledata1];
            [self SendMediatabledata1];
            [self sendDeleteddata];
        } completionBlock:^{
            UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:@"Data successfully synced to server." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alerts show];

    }];
        
    }
    else
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        // Set determinate bar mode
        HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
        HUD.delegate = self;
        // myProgressTask uses the HUD instance to update progress
        [HUD showWhileExecuting:@selector(SendPhpFileDataToserver) onTarget:self withObject:nil animated:YES];

    }

}

-(void)submidata
{
    sqlite3_stmt    *statement;
    
    [SharedobjDb openDB];
    
    IdArray=[[NSMutableArray alloc]init];
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select *from OperationTable"]; //order by id DESC limit 1
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                NSString *Id = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [tempdict setValue:Id forKey:@"ID"];
                
                NSString *OperationUrl = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                OperationUrl=[OperationUrl stringByReplacingOccurrencesOfString:@"cid=(null)" withString:[NSString stringWithFormat:@"cid=%@",mainDelegate.Companyid]];

                [tempdict setValue:OperationUrl forKey:@"OperationUrl"];
                
               
                NSString *Table = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                [tempdict setValue:OperationUrl forKey:@"Table"];
                
                const char* zonename1 = (const char*)sqlite3_column_text(statement, 3);
                NSString *Imagename = zonename1== NULL ? nil : [[NSString alloc] initWithUTF8String:zonename1];
        
                [tempdict setValue:Imagename forKey:@"Imagename"];
                [IdArray addObject:tempdict];
                NSLog(@"%@",Table);
                
            }
            sqlite3_finalize(statement);
            
        }
        if (IdArray.count>0)
        {
            if (mainDelegate.checkInternet)
            {
                NSString *urlpath=[[NSUserDefaults standardUserDefaults] objectForKey:@"Serverpath"];
                if (urlpath!=nil) {
                    [self SendPhpFileDataToserver];

                }
                //update record to flag=0
                    char *err;
                NSString *Updatequery=@"update tp_transactions set updateflag='0'";
                if (sqlite3_exec(sDB, [Updatequery UTF8String], NULL, NULL, &err)!= SQLITE_OK)
                {
                    sqlite3_close(sDB);
                    NSLog(@"update Records Fail");
                }
                else
                {
                    NSLog(@"update Records SuccessFull");
                    sqlite3_close(sDB);
                }
                
                //update level_sTATUS TABLE
                char *err1;
                NSString *Updatequery1=@"update tp_level_status set updateflag='0'";
                if (sqlite3_exec(sDB, [Updatequery1 UTF8String], NULL, NULL, &err1)!= SQLITE_OK)
                {
                    sqlite3_close(sDB);
                    NSLog(@"update Records Fail");
                }
                else
                {
                    NSLog(@"update Records SuccessFull");
                    sqlite3_close(sDB);
                }

            }
        }
        else
        {
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            alert=nil;
            
            UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:@"No updated record found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alerts show];
            return;
        }
        
        for (int i=0; i<IdArray.count; i++)
        {
            NSMutableDictionary *tempdict1=[IdArray objectAtIndex:i];
            NSString *str=[tempdict1 valueForKey:@"Imagename"];
            
            if (str!=nil && ![str isEqualToString:@""])
            {
                NSString *imagname=[tempdict1 valueForKey:@"Imagename"];
                
                [self uploadimages:[tempdict1 valueForKey:@"OperationUrl"] imgname:imagname];//adds only data
                
                NSArray *arr=[imagname componentsSeparatedByString:@","];
                for (int i=0; i<arr.count; i++) {
                    [self Uploadimag:[arr objectAtIndex:i]];
                    
                }
            }
            else
            {
                if (!mainDelegate.checkInternet)
                {
                    UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"We are unable to make a internet connection at this time. Some functionality will not work until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alerts show];
                    return;
                }
            }
            //delete record
            
            NSString *Query = [NSString stringWithFormat:@"DELETE from OperationTable WHERE id=%@",[tempdict1 valueForKey:@"ID"]];
            
            char *err;
            sqlite3_stmt *statement = nil;
            if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
            {
                if (sqlite3_exec(sDB, [Query UTF8String], NULL, NULL, &err)!= SQLITE_OK)
                {
                    sqlite3_close(sDB);
                    NSLog(@"Updating Fail");
                }
                else
                {
                    NSLog(@"Update SuccessFull");
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            
        }
        sqlite3_close(sDB);
    }
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    alert=nil;
}

-(void)removeimagesfromdocdirectory
{
    NSMutableArray *imgnamearray=[[NSMutableArray alloc]init];
    [SharedobjDb  openDB];
    
    sqlite3_stmt *statement=nil;
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"select medianame from MediaTable where usertype=Prouser"]; //order by id DESC limit 1
        
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                const char* name1 = (const char*)sqlite3_column_text(statement, 0);
                NSString *Id = name1== NULL ? @"" : [[NSString alloc] initWithUTF8String:name1];
                if (![Id isEqualToString:@""])
                    [imgnamearray addObject:Id];
                
            }
            sqlite3_finalize(statement);
            
		}
    }
        sqlite3_close(sDB);
        
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    
    for (int i=0; i<imgnamearray.count; i++)
    {
        
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[imgnamearray objectAtIndex:i]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:savedImagePath error:NULL];
    }
    
}

#pragma mark - Database Methods


-(void)Removealldata
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLogFlag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //get databse table names
    //SELECT name FROM sqlite_master WHERE type='table'
    
    Tablearray=[[NSMutableArray alloc]init ];
    [Tablearray addObject:@"tp_level1_master"];
    [Tablearray addObject:@"tp_level2_master"];
    [Tablearray addObject:@"tp_level3_master"];
    [Tablearray addObject:@"MediaTable"];
    [Tablearray addObject:@"FieldDetailtable"];
    [Tablearray addObject:@"tp_properties"];
    [Tablearray addObject:@"Formtable"];
    [Tablearray addObject:@"tp_users"];
    [Tablearray addObject:@"tp_roles"];
    [Tablearray addObject:@"DetailTable"];
    [Tablearray addObject:@"SectionTable"];
    [Tablearray addObject:@"DetailTable"];
    [Tablearray addObject:@"tp_forms"];

    [SharedobjDb openDB];
    for (int i=0; i<Tablearray.count; i++)
    {
        NSString *Query = [NSString stringWithFormat:@"DELETE FROM %@",[Tablearray objectAtIndex:i]];
        
        char *err;
        sqlite3_stmt *statement = nil;
        
        if (sqlite3_exec(sDB, [Query UTF8String], NULL, NULL, &err)!= SQLITE_OK)
        {
            sqlite3_close(sDB);
            NSLog(@"TUNCATION FAIL ");
        }
        else
        {
            NSLog(@"TRUNCATE SuccessFull");
        }
        
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(sDB);
    
}

-(void)Removealldata1
{
    return;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLogFlag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //get databse table names
    
    Tablearray=[[NSMutableArray alloc]init ];
    [Tablearray addObject:@"tp_level1_master"];
    [Tablearray addObject:@"tp_level2_master"];
    [Tablearray addObject:@"tp_level3_master"];
    [Tablearray addObject:@"tp_forms"];
    [Tablearray addObject:@"FieldDetailtable"];
    [Tablearray addObject:@"MediaTable"];
   [Tablearray addObject:@"tp_users"];
   [Tablearray addObject:@"tp_roles"];
    [Tablearray addObject:@"tp_resource"];
    [Tablearray addObject:@"Levels"];
    [Tablearray addObject:@"SectionTable"];

    [SharedobjDb openDB];
    
    for (int i=0; i<Tablearray.count; i++)
    {
        NSString *Query = [NSString stringWithFormat:@"DELETE FROM %@",[Tablearray objectAtIndex:i]];
        
        char *err;
        sqlite3_stmt *statement = nil;
        if (sqlite3_exec(sDB, [Query UTF8String], NULL, NULL, &err)!= SQLITE_OK)
        {
            sqlite3_close(sDB);
            NSLog(@"TUNCATION FAIL ");
        }
        else
        {
            NSLog(@"TRUNCATE SuccessFull");
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(sDB);
    
}

-(void)Backgoundprocess
{
    HUD.progress = 0.0f;
    if (mainDelegate.checkInternet)
    {
        if (mainDelegate.Uid==nil || mainDelegate.Uid.length<2) {
            mainDelegate.Uid=@"";
        }
        [self SynLogintables];
        HUD.progress = 0.1f;
        mainDelegate.Firstloginflag=1;
        [[NSUserDefaults standardUserDefaults] setBool:mainDelegate.Firstloginflag forKey:@"FirstLogFlag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        [self Syncdetailtable];
//        HUD.progress = 0.2f;
//        [self Syncmediatable];
//        HUD.progress = 0.3f;
//        [self SyncLevel1:nil];       // commented by ajinkya
//        HUD.progress = 0.4f;
//        [self SyncLevel2];
//        HUD.progress = 0.5f;
//        [self SyncLevel3];
//        HUD.progress = 0.6f;
//        [self Syncformdetails];
//        HUD.progress = 0.7f;
//        [self SyncTpforms];
//        HUD.progress = 0.3f;
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIAlertView *alert11=[[UIAlertView alloc]initWithTitle:@"Data synchronization successful." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert11 show];
//            mainDelegate.LastSyncdate=[mainDelegate Getcurrentdate];
//
//        });
     
    }
    else
    {
           HUD.progress = 1.0f;
        UIAlertView *alert11=[[UIAlertView alloc]initWithTitle:@"You need to be connected to the net for first time logging in’.." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert11 show];
    }
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}


//Insert Form Data

#pragma mark:Sync data
-(void)SendPhpFileDataToserver
{
    float progress = 0.0f;

    [self Senddetailtabledata];
    progress += 0.1f;
    HUD.progress = progress;
    [self Sendfieldtable];
        progress += 0.1f;
    HUD.progress = progress;
    [self SendMediatabledata];
        progress += 0.1f;
    HUD.progress = progress;
    [self SendLevel1data];
    progress += 0.1f;
    HUD.progress = progress;
    [self SendLevel2data];
        progress += 0.1f;
    HUD.progress = progress;
    [self SendLevel3data];
        progress += 0.1f;
    HUD.progress = progress;
    [self SendLevelLables];
        progress += 0.1f;
    HUD.progress = progress;
    [self Sendtpformdata];
        progress += 0.1f;
    HUD.progress = progress;
    [self sendSectiontabledata];
        progress += 0.1f;
    HUD.progress = progress;
    [self sendDeleteddata];
        progress += 0.1f;
    HUD.progress = progress;
    mainDelegate.LastSyncdate=[mainDelegate Getcurrentdate];
    
    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Data synchronization successful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert1 show];
    
   }

-(void)Senddetailtabledata1
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from DetailTable WHERE usertype='Prouser'"];
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from DetailTable where  formid=%@",Selectedformid];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str6 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Subtype = str6 == NULL ? nil : [[NSString alloc] initWithUTF8String:str6];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str8 = (const char*)sqlite3_column_text(statement2, 6);
                NSString *Address = str8 == NULL ? nil : [[NSString alloc] initWithUTF8String:str8];
                
                const char* str9 = (const char*)sqlite3_column_text(statement2, 7);
                NSString *Website = str9 == NULL ? nil : [[NSString alloc] initWithUTF8String:str9];
                
                const char* str10 = (const char*)sqlite3_column_text(statement2, 8);
                NSString *InnerUrl = str10 == NULL ? nil : [[NSString alloc] initWithUTF8String:str10];
                
                const char* str11 = (const char*)sqlite3_column_text(statement2, 9);
                NSString *Lattitude = str11 == NULL ? nil : [[NSString alloc] initWithUTF8String:str11];
                
                const char* uid = (const char*)sqlite3_column_text(statement2, 10);
                NSString *userid = uid == NULL ? nil : [[NSString alloc] initWithUTF8String:uid];
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"fieldId"];
                [tempdict setValue:level3 forKey:@"formid"];
                [tempdict setValue:Type forKey:@"level1id"];
                [tempdict setValue:Subtype forKey:@"level2id"];
                [tempdict setValue:Name forKey:@"level3id"];
                [tempdict setValue:Address forKey:@"dateCreated"];
                [tempdict setValue:Website forKey:@"dateModified"];
                [tempdict setValue:InnerUrl forKey:@"fieldval"];
                [tempdict setValue:Lattitude forKey:@"sectionid"];
                [tempdict setValue:userid forKey:@"uid"];
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_detail_table.php?tbl=Form_data&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];
        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;
        
    }
    
}

-(void)SendMediatabledata1
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    NSMutableArray *medianamearray=[[NSMutableArray alloc]init];
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from MediaTable WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from MediaTable where  formid=%@",Selectedformid];
            
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str6 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Subtype = str6 == NULL ? nil : [[NSString alloc] initWithUTF8String:str6];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str0 = (const char*)sqlite3_column_text(statement2, 6);
                NSString *Name1 = str0 == NULL ? nil : [[NSString alloc] initWithUTF8String:str0];
                
                const char* str11 = (const char*)sqlite3_column_text(statement2, 7);
                NSString *sectionid = str11 == NULL ? nil : [[NSString alloc] initWithUTF8String:str11];
                
                const char* str8 = (const char*)sqlite3_column_text(statement2, 8);
                NSString *Address = str8 == NULL ? nil : [[NSString alloc] initWithUTF8String:str8];
                
                const char* str9 = (const char*)sqlite3_column_text(statement2, 9);
                NSString *Website = str9 == NULL ? nil : [[NSString alloc] initWithUTF8String:str9];
                
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"medianame"];
                [tempdict setValue:level3 forKey:@"mediatype"];
                [tempdict setValue:Type forKey:@"formid"];
                [tempdict setValue:Subtype forKey:@"level1id"];
                [tempdict setValue:Name forKey:@"level2id"];
                [tempdict setValue:Name1 forKey:@"level3id"];
                [tempdict setValue:sectionid forKey:@"sectionid"];
                [tempdict setValue:Address forKey:@"dateCreated"];
                [tempdict setValue:Website forKey:@"dateModified"];
                
                if ([tempdict[@"mediatype"] isEqualToString:@"image"]) {
                    [medianamearray addObject:[NSString stringWithFormat:@"%@.png",tempdict[@"medianame"]]];
                }
                else
                    if ([tempdict[@"mediatype"] isEqualToString:@"video"]) {
                        [medianamearray addObject:[NSString stringWithFormat:@"%@.mp4",tempdict[@"medianame"]]];
                    }
                    else
                    {//audio
                        [medianamearray addObject:[NSString stringWithFormat:@"%@.caf",tempdict[@"medianame"]]];
                        
                    }
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_media.php?tbl=media&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];
        [self SendJsondata:PhpdataAarry table:urltosend];
        
        for (int i=0; i<medianamearray.count; i++) {
            [self Uploadimag:[medianamearray objectAtIndex:i]];
        }
    }
    
}

-(void)Senddetailtabledata
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from DetailTable WHERE usertype='Prouser'"];
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from DetailTable where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str6 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Subtype = str6 == NULL ? nil : [[NSString alloc] initWithUTF8String:str6];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str8 = (const char*)sqlite3_column_text(statement2, 6);
                NSString *Address = str8 == NULL ? nil : [[NSString alloc] initWithUTF8String:str8];
                
                const char* str9 = (const char*)sqlite3_column_text(statement2, 7);
                NSString *Website = str9 == NULL ? nil : [[NSString alloc] initWithUTF8String:str9];
                
                const char* str10 = (const char*)sqlite3_column_text(statement2, 8);
                NSString *InnerUrl = str10 == NULL ? nil : [[NSString alloc] initWithUTF8String:str10];
                
                const char* str11 = (const char*)sqlite3_column_text(statement2, 9);
                NSString *Lattitude = str11 == NULL ? nil : [[NSString alloc] initWithUTF8String:str11];
                
                const char* uid = (const char*)sqlite3_column_text(statement2, 10);
                NSString *userid = uid == NULL ? nil : [[NSString alloc] initWithUTF8String:uid];

                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"fieldId"];
                [tempdict setValue:level3 forKey:@"formid"];
                [tempdict setValue:Type forKey:@"level1id"];
                [tempdict setValue:Subtype forKey:@"level2id"];
                [tempdict setValue:Name forKey:@"level3id"];
                [tempdict setValue:Address forKey:@"dateCreated"];
                [tempdict setValue:Website forKey:@"dateModified"];
                [tempdict setValue:InnerUrl forKey:@"fieldval"];
                [tempdict setValue:Lattitude forKey:@"sectionid"];
                [tempdict setValue:userid forKey:@"uid"];

                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_detail_table.php?tbl=Form_data&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];
        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;
    }

}

-(void)SendMediatabledata
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    NSMutableArray *medianamearray=[[NSMutableArray alloc]init];

    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from MediaTable WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from MediaTable where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str6 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Subtype = str6 == NULL ? nil : [[NSString alloc] initWithUTF8String:str6];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str0 = (const char*)sqlite3_column_text(statement2, 6);
                NSString *Name1 = str0 == NULL ? nil : [[NSString alloc] initWithUTF8String:str0];

                const char* str11 = (const char*)sqlite3_column_text(statement2, 7);
                NSString *sectionid = str11 == NULL ? nil : [[NSString alloc] initWithUTF8String:str11];

                const char* str8 = (const char*)sqlite3_column_text(statement2, 8);
                NSString *Address = str8 == NULL ? nil : [[NSString alloc] initWithUTF8String:str8];
                
                const char* str9 = (const char*)sqlite3_column_text(statement2, 9);
                NSString *Website = str9 == NULL ? nil : [[NSString alloc] initWithUTF8String:str9];
                
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"medianame"];
                [tempdict setValue:level3 forKey:@"mediatype"];
                [tempdict setValue:Type forKey:@"formid"];
                [tempdict setValue:Subtype forKey:@"level1id"];
                [tempdict setValue:Name forKey:@"level2id"];
                [tempdict setValue:Name1 forKey:@"level3id"];
                [tempdict setValue:sectionid forKey:@"sectionid"];
                [tempdict setValue:Address forKey:@"dateCreated"];
                [tempdict setValue:Website forKey:@"dateModified"];
                
                if ([tempdict[@"mediatype"] isEqualToString:@"image"]) {
                    [medianamearray addObject:[NSString stringWithFormat:@"%@.png",tempdict[@"medianame"]]];
                }
                else
                    if ([tempdict[@"mediatype"] isEqualToString:@"video"]) {
                        [medianamearray addObject:[NSString stringWithFormat:@"%@.mp4",tempdict[@"medianame"]]];
                    }
                    else
                    {//audio
                        [medianamearray addObject:[NSString stringWithFormat:@"%@.caf",tempdict[@"medianame"]]];
                        
                    }

                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_media.php?tbl=media&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];
        [self SendJsondata:PhpdataAarry table:urltosend];
        
            for (int i=0; i<medianamearray.count; i++) {
            [self Uploadimag:[medianamearray objectAtIndex:i]];
        }
    }

}

-(void)Sendfieldtable
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from FieldDetailtable WHERE usertype='Liteuser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from FieldDetailtable where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str6 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Subtype = str6 == NULL ? nil : [[NSString alloc] initWithUTF8String:str6];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str0 = (const char*)sqlite3_column_text(statement2, 6);
                NSString *Name1 = str0 == NULL ? nil : [[NSString alloc] initWithUTF8String:str0];
                
                const char* lst2 = (const char*)sqlite3_column_text(statement2, 7);
                NSString *last2 = lst2 == NULL ? nil : [[NSString alloc] initWithUTF8String:lst2];
                
                const char* lst1 = (const char*)sqlite3_column_text(statement2, 8);
                NSString *last1 = lst1 == NULL ? nil : [[NSString alloc] initWithUTF8String:lst1];

                const char* str11 = (const char*)sqlite3_column_text(statement2, 9);
                NSString *sectionid = str11 == NULL ? nil : [[NSString alloc] initWithUTF8String:str11];
                
                const char* vs1 = (const char*)sqlite3_column_text(statement2, 10);
                NSString *visible = vs1 == NULL ? nil : [[NSString alloc] initWithUTF8String:vs1];
                
                const char* edt1 = (const char*)sqlite3_column_text(statement2, 11);
                NSString *editable = edt1 == NULL ? nil : [[NSString alloc] initWithUTF8String:edt1];

                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"fieldname"];
                [tempdict setValue:level3 forKey:@"fieldtype"];
                [tempdict setValue:Type forKey:@"formid"];
                [tempdict setValue:Subtype forKey:@"fieldno"];
                [tempdict setValue:Name forKey:@"dateCreated"];
                [tempdict setValue:Name1 forKey:@"dateModified"];
                [tempdict setValue:last2 forKey:@"sectionid"];
                [tempdict setValue:last1 forKey:@"fieldsubtitle"];
                [tempdict setValue:sectionid forKey:@"fielddescription"];
                [tempdict setValue:visible forKey:@"visible"];
                [tempdict setValue:editable forKey:@"editable"];
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/Form_meta.php?tbl=Form_meta&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];

        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;

    }
    
}

-(void)Sendtpformdata
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from tp_forms WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT * from tp_forms where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 7);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str0 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name1 = str0 == NULL ? nil : [[NSString alloc] initWithUTF8String:str0];
              
                const char* str11 = (const char*)sqlite3_column_text(statement2, 6);
                NSString *Name11 = str11 == NULL ? nil : [[NSString alloc] initWithUTF8String:str11];
                
                
                [tempdict setValue:level1 forKey:@"TableName"];
                [tempdict setValue:level2 forKey:@"ftid"];
                [tempdict setValue:level3 forKey:@"unique_id"];
                [tempdict setValue:Type forKey:@"formname"];
                [tempdict setValue:Name forKey:@"role_name"];
                [tempdict setValue:Name1 forKey:@"dateCreated"];
                [tempdict setValue:Name11 forKey:@"dateModified"];
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_tp_forms.php?tbl=tp_forms&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];

        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;

    }
    
}

-(void)SendLevelLables
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,formid,Level1_name,Level2_name,Level3_name,sectionid,dateCreated,dateModified from Levels WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,formid,Level1_name,Level2_name,Level3_name,sectionid,dateCreated,dateModified  from Levels where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str4 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *level4 = str4 == NULL ? nil : [[NSString alloc] initWithUTF8String:str4];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *level5 = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str0 = (const char*)sqlite3_column_text(statement2, 6);
                NSString *Name1 = str0 == NULL ? nil : [[NSString alloc] initWithUTF8String:str0];
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"formid"];
                [tempdict setValue:level3 forKey:@"level1_name"];
                [tempdict setValue:level4 forKey:@"level2_name"];
                [tempdict setValue:level5 forKey:@"level3_name"];
                [tempdict setValue:Name forKey:@"dateCreated"];
                [tempdict setValue:Name1 forKey:@"dateModified"];
                
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/level_labels.php?tbl=level_labels&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];
        
        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;

    }
    
}


-(void)SendLevel1data
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,formid,level1_data,dateCreated,dateModified from tp_level1_master WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,formid,level1_data,dateCreated,dateModified from tp_level1_master where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                             const char* str7 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str0 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Name1 = str0 == NULL ? nil : [[NSString alloc] initWithUTF8String:str0];
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"formid"];
                [tempdict setValue:level3 forKey:@"level1_data"];
                [tempdict setValue:Name forKey:@"dateCreated"];
                [tempdict setValue:Name1 forKey:@"dateModified"];
                
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_tp_level1_master.php?tbl=tp_level1_master&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];

        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;

    }
    
}

-(void)SendLevel2data
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,level1_id,level2_data,dateCreated,dateModified from tp_level2_master WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,level1_id,level2_data,dateCreated,dateModified from tp_level2_master where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
             
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"level1_id"];
                [tempdict setValue:level3 forKey:@"level2_data"];
                [tempdict setValue:Type forKey:@"dateCreated"];
                [tempdict setValue:Name forKey:@"dateModified"];
                
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_tp_level2_master.php?tbl=tp_level2_master&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];

        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;

    }
    
}

-(void)SendLevel3data
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,level1_id,level2_id,level3_data,dateCreated,dateModified from tp_level3_master WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT rowid,level1_id,level2_id,level3_data,dateCreated,dateModified from tp_level3_master where  dateModified >= '%@' AND usertype='Prouser'",mainDelegate.LastSyncdate];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 3);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                const char* str7 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Name = str7 == NULL ? nil : [[NSString alloc] initWithUTF8String:str7];
                
                const char* str0 = (const char*)sqlite3_column_text(statement2, 5);
                NSString *Name1 = str0 == NULL ? nil : [[NSString alloc] initWithUTF8String:str0];
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"level1_id"];
                [tempdict setValue:level3 forKey:@"level2_id"];
                [tempdict setValue:Type forKey:@"level3_data"];
                [tempdict setValue:Name forKey:@"dateCreated"];
                [tempdict setValue:Name1 forKey:@"dateModified"];
                
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_tp_level3_master.php?tbl=tp_level3_master&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];
        
        [self SendJsondata:PhpdataAarry table:urltosend];
        PhpdataAarry=nil;

    }
    
}

-(void)sendDeleteddata
{
    
    NSMutableArray *DetailArray=[self getOperationTabledata];
    for (int i=0; i<DetailArray.count; i++)
    {
        NSDictionary *tempdict=[DetailArray objectAtIndex:i];
        NSString *urlStr=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/update_deleteflag.php?table=%@&formid=%@",tempdict[@"tablename"],tempdict[@"formid"]];
        NSString *URLstr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURL *url = [NSURL URLWithString:URLstr];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *err) {
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",responseString);
        
        }];
    }

}

-(NSMutableArray *)getOperationTabledata
{
    NSMutableArray *temparray=[[NSMutableArray alloc]init];
    NSString *query=@"SELECT * FROM OperationTable";
    [SharedobjDb openDB];
    sqlite3_stmt *statement;
    sqlite3 *objdb=SharedobjDb.sDB;
    if (sqlite3_open(SharedobjDb.dbpath, &objdb) == SQLITE_OK)
	{
		const char *query_stmt = [query UTF8String];
        
		if (sqlite3_prepare_v2(objdb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                const char* name1 = (const char*)sqlite3_column_text(statement, 1);
                NSString *name = name1== NULL ? @"" : [[NSString alloc] initWithUTF8String:name1];
                [tempdict setValue:name forKey:@"formid"];
                
                const char* zonename1 = (const char*)sqlite3_column_text(statement, 2);
                NSString *Username = zonename1== NULL ? @"" : [[NSString alloc] initWithUTF8String:zonename1];
                [tempdict setValue:Username forKey:@"tablename"];
                
                [temparray addObject:tempdict];
                tempdict=nil;
            }
        }
        sqlite3_finalize(statement);
    }
    return temparray;
}

-(void)sendSectiontabledata
{
    NSMutableArray *PhpdataAarry=[[NSMutableArray alloc]init];
    [SharedobjDb openDB];
    sqlite3_stmt *statement2 = nil;
    
    if (sqlite3_open(SharedobjDb.dbpath, &sDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (mainDelegate.Alldataflag)
        {
            querySQL= [NSString stringWithFormat:@"SELECT *from SectionTable WHERE usertype='Prouser'"];
            
        }
        else
        {
            querySQL= [NSString stringWithFormat:@"SELECT *from SectionTable WHERE usertype='Prouser'"];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                NSMutableDictionary *tempdict=[[NSMutableDictionary alloc]init];
                
                const char* str1 = (const char*)sqlite3_column_text(statement2, 0);
                NSString *level1 = str1 == NULL ? nil : [[NSString alloc] initWithUTF8String:str1];
                
                const char* str2 = (const char*)sqlite3_column_text(statement2, 1);
                NSString *level2 = str2 == NULL ? nil : [[NSString alloc] initWithUTF8String:str2];
                
                const char* str3 = (const char*)sqlite3_column_text(statement2, 2);
                NSString * level3=str3 == NULL ? nil : [[NSString alloc] initWithUTF8String:str3];
                
                const char* str5 = (const char*)sqlite3_column_text(statement2, 4);
                NSString *Type = str5 == NULL ? nil : [[NSString alloc] initWithUTF8String:str5];
                
                
                [tempdict setValue:level1 forKey:@"unique_id"];
                [tempdict setValue:level2 forKey:@"Name"];
                [tempdict setValue:level3 forKey:@"formid"];
                [tempdict setValue:Type forKey:@"hidden"];
              
                
                
                [PhpdataAarry addObject:tempdict];
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(sDB);
    }
    
    if (PhpdataAarry.count>0)
    {
        NSString *urltosend= [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/insert_section_data.php?tbl=Section&uid=%@&cid=%@",mainDelegate.Uid,mainDelegate.Companyid];
        
        [self SendJsondata:PhpdataAarry table:urltosend];
      
        PhpdataAarry=nil;
    }
    
}


-(void)Sendtoserver:(NSMutableArray*)Array
{
    NSMutableDictionary *tempdata=[[NSMutableDictionary alloc]init];
    for (int i=0; i<Array.count; i++)
    {
    tempdata=[Array objectAtIndex:i];
    NSString *urlStr;
    
         urlStr = [NSString stringWithFormat:@"http://ira-infosolutions.com/WebService/submitdata1.php?type=%@&subtype=%@&name=%@&address=%@&website=%@&innerurl=%@&latitude=%@&longitude=%@&description=%@&products=%@&landmarks=%@&timings=%@&payment=%@&special=%@&directions=%@&parkings=%@&images=%@&datacapturestatus=%@&verifiedstatus=%@&noname=%@",tempdata[@"Type"],tempdata[@"Subtype"],tempdata[@"Name"],tempdata[@"Address"],tempdata[@"Website"],tempdata[@"InnerUrl"],tempdata[@"Lattitude"],tempdata[@"Longitude"],tempdata[@"Description"],tempdata[@"Products_Services"],tempdata[@"Landmark"],tempdata[@"Timing"],tempdata[@"Payment"],tempdata[@"Special"],tempdata[@"Direction"],tempdata[@"Parking"],tempdata[@"Image"],tempdata[@"Datacapturestatus"],tempdata[@"Verifiedstatus"],tempdata[@"Noname"]];
    
    NSString *URLstr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url = [NSURL URLWithString:URLstr];
    
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Array options:0 error:nil];
    
    //NSArray *jsonArray=[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
        
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *err) {
        
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",responseString);
        
    }];
}
}


-(void)SendJsondata:(NSMutableArray *)Array table:(NSString*)Urlstr
{
//      NSMutableDictionary *myDic = [NSMutableDictionary dictionary];
//    for (int i=0; i<Array.count; i++)
//    {
//        NSMutableDictionary *tempdict=[Array objectAtIndex:i];
//        [myDic addEntriesFromDictionary:tempdict];
//    }

       
    NSString *urlString =Urlstr;//
    urlString= [Urlstr stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:100.0];
    
    NSError *error;
    
    [request setTimeoutInterval:100.0];
    
    [request setURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *paramsJSONDictionaryData = [NSJSONSerialization dataWithJSONObject:Array options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonParamsString = [[NSString alloc] initWithData:paramsJSONDictionaryData encoding:NSUTF8StringEncoding];
    
    [body appendData:[[NSString stringWithFormat:@"%@\r\n",jsonParamsString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSLog(@"%@",[[NSString alloc] initWithData:paramsJSONDictionaryData encoding:NSUTF8StringEncoding]);
    
    [request setHTTPBody:body];
    
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (responseData==nil) {
        return;
    }
    NSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);

    NSDictionary *jsonResponseDictionary = [NSJSONSerialization JSONObjectWithData: responseData
                                            
                                                                           options:kNilOptions
                                            
                                                                             error:&error];
    
    NSLog(@"%@",jsonResponseDictionary);
}


#pragma mark:..

-(void)Syncdetailtable
{
   NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_detail_table.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
    //    NSString *returnString=nil;;
    //    NSArray *strretun;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error=nil;
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
//     {
         if(data)
         {
             NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"urlResponse: %@",returnString);
             if (returnString==nil) {
                 returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             }
             NSLog(@"%@",returnString);
             
             
             NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
             if (strretun1==NULL) {
                 return;
             }

             NSLog(@"%@",strretun1);
             
             for (int i=0; i<strretun1.count; i++) {
             
                 NSDictionary *tempdict=[strretun1 objectAtIndex:i];
                 BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM DetailTable WHERE id=%@ AND usertype='Prouser'",tempdict[@"unique_id"]]];
                 
                 if (!Flag) {
                     NSString *sql_query =[NSString stringWithFormat:@"insert into DetailTable (fieldid,formid,level1id,level2id,level3id,dateCreated,dateModified,fieldval,sectionid,uid,usertype) Values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",tempdict[@"fieldId"],tempdict[@"formid"],tempdict[@"level1id"],tempdict[@"level2id"],tempdict[@"level3id"],tempdict[@"dateCreated"],tempdict[@"dateModified"],tempdict[@"fieldval"],tempdict[@"sectionid"],tempdict[@"uid"],mainDelegate.UserType];
                     
                     [SharedobjDb InsertRecord:sql_query];
                 }
                 else
                 {
                     NSLog(@"update pesent no need to add");
                 }
             }
             
             [self Syncmediatable];         //
             HUD.progress = 0.3f;           // commented by ajinkya
             
        }
         else
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert1 show];
         }
//     }];

}

-(void)Syncmediatable
{
    NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_media.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
    //    NSString *returnString=nil;;
    //    NSArray *strretun;
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
//     {
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error=nil;
         if(data)
         {
             NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"urlResponse: %@",returnString);
             if (returnString==nil) {
                 returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             }
             NSLog(@"%@",returnString);
             
             NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
             if (strretun1==NULL) {
                 return;
             }
             NSLog(@"%@",strretun1);
             NSMutableArray *medianamearray=[[NSMutableArray alloc]init];

             for (int i=0; i<strretun1.count; i++) {
                 
                 NSDictionary *tempdict=[strretun1 objectAtIndex:i];
                 if ([tempdict[@"mediatype"] isEqualToString:@"image"]) {
                     [medianamearray addObject:[NSString stringWithFormat:@"%@.png",tempdict[@"medianame"]]];
                 }
                 else
                     if ([tempdict[@"mediatype"] isEqualToString:@"video"]) {
                         [medianamearray addObject:[NSString stringWithFormat:@"%@.mp4",tempdict[@"medianame"]]];
                     }
                     else
                      {//audio
                          [medianamearray addObject:[NSString stringWithFormat:@"%@.caf",tempdict[@"medianame"]]];

                      }
      
                         BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM MediaTable  WHERE medianame='%@' usertype='Prouser'",tempdict[@"medianame"]]];//AND dateModified>=mainDelegate.lastSyncdate
                 
                 if (!Flag) {
                     NSString *sql_query =[NSString stringWithFormat:@"insert into MediaTable (medianame,mediatype,formid,level1id,level2id,level3id,dateCreated,dateModified,sectionid,usertype)Values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",tempdict[@"medianame"],tempdict[@"mediatype"],tempdict[@"formid"],tempdict[@"level1id"],tempdict[@"level2id"],tempdict[@"level3id"],tempdict[@"dateCreated"],tempdict[@"dateModified"],tempdict[@"sectionid"],mainDelegate.UserType];
                     
                     [SharedobjDb InsertRecord:sql_query];
                 }
                 else
                 {
                     NSLog(@"update pesent no need to add");
                 }
             }
             
             //saveimage
            NSOperationQueue *queu= [[NSOperationQueue alloc]init];
             [queu addOperationWithBlock:^{
                 for (int i=0; i<medianamearray.count; i++) {
                     [self saveimage:[medianamearray objectAtIndex:i]];
                 }
             }];
             
             
             [self SyncLevel1:nil];         //
             HUD.progress = 0.4f;           // Added by ajinkya
             
         }
         else
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert1 show];
         }
//     }];

}

//fielddetail table
-(void)Syncfieldtable
{
    NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_Form_meta.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
    //    NSString *returnString=nil;;
//    //    NSArray *strretun;
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
//     {
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error=nil;
         if(data)
         {
             NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"urlResponse: %@",returnString);
             if (returnString==nil) {
                 returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             }
             NSLog(@"%@",returnString);
             
             NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
             
             NSLog(@"%@",strretun1);
             
             for (int i=0; i<strretun1.count; i++) {
                 
                 NSDictionary *tempdict=[strretun1 objectAtIndex:i];
                 BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM FieldDetailtable  WHERE id=%@ usertype='Prouser'",tempdict[@"unique_id"]]];
                 
                 if (!Flag) {
                     NSString *sql_query =[NSString stringWithFormat:@"insert into FieldDetailtable (fieldname,fieldtype,formid,fieldno,fieldsubtitle,dateCreated,dateModified,sectionid,usertype) Values('%@','%@','%@','%@','%@','%@','%@','%@','%@')",tempdict[@"fieldname"],tempdict[@"fieldtype"],tempdict[@"formid"],tempdict[@"fieldno"],tempdict[@"fieldsubtitle"],tempdict[@"dateCreated"],tempdict[@"dateModified"],tempdict[@"sectionid"],mainDelegate.UserType];
                     
                     [SharedobjDb InsertRecord:sql_query];
                 }
                 else
                 {
                     NSLog(@"update pesent no need to add");
                 }
             }
             
        }
         else
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert1 show];
         }
//     }];
    
}


//tp_level1
-(void)SyncLevel1:(NSMutableDictionary*)Tabledict
{
    NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_tp_level1_master.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
    //    NSString *returnString=nil;;
    //    NSArray *strretun;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
     {
         if(data)
         {
             NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"urlResponse: %@",returnString);
             if (returnString==nil) {
                 returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             }
             NSLog(@"%@",returnString);
             
             NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
             
             NSLog(@"%@",strretun1);
             
             for (int i=0; i<strretun1.count; i++) {
                 
                 NSDictionary *tempdict=[strretun1 objectAtIndex:i];
                 BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM tp_level1_master WHERE rowid=%@ usertype='Prouser' ",tempdict[@"unique_id"]]];
                 
                 if (!Flag) {
                     NSString *sql_query =[NSString stringWithFormat:@"insert into tp_level1_master (rowid,formid,level1_data,dateCreated,dateModified,usertype) Values('%@','%@','%@','%@','%@','%@')",tempdict[@"unique_id"],tempdict[@"formid"],tempdict[@"level1_data"],tempdict[@"dateCreated"],tempdict[@"dateModified"],mainDelegate.UserType];
                     
                     [SharedobjDb InsertRecord:sql_query];
                 }
                 else
                 {
                     NSLog(@"update pesent no need to add");
                 }
             }
             
             [self SyncLevel2];             //
             HUD.progress = 0.5f;           //  Added by ajinkya
             
         }
         else
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert1 show];
         }
     }];
    
    
}

//tp_level2
-(void)SyncLevel2
{

        NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_tp_level2_master.php?cid=%@",mainDelegate.Companyid];
        NSLog(@" URL : %@",urlString1);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        [request setURL:[NSURL URLWithString:urlString1]];
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error=nil;
             if(data)
             {
                 NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 NSLog(@"urlResponse: %@",returnString);
                 if (returnString==nil) {
                     returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                 }
                 NSLog(@"%@",returnString);
                 
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 
                 NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
                 
                 NSLog(@"%@",strretun1);
                 
                 for (int i=0; i<strretun1.count; i++) {
                     
                     NSDictionary *tempdict=[strretun1 objectAtIndex:i];
                     BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM tp_level2_master WHERE rowid=%@ usertype='Prouser'",tempdict[@"unique_id"]]];
                     
                     if (!Flag) {
                         NSString *sql_query =[NSString stringWithFormat:@"insert into tp_level2_master (rowid,level1_id,level2_data,dateCreated,dateModified,usertype) Values('%@','%@','%@','%@','%@','%@')",tempdict[@"unique_id"],tempdict[@"level1_id"],tempdict[@"level2_data"],tempdict[@"dateCreated"],tempdict[@"dateModified"],mainDelegate.UserType];
                         
                         [SharedobjDb InsertRecord:sql_query];
                     }
                     else
                     {
                         NSLog(@"update pesent no need to add");
                     }
                 }
                 
                 [self SyncLevel3];             //
                 HUD.progress = 0.6f;           //  Added by ajinkya
                 
             }
             else
             {
                 UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                 [alert1 show];
             }
//         }];
    
}


//tp_level3
-(void)SyncLevel3
{
    NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_tp_level3_master.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
    //    NSString *returnString=nil;;
    //    NSArray *strretun;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
     {
         if(data)
         {
             NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"urlResponse: %@",returnString);
             if (returnString==nil) {
                 returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             }
             NSLog(@"%@",returnString);
             
             NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
             
             NSLog(@"%@",strretun1);
             
             for (int i=0; i<strretun1.count; i++) {
                 
                 NSDictionary *tempdict=[strretun1 objectAtIndex:i];
                 BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM tp_level3_master WHERE rowid=%@ usertype='Prouser'",tempdict[@"unique_id"]]];
                 
                 if (!Flag) {
                     NSString *sql_query =[NSString stringWithFormat:@"insert into tp_level3_master (rowid,level3_data,level1_id,level2_id,dateCreated,dateModified,usertype) Values('%@','%@','%@','%@','%@','%@','%@')",tempdict[@"unique_id"],tempdict[@"level3_data"],tempdict[@"level1_id"],tempdict[@"level2_id"],tempdict[@"dateCreated"],tempdict[@"dateModified"],mainDelegate.UserType];
                     
                     [SharedobjDb InsertRecord:sql_query];
                 }
                 else
                 {
                     NSLog(@"update pesent no need to add");
                 }
             }
             
             [self Syncformdetails];            //
             HUD.progress = 0.7f;               // added by ajinkya
             
         }
         else
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert1 show];
         }
     }];
    
    
}



//tp_level status
//formtable,level label,field detail,appdetail
-(void)Syncformdetails
{
    if (!mainDelegate.checkInternet) {
        UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load Initial data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert2 show];
        return;
    }
    NSString*urlString1;
    
    urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_initial_detail.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
  
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error=nil;
         if(data)
         {
             NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"urlResponse: %@",returnString);
             if (returnString==nil) {
                 returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             }
             NSLog(@"%@",returnString);
             
             NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
                NSArray *strretun1=[dataDictionary valueForKey:@"tp_forms"];//[returnString
             NSArray *strretun2=[dataDictionary valueForKey:@"form_names"];
             NSArray *strretun3=[dataDictionary valueForKey:@"labels"];
             NSArray *strretun4=[dataDictionary valueForKey:@"field_detail"];
             NSArray *strretun5=[dataDictionary valueForKey:@"appDetails"];
             NSArray *strretun6=[dataDictionary valueForKey:@"section"];
             NSArray *strretun7=[dataDictionary valueForKey:@"tp_level1_master"];
             NSArray *strretun8=[dataDictionary valueForKey:@"tp_level2_master"];
             NSArray *strretun9=[dataDictionary valueForKey:@"tp_level3_master"];

             NSArray *array=[NSArray arrayWithObjects:strretun1,strretun2,strretun3,strretun4,strretun5,strretun6,strretun7,strretun8,strretun9, nil];
             //             strretun=[NSMutableArray arrayWithArray:strretun1];
             //             NSLog(@"%@",strretun1);
             [self Insertintotable:array];
             
             [self SyncTpforms];        //
             HUD.progress = 0.3f;       // added by ajinkya
             
         }
         else
         {
             UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert2 show];
         }
//     }];
    
}



-(void)Insertintotable:(NSArray*)Temparray
{
    //    [ObjSharedDb openDB];
    
    NSArray *Temparray1=[Temparray objectAtIndex:0];
    NSArray *Temparray2=[Temparray objectAtIndex:1];
    NSArray *Temparray3=[Temparray objectAtIndex:2];
    NSArray *Temparray4=[Temparray objectAtIndex:3];
    NSArray *Temparray5=[Temparray objectAtIndex:4];
    NSArray *Temparray6=[Temparray objectAtIndex:5];
    NSArray *Temparray7=[Temparray objectAtIndex:6];
    NSArray *Temparray8=[Temparray objectAtIndex:7];
    NSArray *Temparray9=[Temparray objectAtIndex:8];

    NSString *query=[NSString stringWithFormat:@"DELETE FROM tp_forms"];
    [SharedobjDb ExexuteOperation:query];
    
    NSString *query1=[NSString stringWithFormat:@"DELETE FROM Formtable"];
    [SharedobjDb ExexuteOperation:query1];
    
    NSString *query2=[NSString stringWithFormat:@"DELETE FROM Levels"];
    [SharedobjDb ExexuteOperation:query2];
    
    NSString *query3=[NSString stringWithFormat:@"DELETE FROM FieldDetailtable"];
    [SharedobjDb ExexuteOperation:query3];
    
    NSString *query4=[NSString stringWithFormat:@"DELETE FROM AppdetailTable"];
    [SharedobjDb ExexuteOperation:query4];
    
    NSString *query5=[NSString stringWithFormat:@"DELETE FROM tp_level1_master"];
    [SharedobjDb ExexuteOperation:query5];
    
    NSString *query6=[NSString stringWithFormat:@"DELETE FROM tp_level2_master"];
    [SharedobjDb ExexuteOperation:query6];
    
    NSString *query7=[NSString stringWithFormat:@"DELETE FROM tp_level3_master"];
    [SharedobjDb ExexuteOperation:query7];
    
    NSString *query8=[NSString stringWithFormat:@"DELETE FROM SectionTable"];
    [SharedobjDb ExexuteOperation:query8];
    
    NSString *query9=[NSString stringWithFormat:@"DELETE FROM DetailTable"];
    [SharedobjDb ExexuteOperation:query9];
    
    
    
    if (Temparray1 != (id)[NSNull null])
    {
        for (int i=0; i< [Temparray1 count];i++)
        {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_forms(TableNmae,id,ftid,form_name,role_name,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",[[Temparray1 objectAtIndex:i] valueForKey:@"TableName"],[[Temparray1 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray1 objectAtIndex:i] valueForKey:@"ftid"],[[Temparray1 objectAtIndex:i] valueForKey:@"form_name"],[[Temparray1 objectAtIndex:i] valueForKey:@"role_name"],[[Temparray1 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray1 objectAtIndex:i] valueForKey:@"dateModified"],mainDelegate.UserType];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }
   
    }
    
    if (Temparray2 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray2.count;i++) {
            
            NSString *queryMax=@"SELECT MAX(id) FROM Formtable";
            int mid= [[SharedobjDb Getmaxid:queryMax ForTable:@"Formtable"] intValue];
            mid++;
            
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO Formtable(id,Formname,dateCreated,dateModified,usertype) VALUES ('%d','%@','%@','%@','%@')",mid,[[Temparray2 objectAtIndex:i] valueForKey:@"formname"],[[Temparray2 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray2 objectAtIndex:i] valueForKey:@"dateModified"],mainDelegate.UserType];//[[Temparray2 objectAtIndex:i] valueForKey:@"unique_id"]
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }

    }
    
    if (Temparray3 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray3.count;i++) {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO Levels(rowid,formid,Level1_name,Level2_name,Level3_name,sectionid,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",[[Temparray3 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray3 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray3 objectAtIndex:i] valueForKey:@"level1_name"],[[Temparray3 objectAtIndex:i] valueForKey:@"level2_name"],[[Temparray3 objectAtIndex:i] valueForKey:@"level3_name"],[[Temparray3 objectAtIndex:i] valueForKey:@"sectionid"],[[Temparray3 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray3 objectAtIndex:i] valueForKey:@"dateModified"],mainDelegate.UserType];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }

    }
    
    if (Temparray4 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray4.count;i++) {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO FieldDetailtable(id,formid,fieldname,fieldtype,fieldno,sectionid,fielddescription,fieldsubtitle,editable,visible,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",[[Temparray4 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray4 objectAtIndex:i] valueForKey:@"formid"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldname"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldtype"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldno"],[[Temparray4 objectAtIndex:i] valueForKey:@"sectionid"],[[Temparray4 objectAtIndex:i] valueForKey:@"fielddescription"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldsubtitle"],[[Temparray4 objectAtIndex:i] valueForKey:@"editable"],[[Temparray4 objectAtIndex:i] valueForKey:@"visible"],[[Temparray4 objectAtIndex:i] valueForKey:@"dateCreated"] ,[[Temparray4 objectAtIndex:i] valueForKey:@"dateModified"],mainDelegate.UserType];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }
 
    }
    
    if (Temparray5 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray5.count;i++) {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO AppdetailTable(id,no_of_audio,no_of_fields,no_of_forms,no_of_image,no_of_sections,no_of_video,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",[[Temparray5 objectAtIndex:i] valueForKey:@"id"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_audio"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_fields"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_forms"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_image"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_sections"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_video"],[[Temparray5 objectAtIndex:i] valueForKey:@"usertype"]];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }

    }
    
    if (Temparray6 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray6.count;i++) {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO SectionTable(id,section_name,formid,usertype,sid) VALUES ('%@','%@','%@','%@','%@')",[[Temparray6 objectAtIndex:i] valueForKey:@"Id"],[[Temparray6 objectAtIndex:i] valueForKey:@"Name"],[[Temparray6 objectAtIndex:i] valueForKey:@"formid"],mainDelegate.UserType,[[Temparray6 objectAtIndex:i] valueForKey:@"sid"]];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }

    }
    if (Temparray7 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray7.count;i++) {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_level1_master(rowid,formid,level1_data,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@')",[[Temparray7 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray7 objectAtIndex:i] valueForKey:@"formid"],[[Temparray7 objectAtIndex:i] valueForKey:@"level1_data"],[[Temparray7 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray7 objectAtIndex:i] valueForKey:@"dateModified"],mainDelegate.UserType];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }

    }
    
    if (Temparray8 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray8.count;i++) {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_level2_master(rowid,level1_id,level2_data,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@')",[[Temparray8 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray8 objectAtIndex:i] valueForKey:@"level1_id"],[[Temparray8 objectAtIndex:i] valueForKey:@"level2_data"],[[Temparray8 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray8 objectAtIndex:i] valueForKey:@"dateModified"],mainDelegate.UserType];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }

    }
    
    if (Temparray9 != (id)[NSNull null])
    {
        for (int i=0; i< Temparray9.count;i++) {
            
            NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_level3_master(rowid,level3_data,level2_id,level1_id,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@')",[[Temparray9 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray9 objectAtIndex:i] valueForKey:@"level3_data"],[[Temparray9 objectAtIndex:i] valueForKey:@"level2_id"],[[Temparray9 objectAtIndex:i] valueForKey:@"level1_id"],[[Temparray9 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray9 objectAtIndex:i] valueForKey:@"dateModified"],mainDelegate.UserType];
            
            BOOL Result= [SharedobjDb ExexuteOperation:query];
            
            NSLog(@"%d",Result);
        }
   
    }
}

-(BOOL)saveimage:(NSString*)imageurl
{
    NSArray *arr=[imageurl componentsSeparatedByString:@"."];
    NSString *type=[arr objectAtIndex:1];
    if ([type isEqualToString:@"caf"]) {
        type=[NSString stringWithFormat:@"audio/%@",imageurl];
    }
    else
        if ([type isEqualToString:@"mp4"]) {
            type=[NSString stringWithFormat:@"video/%@",imageurl];

        }
    else
        if ([type isEqualToString:@"png"]) {
            type=[NSString stringWithFormat:@"images/%@",imageurl];

        }
    else
    {

    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
//        NSString *n=@"";
//        n=[NSString stringWithFormat:@"%d",arc4random()];
        NSData *imagedata;
        if (imageurl.length>1) {
            imagedata=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/uploads/%@",type]]];
            
        }
        else
            imagedata=nil;
   
        if (imagedata!=nil)
        {
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageurl]];
            [imagedata writeToFile:savedImagePath atomically:NO];
            
            return YES;
 
    }
    
    return NO;
}

//sync tp_forms
//level labels,formtable
-(void)SyncTpforms
{
    
    NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_tp_forms.php?cid=%@",mainDelegate.Companyid];
    NSLog(@" URL : %@",urlString1);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString1]];
    //    NSString *returnString=nil;;
    //    NSArray *strretun;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
     {
         if(data)
         {
             NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"urlResponse: %@",returnString);
             if (returnString==nil) {
                 returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
             }
             NSLog(@"%@",returnString);
             
             NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
             
             NSLog(@"%@",strretun1);
             
             for (int i=0; i<strretun1.count; i++) {
                 
                 NSDictionary *tempdict=[strretun1 objectAtIndex:i];
                 BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM tp_forms WHERE id=%@ AND usertype=Prouser",tempdict[@"unique_id"]]];
                 
                 if (!Flag) {
                     NSString *sql_query =[NSString stringWithFormat:@"INSERT INTO tp_forms(id,ftid,form_name,TableNmae,role_name,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",[tempdict valueForKey:@"unique_id"],[tempdict valueForKey:@"ftid"],[tempdict valueForKey:@"form_name"],[tempdict valueForKey:@"TableName"],[tempdict valueForKey:@"role_name"],[tempdict valueForKey:@"dateCreated"],[tempdict valueForKey:@"dateModified"],mainDelegate.UserType];
                     
                     [SharedobjDb InsertRecord:sql_query];
                 }
                 else
                 {
                     NSLog(@"update pesent no need to add");
                 }
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 [HUD removeFromSuperview];
                 UIAlertView *alert11=[[UIAlertView alloc]initWithTitle:@"Data synchronization successful." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert11 show];
                 mainDelegate.LastSyncdate=[mainDelegate Getcurrentdate];
                 
             });
             
         }
         else
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert1 show];
         }
     }];
    
}


//syn login tabel
-(void)SynLogintables
{
    
        NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_tp_role_user.php?cid=%@",mainDelegate.Companyid];
        NSLog(@" URL : %@",urlString1);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        [request setURL:[NSURL URLWithString:urlString1]];
        //    NSString *returnString=nil;;
        //    NSArray *strretun;
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
         {
             if(data)
             {
                 NSString *returnString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 NSLog(@"urlResponse: %@",returnString);
                 if (returnString==nil) {
                     returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                 }
                 NSLog(@"%@",returnString);
                 
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 
                 NSArray *strretun1=[dataDictionary valueForKey:@"data"];//[returnString
                 
                 NSLog(@"%@",strretun1);
                 LoginArray=[NSMutableArray arrayWithArray:strretun1];
                 [self RecordInsertQuery];
                 
                
                [self Syncdetailtable];    //
                HUD.progress = 0.2f;       // added by ajinkya
                

            }
             else
             {
                 UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                 [alert1 show];
             }
         }];
    
}

#pragma mark:database operations
-(void)RecordInsertQuery
{
    [SharedobjDb openDB];
    int res = SQLITE_ERROR;
//    int res1 = SQLITE_ERROR;
    
    res = sqlite3_open(SharedobjDb.dbpath, &sDB);
	
    sqlite3_stmt *updStmt = nil;
    
    for (int i=0;i<LoginArray.count;i++ )
    {
        
        //insert user table
        NSMutableDictionary *tempdict=[LoginArray objectAtIndex:i];
        NSString *str1 = [tempdict valueForKey:@"rid"];
        NSString *name = [tempdict valueForKey:@"name"];
        NSString *username =  [tempdict valueForKey:@"username"];
        NSString *password =  [tempdict valueForKey:@"password"];
        NSString *email =  [tempdict valueForKey:@"email"];
        NSString *phone =  [tempdict valueForKey:@"phone"];
        NSString *rolename =  [tempdict valueForKey:@"role_name"];
        NSString *roledescp =  [tempdict valueForKey:@"role_desc"];
        NSString *rolepermission = @"";//[tempdict valueForKey:@"rolepermission"];
        NSString *Formnames =  [tempdict valueForKey:@"form_name"];
        
        BOOL Flag=[SharedobjDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM tp_users WHERE id=%@",str1]];
        
        if (!Flag)
        {
            
            NSString *querySQL = [NSString stringWithFormat: @"insert into tp_users (name,username,password,email,phone) values('%@','%@','%@','%@','%@')",name,username,password,email,phone];
            
            const char *sql = [querySQL UTF8String];
            //NSLog(@"%@", querySQL);
            
            [SharedobjDb openDB];
            char *err;
            
            if (sqlite3_exec(sDB, sql, NULL, NULL, &err)!= SQLITE_OK)
            {
                sqlite3_close(sDB);
                NSLog(@"Insert Records Fail");
            }
            else
            {
                NSLog(@"Insert Records SuccessFull");
                sqlite3_close(sDB);
            }
            
            //insert role table
            NSString *querySQL1 = [NSString stringWithFormat: @"insert into tp_roles(uid,role_permissions,role_name,role_desc,form_name) values('%d','%@','%@','%@','%@')",i+1,rolepermission,rolename,roledescp,Formnames];
            
            const char *sql1 = [querySQL1 UTF8String];
            //NSLog(@"%@", querySQL);
            
            
            [SharedobjDb openDB];
            char *err1;
            
            if (sqlite3_exec(sDB, sql1, NULL, NULL, &err1)!= SQLITE_OK)
            {
                sqlite3_close(sDB);
                NSLog(@"Insert Records Fail");
            }
            else
            {
                NSLog(@"Insert Records SuccessFull");
                sqlite3_close(sDB);
            }
            
            sqlite3_finalize(updStmt);
            sqlite3_close(sDB);
            
        }
    }
}

-(void)Uploadimag :(NSString*)Imagename
{
    NSMutableData *body;
    //    count++;
    NSData *imageData=nil;
    NSArray *arr=[Imagename componentsSeparatedByString:@"."];
    NSString *mediatype=[arr objectAtIndex:1];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:Imagename ];

    if ([mediatype isEqualToString:@"caf"]) {
        mediatype=@"audio";
//        NSString *file2 = [[NSBundle mainBundle] pathForResource:savedImagePath ofType:nil];
//        imageData = [[NSData alloc] initWithContentsOfFile:file2];
       
        NSURL *vidURL=[NSURL fileURLWithPath:savedImagePath];
        imageData = [NSData dataWithContentsOfURL:vidURL];


    }
    else
        if ([mediatype isEqualToString:@"mp4"]) {
            mediatype=@"video";
            NSURL *vidURL=[NSURL URLWithString:savedImagePath];
            imageData = [NSData dataWithContentsOfURL:vidURL];

        }
        else
            if ([mediatype isEqualToString:@"png"]) {
                mediatype=@"image";
                UIImage *img1  = [UIImage imageWithContentsOfFile:savedImagePath];
                if (!img1 || [UIImageJPEGRepresentation(img1, 0.1)length] <=0)
                {
                    imageData=nil;
                    return;
                }
                else
                    imageData = UIImageJPEGRepresentation(img1,0.6f);

            }

    
    
    NSData *returnData;
    NSString *returnString;
    
    NSString *URLstr=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/upload_image.php?type=%@",mediatype];
    
    NSLog(@" URL : %@",URLstr);
    
    URLstr = [URLstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:URLstr]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"--------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding: NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\";filename=\"%@\"\r\n",Imagename]dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (imageData!=nil) {
        [body appendData:imageData];
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //   [request setValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);
    
}

-(void)uploadimages:(NSString*)SqlQuery imgname:(NSString*)Imagename
{
    int count=0;
    NSMutableData *body;
    //    count++;
    NSData *imageData;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:Imagename ];
    
    
    UIImage *img1  = [UIImage imageWithContentsOfFile:savedImagePath];
    if (!img1 || [UIImageJPEGRepresentation(img1, 0.1)length] <=0)
        
    {
        imageData=nil;
        
    }
    else
        imageData = UIImageJPEGRepresentation(img1,0.6f);
    
    NSData *returnData;
    NSString *returnString;
    
    NSString *URLstr=SqlQuery;
    
    NSLog(@" URL : %@",URLstr);
    
    URLstr = [URLstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:URLstr]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"--------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding: NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile%d\";filename=\"myImage%d.png\"\r\n",count,count]dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (imageData!=nil) {
        [body appendData:imageData];
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPBody:body];
    
    returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);

    
}


#pragma mark:datecheck
-(int)comapredates:(NSString*)Datefromserver  Localdate :(NSString*)datefromlocal
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeStamp=[df dateFromString:Datefromserver];
    NSDate *serverDate=[df  dateFromString:datefromlocal];
    
    NSComparisonResult result = [timeStamp compare:serverDate];
    int val=100;
    switch (result)
    {
        case NSOrderedAscending:
            NSLog(@"%@ is greater than %@", [df stringFromDate:serverDate], [df stringFromDate:timeStamp]);
            val=1;
            break;
        case NSOrderedDescending:
            NSLog(@"%@ is less %@", [df stringFromDate:serverDate], [df stringFromDate:timeStamp]);
            val=-1;
            break;
        case NSOrderedSame:
            NSLog(@"%@ is equal to %@", [df stringFromDate:serverDate], [df stringFromDate:timeStamp]);
            val=0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", [df stringFromDate:serverDate], [df stringFromDate:timeStamp]);
            break;
    }
    return val;
}

- (NSString *) exctractStringFromTags : (NSString *) str : (NSString *)
                             startTag : (NSString *) endTag
{
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:str];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:startTag intoString:NULL] ;
        
        // find end of tag
        
        [theScanner scanUpToString:endTag intoString:&text] ;
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        text = [text stringByReplacingOccurrencesOfString:[NSString
                                                           stringWithFormat:@"%@",startTag] withString:@""];
        
    }
    
    return text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
