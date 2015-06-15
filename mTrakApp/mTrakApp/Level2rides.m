//
//  Level2rides.m
//  trackperformance
//
//  Created by Nanostuffs on 1/1/14.
//  Copyright (c) 2014 Trupti. All rights reserved.
//
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#import "Level2rides.h"

@interface Level2rides ()

@end

@implementation Level2rides
@synthesize Selectedzone,rideObj,Zonelabel,manageflag,button;
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
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *str=@"";
    if (mainDelegate.Levelnamearray!=nil && mainDelegate.Levelnamearray.count>1) {
        str=[mainDelegate.Levelnamearray objectAtIndex:1];
    }
    else
        str=@"Select Identifier2";
    UIButton *datebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"RideBG.png"]];
    
    UIButton *Zonetitlebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *uprow,*img;
    
    if (!IS_IPHONE_5)
    {
        uprow=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 300, 43)];
        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        RideTable=[[UITableView alloc]initWithFrame:CGRectMake(10.0, 74.0, 300.0, self.view.frame.size.height-180)];
        Zonetitlebtn.frame = CGRectMake(20.0, 10, 280, 50);
        [backview setFrame:CGRectMake(-5, 0,330,440)];
        datebtn.frame = CGRectMake(255,10,58,32);

    }
    else
    {
        uprow=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 300, 43)];
        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
        RideTable=[[UITableView alloc]initWithFrame:CGRectMake(10.0, 74.0, 300.0, self.view.frame.size.height-180)];
        Zonetitlebtn.frame = CGRectMake(20.0, 10, 280, 50);
        [backview setFrame:CGRectMake(-5, 0,330,568)];
        datebtn.frame = CGRectMake(255,10,58,32);

    }
    
    img.image=[UIImage imageNamed:@"Background.png"];
    [self.view addSubview:img];
    
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
    Title.text=str;
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.textAlignment=NSTextAlignmentCenter;
    Title.backgroundColor=[UIColor clearColor];
    Title.textColor=[UIColor whiteColor];
    [Navbar addSubview:Title];
    
    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:LogoutBtn];

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+44, 320, self.view.frame.size.height-Adjust_Height)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    UIButton *buttons = [UIButton buttonWithType:UIButtonTypeCustom];
    buttons.frame = CGRectMake(0,7,50,30);
    [buttons setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [buttons addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:buttons];
    NSLog(@"zone title is:%@",Zonelabel);
        
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(236,0,42,44);
    [button1 setBackgroundImage:[UIImage imageNamed:@"Plus_N.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showaddview) forControlEvents:UIControlEventTouchUpInside];
    
    [Navbar addSubview:button1];

    UILabel *Title1sub=[[UILabel alloc]initWithFrame: CGRectMake(10.0, 10, 300, 50)];
    Title1sub.text=@"Select the Form Identifiers before you can enter data";
    Title1sub.font=[UIFont systemFontOfSize:13];
    Title1sub.lineBreakMode=NSLineBreakByWordWrapping;
    Title1sub.numberOfLines=2;
    Title1sub.backgroundColor=[UIColor clearColor];
    Title1sub.textAlignment=NSTextAlignmentCenter;
    [view addSubview:Title1sub];

    
    UILabel *Title1=[[UILabel alloc]initWithFrame: CGRectMake(60.0, 40, 200, 30)];
    Title1.text=[NSString stringWithFormat:@"%@",Zonelabel];
    Title1.font=[UIFont boldSystemFontOfSize:13];
    Title1.backgroundColor=[UIColor clearColor];
    Title1.textAlignment=NSTextAlignmentCenter;
    [view addSubview:Title1];

    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIImageView *downrow=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 0.5)];
    downrow.image=[UIImage imageNamed:@"line.png"];

    RideTable.backgroundColor=[UIColor clearColor];
    [RideTable setDelegate:self];
    RideTable.separatorColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]];
    [RideTable setDataSource:self];
    [view addSubview:RideTable];
    RideTable.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);

    RideTable.tableHeaderView=downrow;
    RideTable.tableFooterView=downrow;
    
    addfieldview=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320, self.view.frame.size.height-(Adjust_Height))];
    addfieldview.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    addfieldview.hidden=YES;
    [self.view addSubview:addfieldview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(70, 60, 240, 25)];
 
    label.text=[NSString stringWithFormat:@"Add New Category "];
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor clearColor];
    [addfieldview addSubview:label];

    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image.frame=CGRectMake(30,97, 520/2, 76/2);
    [addfieldview addSubview:image];

    txt=[[UITextField alloc]initWithFrame:CGRectMake(35, 100,514/2, 76/2)];
    txt.delegate=self;
    txt.backgroundColor=[UIColor clearColor];
    [addfieldview addSubview:txt];
    
    UIButton *submitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitbtn.frame=CGRectMake(30, 180, 520/2, 76/2);
    [submitbtn addTarget:self action:@selector(Submitaction) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn setBackgroundImage:[UIImage imageNamed:@"save1.png"] forState:UIControlStateNormal];
    [addfieldview addSubview:submitbtn];
    
    UIButton *CloseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.frame=CGRectMake(285, 5, 30, 30);
    [CloseBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    CloseBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [CloseBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [addfieldview addSubview:CloseBtn];
    
    ObjDb=[DatabseInstance sharedInstance];
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
        [self GetRideDetails];
        [txt resignFirstResponder];
        [self removeView];
    }
    
}


-(void)Logout
{
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [mainDelegate Showrootview];

    
}

-(void)showaddview
{
    Addnewflag=1;
    txt.text=@"";
    RideTable.userInteractionEnabled=NO;
    addfieldview.hidden=NO;
}

- (void)removeView
{
    addfieldview.hidden=YES;
    RideTable.userInteractionEnabled=YES;

}

#pragma mark - Database Methods added by Mayur

-(void)Submitaction
{
    if (txt.text.length>1)
    {
    
    [ObjDb openDB];
    
    [txt resignFirstResponder];
    
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *insertQuery;
        if (Addnewflag)
        {
            NSString *levelid = @"0";
            [ObjDb openDB];
            sqlite3_stmt *statement;
            sqlite3 *objdb=ObjDb.sDB;
            if (sqlite3_open(ObjDb.dbpath, &objdb) == SQLITE_OK)
            {
                NSString *sql_query;
                sql_query=[NSString stringWithFormat:@"select max(rowid) from tp_level2_master"];
                
                const char *query_stmt = [sql_query UTF8String];
                
                if (sqlite3_prepare_v2(objdb, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        const char* zonename1 = (const char*)sqlite3_column_text(statement, 0);
                        levelid = zonename1== NULL ? @"0" : [[NSString alloc] initWithUTF8String:zonename1];
                    }
                }
                sqlite3_finalize(statement);
            }
            
            
            insertQuery = [NSString stringWithFormat:@"INSERT INTO tp_level2_master(level2_data,rowid,level1_id,dateCreated,dateModified,usertype) VALUES ('%@','%d','%@','%@','%@','%@')",txt.text, [levelid intValue]+1 ,self.zoneid,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
        }
        else
            insertQuery= [NSString stringWithFormat:@"update tp_level2_master set level2_name='%@',dateModified='%@' where rowid='%@'",txt.text, [mainDelegate Getcurrentdate],Currentid];
    
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
        if (Addnewflag)
        {
            urlStr= [NSString stringWithFormat:@"http://ira-infosolutions.com/WebService/insert_level2_row.php?level1_id=%@&level2_name=%@&cid=%@&id=",Selectedzone,txt.text,mainDelegate.Companyid];

        }
        else
        {
            urlStr= [NSString stringWithFormat:@"http://ira-infosolutions.com/WebService/insert_level2_row.php?level1_id=%@&level2_name=%@&cid=%@&id=%@",Selectedzone,txt.text,mainDelegate.Companyid,Currentid];
        }
        
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

        sqlite3_close(ObjDb.sDB);
        addfieldview.hidden=NO;
        RideTable.userInteractionEnabled=NO;

    }

    
    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Identifier successfully added." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    alert1.tag=1;
    [alert1 show];
        if (txt) {
            [txt resignFirstResponder];
            
        }

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

-(void)GetRideDetails
{
    [self performSelector:@selector(afterDelaymethod2) withObject:nil afterDelay:0.1];
}
-(void)afterDelaymethod2
{
    //Getting value from local dababase
    
    NSLog(@"mainDelegate.Companyid: %@", mainDelegate.Companyid);
    NSLog(@"Selectedzone: %@", Selectedzone);
    NSLog(@"Zonelabel: %@", Zonelabel);
    
    NSString *sql_query = [NSString stringWithFormat:@"select level2_data,rowid from tp_level2_master where level1_id=%d",[self.zoneid intValue]];
    
    ObjDb=[DatabseInstance sharedInstance ];
    
    NSMutableArray *tempArr=[ObjDb DisplaylevelData:sql_query ];
    NSLog(@"%@", tempArr);
    NSMutableDictionary *tempdict;
    
    if(ZoneIDArr !=nil)
        ZoneIDArr=nil;
    ZoneIDArr=[[NSMutableArray alloc]init];
    
    if(RideNameArray !=nil)
        RideNameArray=nil;
    RideNameArray=[[NSMutableArray alloc]init];
    
    if(arrayOfStatusDown !=nil)
        arrayOfStatusDown=nil;
    arrayOfStatusDown=[[NSMutableArray alloc]init];
    
    if(RideidArray !=nil)
        RideidArray=nil;
    RideidArray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<tempArr.count; i++)
    {
        tempdict=[tempArr objectAtIndex:i];
        
              
        NSString *Ridestr = [tempdict valueForKey:@"LevelName"];
        [RideNameArray addObject:Ridestr];
        
        NSString *Rideid = [tempdict valueForKey:@"ID"];
        [RideidArray addObject:Rideid];
        
        [ZoneIDArr addObject:Selectedzone];
    }
    //Added End
    
    [RideTable reloadData];
}

#pragma mark table delegate

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
    return RideNameArray.count; //RideArray
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
        
        UIImageView *cellview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"next.png"]];
        cellview.frame=CGRectMake(0, 0, 11, 18);
        cell.accessoryView=cellview;
        cell.backgroundColor=[UIColor clearColor];

        cell.textLabel.text=[RideNameArray objectAtIndex:indexPath.row]; //RideArray
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        
        UILabel *rideidlbl=[[UILabel alloc]init];
        rideidlbl.text=[RideidArray objectAtIndex:indexPath.row];
        rideidlbl.hidden=YES;
        [cell.contentView addSubview:rideidlbl];

    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        Level3ViewController *objdetail=[[Level3ViewController alloc]init];
    
    objdetail.level1=Selectedzone;
    objdetail.level2=[RideidArray objectAtIndex:indexPath.row];
    objdetail.level1name=Zonelabel;
    objdetail.level2name=[RideNameArray objectAtIndex:indexPath.row];
    
    
    UILabel *rideidlbl=(UILabel*)[[tableView cellForRowAtIndexPath:indexPath].contentView.subviews objectAtIndex:1];
    objdetail.rideid=rideidlbl.text;
   
    [self.navigationController pushViewController:objdetail animated:YES];
  
}


-(void)Editlevel2:(id )sender
{
    int i=[sender tag];
    addfieldview.hidden=NO;
    RideTable.userInteractionEnabled=NO;

    Currentid=[RideidArray objectAtIndex:i];
    txt.text=[RideNameArray objectAtIndex:i];
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

-(void)viewWillAppear:(BOOL)animated
{
    [self GetRideDetails];

    
}

#pragma  mark:textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (txt) {
        [txt resignFirstResponder];
        
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (txt)
        [txt resignFirstResponder];
    
  
        [self.view endEditing:YES];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
