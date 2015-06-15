//
//  Level3ViewController.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 08/05/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "Level3ViewController.h"

@interface Level3ViewController ()

@end

@implementation Level3ViewController
@synthesize level1,level2,level1name,level2name,Detailname,manageflg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self GetDetails];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.navigationController.navigationBarHidden=YES;
    

    UIImageView *img;
    UIImageView *uprow;

    if (!IS_IPHONE_5)
    {
        uprow=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 300, 43)];
        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        Detailtable=[[UITableView alloc]initWithFrame:CGRectMake(10.0, 74.0, 300.0, self.view.frame.size.height-180)];
    }
    else
    {
        uprow=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 300, 43)];
        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
        Detailtable=[[UITableView alloc]initWithFrame:CGRectMake(10.0, 74.0, 300.0,  self.view.frame.size.height-180)];
    }
    
    img.image=[UIImage imageNamed:@"Background.png"];
    [self.view addSubview:img];

    if (Adjust_Height ==20) {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];
        
    }

    NSString *Str=@"";
    if (mainDelegate.Levelnamearray!=nil && mainDelegate.Levelnamearray.count>2) {
        Str=[mainDelegate.Levelnamearray objectAtIndex:2];
    }
    else
        Str=@"Select Identifier3";
    
    UIImageView *Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    Navbar.userInteractionEnabled=YES;
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=Str;
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.backgroundColor=[UIColor clearColor];
    Title.textAlignment=NSTextAlignmentCenter;
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,7,50,30);
    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(236,0,42,44);
    [button1 setBackgroundImage:[UIImage imageNamed:@"Plus_N.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showaddview) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:button1];
    UIImageView *downrow=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 0.5)];
    downrow.image=[UIImage imageNamed:@"line.png"];
        
    NSString *title=[NSString stringWithFormat:@"%@->%@",level1name,level2name];
   
    UILabel *Title1sub=[[UILabel alloc]initWithFrame: CGRectMake(10.0, 10, 300, 50)];
    Title1sub.text=@"Select the Form Identifiers before you can enter data";
    Title1sub.font=[UIFont systemFontOfSize:13];
    Title1sub.lineBreakMode=NSLineBreakByWordWrapping;
    Title1sub.numberOfLines=2;
    Title1sub.backgroundColor=[UIColor clearColor];
    Title1sub.textAlignment=NSTextAlignmentCenter;
    [view addSubview:Title1sub];

    
    UILabel *Title1=[[UILabel alloc]initWithFrame: CGRectMake(60.0, 40, 200, 30)];
    Title1.text=title;
    Title1.font=[UIFont boldSystemFontOfSize:13];
    Title1.backgroundColor=[UIColor clearColor];
    Title1.textAlignment=NSTextAlignmentCenter;
    [view addSubview:Title1];

    Detailtable.backgroundColor=[UIColor clearColor];
    [ Detailtable setDelegate:self];
    [ Detailtable setDataSource:self];
    
    Detailtable.tableHeaderView=downrow;
    Detailtable.separatorColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]];
    Detailtable.tableFooterView=downrow;
    [view addSubview: Detailtable];
    Detailtable.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);

    addfieldview=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320, self.view.frame.size.height-(Adjust_Height))];
    addfieldview.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    addfieldview.hidden=YES;
    [self.view addSubview:addfieldview];
    
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(30, 60,240, 25)];
    label.text=[NSString stringWithFormat:@"Add New Category"];
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    [addfieldview addSubview:label];
    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf1.png"]];
    image.frame=CGRectMake(30,97, 520/2, 76/2);
    [addfieldview addSubview:image];
    
    txt=[[UITextField alloc]initWithFrame:CGRectMake(35, 100, 514/2, 76/2)];
    txt.delegate=self;
    txt.backgroundColor=[UIColor clearColor];
    [addfieldview addSubview:txt];
    
    UIButton *submitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitbtn.frame=CGRectMake(30, 160,520/2, 76/2);
    [submitbtn addTarget:self action:@selector(Submitaction) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn setBackgroundImage:[UIImage imageNamed:@"save1.png"] forState:UIControlStateNormal];
    [addfieldview addSubview:submitbtn];
    
    UIButton *CloseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.frame=CGRectMake(285, 5, 25, 25);
    CloseBtn.titleLabel.textColor=[UIColor blackColor];
    [CloseBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [CloseBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    CloseBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [CloseBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    
    [addfieldview addSubview:CloseBtn];
    
    
    
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
        
        [self GetDetails];
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
    ObjDb=[DatabseInstance sharedInstance];
    [ObjDb openDB];
    int count=0;
    
    sqlite3 *Objsql=ObjDb.sDB;
    if (sqlite3_open(ObjDb.dbpath, &Objsql) == SQLITE_OK)
    {
            
        NSString *querySQL = [NSString stringWithFormat:@"SELECT level3id from DetailTable where formid='%@' group by  level3id",mainDelegate.formid];
            
        sqlite3_stmt *statement = nil;
        const char *query_stmt = [querySQL UTF8String];
            
        if (sqlite3_prepare_v2(ObjDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                count++;
            }
            sqlite3_finalize(statement);
        }
    }
    
    if (count>=[mainDelegate.NOofFields intValue])
    {
        mainDelegate.Recordflag=1;
    }
    
    if (mainDelegate.Recordflag)
    {
        if ([mainDelegate.UserType isEqualToString:@"Liteuser"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"You have reached the max limit of 25 records per Form." message:@"To capture more records, you can :\n-  Clear Form data using the Delate Menu or \n- sign up for the PRO version" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
        }
        
        if ([mainDelegate.UserType isEqualToString:@"Prouser"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"You have reached the max limit of %@ records per Form.",mainDelegate.NOofFields] message:@"To capture more records, you can :\n-  Clear Form data using the Delate Menu." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    
        return;

    }
    
    Addnewflg=1;
    label.text=[NSString stringWithFormat:@"Add New Category"];
    txt.text=@"";
    addfieldview.hidden=NO;
}

- (void)removeView
{
    Addnewflg=0;
    addfieldview.hidden=YES;
}

-(void)Submitaction
{
    if (txt.text.length>1)
    {
        [self openDB];
        
        NSDateFormatter *formatter;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        NSString *insertQuery;
        if (Addnewflg)
        {
            [ObjDb openDB];
                     
            insertQuery = [NSString stringWithFormat:@"INSERT INTO tp_level3_master(level3_data,level2_id,level1_id,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@')",txt.text ,self.rideid,level1,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
        }
        else
        {
            insertQuery= [NSString stringWithFormat:@"update tp_level3_master set level3_name='%@',dateModified='%@' where rowid='%@'" ,txt.text,[mainDelegate Getcurrentdate],Currentid];
        }
        
        char *err;
        
        if (sqlite3_exec(sDB, [insertQuery UTF8String], NULL, NULL, &err)!= SQLITE_OK)
        {
            sqlite3_close(sDB);
            NSLog(@"Insert Records Fail");
        }
        else
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Identifier added Successfully." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            alert1.tag=1;
            [alert1 show];
            
            if (txt)
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

#pragma mark - Database Methods added by Mayur


- (void) initDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TrakDb.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    dbpath = [writableDBPath UTF8String];
    
    if (success) return;
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TrakDb.sqlite"];
    
    success = [fileManager fileExistsAtPath:defaultDBPath];
    
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
    
}

#pragma mark - Database Methods added End by Mayur

-(void)openDB
{
    [self initDatabase];
    
    if (sqlite3_open(dbpath, &sDB)!=SQLITE_OK)
    {
        sqlite3_close(sDB);
    }
}

-(void)GetDetails
{
    
    //Added by Mayur
    
    //Getting Value from Database.
    
    NSLog(@"mainDelegate.Companyid: %@", mainDelegate.Companyid);
    NSLog(@"Selectedzone: %@", level1);
    NSLog(@"selectedRide: %@", level2);
    
    if(DetailLabelArray !=nil)
        DetailLabelArray=nil;
    DetailLabelArray=[[NSMutableArray alloc]init];
    
    if(Indexarray !=nil)
        Indexarray=nil;
    Indexarray=[[NSMutableArray alloc]init];
    
    sqlite3_stmt    *statement;
	
	[self openDB];
    
	if (sqlite3_open(dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"select rowid,level3_data from tp_level3_master where level2_id=%@ ",self.rideid];
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *DetailLabelStr = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                NSString *IndexID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                [DetailLabelArray addObject:DetailLabelStr];
                [Indexarray addObject:IndexID];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(sDB);
	}
    
    [Detailtable reloadData];
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



#pragma  mark table delgate
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
    return DetailLabelArray.count;
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

        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 250, 20)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.backgroundColor=[UIColor clearColor];
        lbl.text=[DetailLabelArray objectAtIndex:indexPath.row];
        lbl.font=[UIFont systemFontOfSize:16];
        [cell.contentView addSubview:lbl];
        
        UILabel *typeid=[[UILabel alloc]init];
        typeid.text=[Indexarray objectAtIndex:indexPath.row];
        typeid.hidden=YES;
        [cell.contentView addSubview:typeid];

    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL flagPreviousPresent=NO;
    ObjDb=[DatabseInstance sharedInstance];
    [ObjDb openDB];
    int count=0;
    
    sqlite3 *Objsql=ObjDb.sDB;
    if (sqlite3_open(ObjDb.dbpath, &Objsql) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT level3id from DetailTable where formid='%@' group by  level3id",mainDelegate.formid];
        
        sqlite3_stmt *statement = nil;
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(ObjDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                const char* level3Id1 = (const char*)sqlite3_column_text(statement, 0);
                NSString *level3Id =[[NSString alloc] initWithUTF8String:level3Id1];
                
                UILabel *rideidtypelbl=(UILabel*)[[tableView cellForRowAtIndexPath:indexPath].contentView.subviews objectAtIndex:1];
                if ([level3Id isEqualToString:rideidtypelbl.text])
                {
                    flagPreviousPresent=YES;
                    break;
                }
                count++;
            }
            sqlite3_finalize(statement);
        }
    }

    if (count>=[mainDelegate.NOofFields intValue])
    {
        mainDelegate.Recordflag=1;
    }
    
    if (mainDelegate.Recordflag && !flagPreviousPresent)
    {
        if ([mainDelegate.UserType isEqualToString:@"Liteuser"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"You have reached the max limit of 25 records per Form." message:@"To capture more records, you can :\n-  Clear Form data using the Delate Menu or \n- sign up for the PRO version" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        if ([mainDelegate.UserType isEqualToString:@"Prouser"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"You have reached the max limit of %@ records per Form.",mainDelegate.NOofFields] message:@"To capture more records, you can :\n-  Clear Form data using the Delate Menu." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        return;
        
    }
    
    else
    {
        
        Formdetailview *objdetail=[[Formdetailview alloc]init];
        
        if (mainDelegate.Selectedidarray!=nil) {
            mainDelegate.Selectedidarray=nil;
        }
        
        UILabel *rideidtypelbl=(UILabel*)[[tableView cellForRowAtIndexPath:indexPath].contentView.subviews objectAtIndex:1];
        objdetail.ridetypeid=rideidtypelbl.text;

        mainDelegate.Selectedidarray=[NSMutableArray arrayWithObjects:level1,level2,[Indexarray objectAtIndex:indexPath.row], nil];
        
        if (mainDelegate.SelectedRidearray!=nil) {
            mainDelegate.SelectedRidearray=nil;
        }
        mainDelegate.SelectedRidearray=[NSMutableArray arrayWithObjects:level1name,level2name,[DetailLabelArray objectAtIndex:indexPath.row], nil];
        
        [self.navigationController pushViewController:objdetail animated:YES];
    }
}

-(void)Editlevel3:(id)sender
{
    int i=[sender tag];
    label.text=[NSString stringWithFormat:@"Update %@",Detailname];
    
    Currentid=[Indexarray objectAtIndex:i];
    txt.text=[DetailLabelArray objectAtIndex:i];
    addfieldview.hidden=NO;
    
}

#pragma mark textfield delgate

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
