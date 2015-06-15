//
//  ZoneSelection.m
//  trackperformance
//
//  Created by Sanjay on 4/30/13.
//  Copyright (c) 2013 Trupti. All rights reserved.
//


//LEVEL 1Selection form
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#import "ZoneSelection.h"
@interface ZoneSelection ()

@end

@implementation ZoneSelection
@synthesize ZoneTable,Manageflag,Selectedform,Selectedformid;
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
    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    mainDelegate.SelectedBtn=0;
    ObjDb=[[DatabseInstance alloc]init];
  [self GetZonedetails];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *str=@"";
    if (mainDelegate.Levelnamearray!=nil &&  mainDelegate.Levelnamearray.count>0) {
        str=[mainDelegate.Levelnamearray objectAtIndex:0];
    }
    else
    str=@"Select Identifier1";//mainDelegate.Levelmsg;//@"Level Selection";
    
    self.navigationItem.hidesBackButton=YES;
    UIImageView *uprow;
    Zonetitlebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // int h=self.view.frame.size.height;
    if (!IS_IPHONE_5)
    {
        uprow=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 300, 43)];
        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        ZoneTable=[[UITableView alloc]initWithFrame:CGRectMake(10.0, 74.0, 300.0,self.view.frame.size.height-180)];
        Zonetitlebtn.frame = CGRectMake(60.0, 10, 200, 50);
        
    }
    else
    {
        uprow=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 300, 43)];
        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
        ZoneTable=[[UITableView alloc]initWithFrame:CGRectMake(10.0, 74.0, 300.0,self.view.frame.size.height-180)];
        Zonetitlebtn.frame = CGRectMake(60.0, 10, 200, 50);
        
    }
    img.image=[UIImage imageNamed:@"Background.png"];
    [self.view addSubview:img];

    if (Adjust_Height ==20) {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];
        
    }

    UIImageView *Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    Navbar.userInteractionEnabled=YES;
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=str;
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.backgroundColor=[UIColor clearColor];
    Title.textAlignment=NSTextAlignmentCenter;
    Title.textColor=[UIColor whiteColor];
    [Navbar addSubview:Title];

    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [Navbar addSubview:LogoutBtn];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+44, 320, self.view.frame.size.height-Adjust_Height)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,7,50,30);
    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [Navbar addSubview:button];
    
  
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(236,0,42,44);
    button1.tag=1000;
    [button1 setBackgroundImage:[UIImage imageNamed:@"Plus_N.png"] forState:UIControlStateNormal];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"Plus_P.png"] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(ManageLevel1detail:) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:button1];
    
//    uprow.image=[UIImage imageNamed:@"RowUp1.png"];
//    [view addSubview:uprow];
    
    UIImageView *downrow=[[UIImageView alloc]initWithFrame:CGRectMake(10,0, 310, 0.5)];
    downrow.image=[UIImage imageNamed:@"line.png"];
   // [self.view addSubview:downrow];

    
    UILabel *Title1=[[UILabel alloc]initWithFrame: CGRectMake(10.0, 10, 300, 50)];
    Title1.text=@"Select the Form Identifiers before you can enter data";
    Title1.font=[UIFont systemFontOfSize:13];
    Title1.lineBreakMode=NSLineBreakByWordWrapping;
    Title1.numberOfLines=2;
    Title1.backgroundColor=[UIColor clearColor];
    Title1.textAlignment=NSTextAlignmentCenter;
    [view addSubview:Title1];
    
//    Zonetitlebtn.titleLabel.textColor=[UIColor blackColor];
//    [Zonetitlebtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//    Zonetitlebtn.userInteractionEnabled=NO;
//    [Zonetitlebtn setTitle:@"Select the Form Identifiers before you can enter data" forState:UIControlStateNormal];
//    Zonetitlebtn.titleLabel.font=[UIFont boldSystemFontOfSize:13];
//     //    [Zonetitlebtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [view addSubview:Zonetitlebtn];
    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;

        ZoneTable.backgroundColor=[UIColor clearColor];
    [ZoneTable setDelegate:self];
     ZoneTable.separatorColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]];
    [ZoneTable setDataSource:self];
    ZoneTable.tableFooterView=downrow;
    ZoneTable.tableHeaderView=downrow;
    [view addSubview:ZoneTable];
    [ZoneTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    ZoneTable.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
  
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
    
    if (alertView.tag==1) {
        [self GetZonedetails];
        //        [txt resignFirstResponder];
        //        [self removeView];
    }

}

-(void)Logout
{
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [mainDelegate Showrootview];
    
}


- (void)removeView
{
    addfieldview.hidden=YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    if (txt)
        [txt resignFirstResponder];
}

-(void)Submitaction
{
    if (Levelmname.text.length>1 )
    {
//        if(Formname.text.length<1)
//        {
//            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please select the form name." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alert1 show];
//            [alert1 release];
//            return;
//        }
    [ObjDb openDB];
    
    [txt resignFirstResponder];
    
//    NSDateFormatter *formatter;
//    formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *Datestring = [formatter stringFromDate:[NSDate date]];

        NSString *insertQuery;
     
    //check present or not max id
        BOOL RecordExist=NO;
    NSString *query3 = [NSString stringWithFormat:@"SELECT level1_data FROM tp_level1_master where level1_data='%@' and formid='%d'",Levelmname.text,self.formid];
        
    sqlite3_stmt *statement3;
    if (sqlite3_prepare_v2(ObjDb.sDB, [query3 UTF8String], -1, &statement3, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement3) == SQLITE_ROW)
        {
            RecordExist=YES;
        }
        if (sqlite3_step(statement3) !=SQLITE_DONE) {NSLog(@"Error inserting to Steps");}
        sqlite3_finalize(statement3);

    }
      
        if (RecordExist)
        {
            insertQuery = [NSString stringWithFormat:@"update  tp_level1_master set level1_data='%@',Formname='%@',dateModified='%@' where rowid='%@'",Levelmname.text,Formname.text,[mainDelegate Getcurrentdate],Selctedid];

        }
        else
        {
//            NSString *levelid = @"0";
            [ObjDb openDB];
//            sqlite3_stmt *statement;
//            sqlite3 *objdb=ObjDb.sDB;
//            if (sqlite3_open(ObjDb.dbpath, &objdb) == SQLITE_OK)
//            {
//                NSString *sql_query;
//                sql_query=[NSString stringWithFormat:@"select max(rowid) from tp_level1_master where formid='%d'",self.formid];
//
//                const char *query_stmt = [sql_query UTF8String];
//            
//                if (sqlite3_prepare_v2(objdb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
//                {
//                    while (sqlite3_step(statement) == SQLITE_ROW)
//                    {
//                        const char* zonename1 = (const char*)sqlite3_column_text(statement, 0);
//                        levelid = zonename1== NULL ? @"0" : [[NSString alloc] initWithUTF8String:zonename1];
//                    }
//                }
//                sqlite3_finalize(statement);
//            }

        
            insertQuery = [NSString stringWithFormat:@"INSERT INTO tp_level1_master(level1_data,formid,dateCreated,dateModified,usertype) VALUES ('%@','%d','%@','%@','%@')",Levelmname.text ,self.formid,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];

       
        }
    char *err;
    if (sqlite3_exec(ObjDb.sDB, [insertQuery UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    {
        sqlite3_close(ObjDb.sDB);
        NSLog(@"Insert Records Fail");
    }
    else
    {
        NSLog(@"Insert Records SuccessFull");
        NSString *urlStr;
        if (RecordExist) {
            urlStr = [NSString stringWithFormat:@"http://ira-infosolutions.com/WebService/insert_level1_row.php?level1=%@&formname=%@&cid=%@&id=%@",Levelmname.text,Formname.text,mainDelegate.Companyid,Selctedid];

        }
        else
        urlStr = [NSString stringWithFormat:@"http://ira-infosolutions.com/WebService/insert_level1_row.php?level1=%@&formname=%@&cid=%@&id=",Levelmname.text,Formname.text,mainDelegate.Companyid];
        
        NSString *insertQuery1 = [NSString stringWithFormat:@"INSERT INTO OperationTable(OperationUrl,Tablename) VALUES ('%@','tp_level1')",urlStr];
        
        char *error;
        
        if (sqlite3_exec(ObjDb.sDB, [insertQuery1 UTF8String], NULL, NULL, &error)!= SQLITE_OK)
        {
            sqlite3_close(ObjDb.sDB);
            NSLog(@"Insert Records Fail");
        }
        else
        {
            NSLog(@"Insert Records SuccessFull");
            sqlite3_close(ObjDb.sDB);
            
        }
        //sqlite3_close(sDB);
        addfieldview.hidden=NO;

    }
        [self removedataView];
    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Identifier successfully added." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    alert1.tag=1;
    [alert1 show];
    }
    else
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the detail." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert1 show];

    }
}

-(void)popViewback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)LogoutClicked
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)GetZonedetails
{
    NSString *sql_query;
           sql_query=[NSString stringWithFormat:@"select level1_data,rowid from tp_level1_master where formid='%d'",self.formid];
    if(ZoneArray !=nil)
        ZoneArray=nil;
    
    ZoneArray=[[NSMutableArray alloc]init];
        
    if(ZoneidArray !=nil)
        ZoneidArray=nil;
    
    ZoneidArray=[[NSMutableArray alloc]init];
    
    if(Formsarray !=nil)
        Formsarray=nil;
    Formsarray=[[NSMutableArray alloc]init];
    
    [ObjDb openDB];
    sqlite3_stmt *statement;
    sqlite3 *objdb=ObjDb.sDB;
    if (sqlite3_open(ObjDb.dbpath, &objdb) == SQLITE_OK)
	{
        //select user id		
		const char *query_stmt = [sql_query UTF8String];
        
		if (sqlite3_prepare_v2(objdb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                const char* name1 = (const char*)sqlite3_column_text(statement, 0);
                NSString *name = name1== NULL ? @"" : [[NSString alloc] initWithUTF8String:name1];
                [ZoneArray addObject:name];
                const char* zonename1 = (const char*)sqlite3_column_text(statement, 1);
                NSString *Username = zonename1== NULL ? @"" : [[NSString alloc] initWithUTF8String:zonename1];
                [ZoneidArray addObject:Username];
            }
        }
    sqlite3_finalize(statement);
    }
    
    NSLog(@"%@ \n %@",ZoneArray,ZoneidArray);
//        for (int i=0; i<tempArr.count; i++) {
//            tempdict=[tempArr objectAtIndex:i];
//        
//            NSString *Zonestr = [tempdict valueForKey:@"LevelName"];
//            [ZoneArray addObject:Zonestr];
//            
//            NSString *Zoneid = [tempdict valueForKey:@"ID"];
//            [ZoneidArray addObject:Zoneid];
//
//        }
    
    //}
    
    [ZoneTable reloadData];
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


#pragma mark:tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Selectedtable isEqualToString:@"Form"])
    {
        return 33;
    }
    else
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([Selectedtable isEqualToString:@"Form"]) {
        return FormnameArray.count;
    }
    else
    return ZoneArray.count;
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
      
//        CALayer *separator = [CALayer layer];
//        separator.contents = (id)[UIImage imageNamed:@"Rowdivider.png"].CGImage;
//        separator.frame = CGRectMake(0, 54, self.view.frame.size.width, 2);
//        [cell.layer addSublayer:separator];
        
        UIImageView *cellview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"next.png"]];
        cellview.frame=CGRectMake(0, 0, 11, 18);
//        if (![Selectedtable isEqualToString:@"Form"])
            cell.accessoryView=cellview;
//        cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Row1.png"]];
        cell.backgroundColor=[UIColor clearColor];
        if ([Selectedtable isEqualToString:@"Form"]) {
            cell.textLabel.text=[ZoneArray objectAtIndex:indexPath.row];
        }
        else
        cell.textLabel.text=[ZoneArray objectAtIndex:indexPath.row];
        
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
         cell.textLabel.font=[UIFont systemFontOfSize:14];
        
        UILabel *zoneidlbl=[[UILabel alloc]init];
        zoneidlbl.text=[ZoneidArray objectAtIndex:indexPath.row];
        zoneidlbl.hidden=YES;
        [cell.contentView addSubview:zoneidlbl];
        
//        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        button1.frame = CGRectMake(240,10,25,25);
//        button1.tag=indexPath.row;
//        [button1 setBackgroundImage:[UIImage imageNamed:@"edit1.png"] forState:UIControlStateNormal];
//        [button1 setBackgroundImage:[UIImage imageNamed:@"Plus_P.png"] forState:UIControlStateSelected];
//        [button1 addTarget:self action:@selector(ManageLevel1detail:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:button1];
    
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Selectedtable isEqualToString:@"Form"])
    {
        Formname.text=[FormnameArray objectAtIndex:indexPath.row];
        Table.hidden=YES;
    }
    else
    {
        Level2rides *Objlevel2=[[Level2rides alloc]init];
        Objlevel2.Selectedzone=[ZoneidArray objectAtIndex:indexPath.row];
        Objlevel2.Zonelabel=[ZoneArray objectAtIndex:indexPath.row];
        
        //for getting zoneid
        
        UILabel *zoneidlbl=(UILabel*)[[tableView cellForRowAtIndexPath:indexPath].contentView.subviews objectAtIndex:1];
        Objlevel2.zoneid=zoneidlbl.text;
        
        //NSLog(@"%@",[ZoneidArray objectAtIndex:indexPath.row]);
        [self.navigationController pushViewController:Objlevel2 animated:YES];
    }
//    [newBackButton release];
    
}


#pragma  mark:manage detail
-(void)ManageLevel1detail:(id)Sender
{
    if (Present ) {
        return;
    }
    Present=1;
    int i=[Sender tag];
   
    if (detailview) {
        detailview=nil;
    }
    detailview=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320, self.view.frame.size.height-(Adjust_Height))];
//    detailview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    detailview.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    detailview.userInteractionEnabled=YES;
    [self.view addSubview:detailview];
       
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image.frame=CGRectMake(30,100, 520/2, 76/2);
    [detailview addSubview:image];
//    [image release];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 65,240, 25)];
    label.text=@"Add New Category";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor clearColor];
    [detailview addSubview:label];

    if (i!=1000)
    {
        Levelname=[ZoneArray objectAtIndex:i];
        Forselectmname=[Formsarray objectAtIndex:i];
        Selctedid=[ZoneidArray objectAtIndex:i];
        label.text=@"Update Category";
    }
    else
    {
        //        Selectedformcopy=Selectedform;
        //        Selectedform=@"";
        Selctedid=@"";
        Levelname=@"";
        Forselectmname=@"";
    }

    if (Levelmname) {
        Levelmname=nil;
    }
    
    Levelmname=[[UITextField alloc]initWithFrame:CGRectMake(35,100, 514/2, 76/2)];
    Levelmname.backgroundColor=[UIColor clearColor];
//    Levelmname.placeholder=@"Level name" ;
    Levelmname.delegate=self;
    Levelmname.autocapitalizationType=UITextAutocapitalizationTypeNone;
    Levelmname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Levelmname.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    [detailview addSubview:Levelmname];
    Levelmname.autocorrectionType=UITextAutocorrectionTypeNo;

    if (![Levelname isEqualToString:@""]) {
        Levelmname.text=Levelname;

    }
    
//    UIImageView *image1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1text.png"]];
//    image1.frame=CGRectMake(50,80, 230, 30);
//    [detailview addSubview:image1];
//    [image1 release];
//    
//    Formname=[[UITextField alloc]initWithFrame:CGRectMake(55, 80, 220, 30)];
//    Formname.backgroundColor=[UIColor clearColor];
//    Formname.placeholder=@"Form name" ;
//    Formname.autocapitalizationType=UITextAutocapitalizationTypeNone;
//    Formname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    Formname.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
//    [detailview addSubview:Formname];
//    Formname.delegate=self;
//    Formname.text=Forselectmname;
    
       
    UIButton *submitbtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    submitbtn2.frame=CGRectMake(30,180, 520/2, 76/2);
    [submitbtn2 addTarget:self action:@selector(Submitaction) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn2 setBackgroundImage:[UIImage imageNamed:@"save1.png"] forState:UIControlStateNormal];
//    [submitbtn2 setBackgroundImage:[UIImage imageNamed:@"Submit_P.png"] forState:UIControlStateSelected];
    [detailview addSubview:submitbtn2];
    
    UIButton *CloseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.frame=CGRectMake(285, 5, 25, 25);
    [CloseBtn addTarget:self action:@selector(removedataView) forControlEvents:UIControlEventTouchUpInside];
    CloseBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [CloseBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [detailview addSubview:CloseBtn];
    
//    if (FormnameArray) {
//        FormnameArray=nil;
//    }
    
//    FormnameArray=[[NSMutableArray alloc]initWithObjects:@"Inspection Form",@"Data Capture Form",@"Sales/Support Form", nil];
//    
//    UIImageView *downrow=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 300, 0.5)];
//    downrow.image=[UIImage imageNamed:@"line.png"];
//
//    Table=[[UITableView alloc]init];
//    Table.frame=CGRectMake(0, 0, 0, 0);
//    Table.backgroundColor=[UIColor lightGrayColor];
//    [Table setDelegate:self];
//    Table.separatorColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]];
//    [Table setDataSource:self];
//    [detailview addSubview:Table];
//    
//    Table.tableHeaderView=downrow;
//    Table.tableFooterView=downrow;
//    [downrow release];
}

-(void)removedataView
{
    Selectedtable=@"Other";
    Levelmname=nil;
        [detailview removeFromSuperview];
    detailview=nil;
    Present=0;
}

#pragma  mark:textfield Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==Formname)
    {
        [Formname resignFirstResponder];
        Selectedtable=@"Form";
        Table.hidden=NO;
        Table.frame=CGRectMake(Formname.frame.origin.x, Formname.frame.origin.y+30, Formname.frame.size.width,67);
        [Table reloadData];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
       if (Table) {
        Table.hidden=YES;
    }
    
//    [Formname resignFirstResponder];
    if ([Levelmname isFirstResponder]) {
        [Levelmname resignFirstResponder];

    }
    [super touchesBegan:touches withEvent:event];

}


-(void)viewDidDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
