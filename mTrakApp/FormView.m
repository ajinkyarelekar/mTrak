//
//  FormView.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "FormView.h"

@interface FormView ()

@end

@implementation FormView

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
    [super viewWillAppear:YES];

    [self getformsname];
    if (FormNamearray.count<1) {
        labl.hidden=NO;
    }
    else
    {
        labl.hidden=YES;
    }
    [Formtable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;

    ObjSharedDb=[DatabseInstance sharedInstance];
    maindelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    UIView *backview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background.png"]];
    backview.frame=CGRectMake(0, 0, 320, self.view.frame.size.height);
    [self.view addSubview:backview];
    
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
    Title.text=@"Form View";
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
    maindelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;

    if (!maindelegate.Comefromroot) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0,7,50,30);
        [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
        [Navbar addSubview:button];

    }
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    lbl.userInteractionEnabled=NO;
    lbl.text=@"Select a Form To Continue";
    lbl.lineBreakMode=NSLineBreakByWordWrapping;
    lbl.numberOfLines=2;
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.font=[UIFont systemFontOfSize:13.0f];
    lbl.backgroundColor=[UIColor clearColor];
    [view addSubview:lbl];

    
     labl=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    labl.userInteractionEnabled=NO;
    labl.text=@"No Form created please first create new form from create new form section.";
    labl.lineBreakMode=NSLineBreakByWordWrapping;
    labl.numberOfLines=3;
    labl.textAlignment=NSTextAlignmentCenter;
    labl.font=[UIFont systemFontOfSize:13.0f];
    labl.backgroundColor=[UIColor clearColor];
    [view addSubview:labl];
    
    UIImageView *downrow=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 300, 0.5)];
    downrow.image=[UIImage imageNamed:@"line.png"];

    Formtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 35, 320, self.view.frame.size.height-150)];
    Formtable.backgroundColor=[UIColor clearColor];
    [Formtable setDelegate:self];
    Formtable.separatorColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]];
    Formtable.separatorInset=UIEdgeInsetsZero;
    [Formtable setDataSource:self];
    Formtable.tableFooterView=downrow;
    Formtable.tableHeaderView=downrow;
    [view addSubview:Formtable];
    

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
    if (alertView.tag==188)
    {
        if (buttonIndex==1)
        {
            [self Logout];
        }
    }
    
    if (alertView.tag==111)
    {
        if (buttonIndex==1)
        {
            [self Deleteconfirm];
        }
        else if (buttonIndex==2)
        {
            [self Clearformdata];
        }
    }
}

-(void)Logout
{
    maindelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [maindelegate Showrootview];

}
-(void)getformsname
{
    [ObjSharedDb openDB];
    
    if (Formidarray) {
        FormNamearray=nil;
        Formidarray=nil;
    }
    if (FormTidarray) {
        FormTidarray=nil;
        FormTidarray=nil;
    }
    FormTidarray=[[NSMutableArray alloc]init];
     FormNamearray=[[NSMutableArray alloc]init];
    Formidarray=[[NSMutableArray alloc]init];
    sqlite3_stmt *statement = nil;
    sqlite3 *Objsql=ObjSharedDb.sDB;
    if (sqlite3_open(ObjSharedDb.dbpath, &Objsql) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT form_name,id,ftid FROM tp_forms  where usertype='%@' order by id ",maindelegate.UserType]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(ObjSharedDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *formname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                    [FormNamearray addObject:formname ];
                NSString *formid = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    [Formidarray addObject:formid ];
                
                NSString *fortmid = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                [FormTidarray addObject:fortmid ];
            }
            sqlite3_finalize(statement);
            
        }
    }
    sqlite3_close(ObjSharedDb.sDB);
    
    [self GetFormdatacount];
    
}

-(void)GetFormdatacount
{
    if (Formdatacountarray) {
        Formdatacountarray=nil;
    }
    Formdatacountarray=[[NSMutableArray alloc]init];
    
    [ObjSharedDb openDB];
    
    sqlite3 *Objsql=ObjSharedDb.sDB;
    if (sqlite3_open(ObjSharedDb.dbpath, &Objsql) == SQLITE_OK)
	{
        
        for (int i=0; i<Formidarray.count; i++)
        {
            
            NSString *querySQL = [NSString stringWithFormat:@"SELECT level3id from DetailTable where formid='%@' group by  level3id",[Formidarray objectAtIndex:i]];
            
            sqlite3_stmt *statement = nil;
            const char *query_stmt = [querySQL UTF8String];
        
            if (sqlite3_prepare_v2(ObjSharedDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                int count=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    count++;
                }
                [Formdatacountarray addObject:[NSString stringWithFormat:@"%d",count]];

                sqlite3_finalize(statement);
            }
        }
        
    }
    sqlite3_close(ObjSharedDb.sDB);

}

-(void)popViewback
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma  mark:tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
          return FormNamearray.count;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath1
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

        UIButton *cellview = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cellview.frame = CGRectMake(285,10,30,30);
        cellview.tag=indexPath1.row;
        [cellview setBackgroundImage:[UIImage imageNamed:@"form.png"] forState:UIControlStateNormal];
        [cellview addTarget:self action:@selector(Selectcell:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor=[UIColor clearColor];
                   cell.textLabel.text=[FormNamearray objectAtIndex:indexPath1.row];
        [cell.contentView addSubview:cellview];
        
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines=2;
        UIButton *DelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        DelButton.frame = CGRectMake(200,10,30,30);
        DelButton.tag=indexPath1.row;
        [DelButton setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [DelButton addTarget:self action:@selector(deleteForm:) forControlEvents:UIControlEventTouchUpInside];
        [DelButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [cell.contentView addSubview:DelButton];

        UILabel *formidlbl=[[UILabel alloc]init];
        formidlbl.text=[Formidarray objectAtIndex:indexPath1.row];
        formidlbl.hidden=YES;
        [cell.contentView addSubview:formidlbl];
        
        UIButton *ManageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ManageBtn.frame = CGRectMake(243,10,30,30);
        ManageBtn.tag=indexPath1.row;
        [ManageBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [ManageBtn setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
        [ManageBtn addTarget:self action:@selector(Gotomanageform:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:ManageBtn];
        
        UILabel *formcountlbl=[[UILabel alloc]initWithFrame:CGRectMake(170, 10, 30, 30)];
        formcountlbl.backgroundColor=[UIColor clearColor];
        if (Formdatacountarray.count>indexPath1.row)
        formcountlbl.text=[NSString stringWithFormat:@"(%@)",[Formdatacountarray objectAtIndex:indexPath1.row]];
        formcountlbl.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:formcountlbl];

    }
    return cell;
}

-(void)Selectcell:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    CGPoint center=btn.center;
    CGPoint rootViewPoint = [btn.superview convertPoint:center toView:Formtable];
    NSIndexPath *indexPath1 = [Formtable indexPathForRowAtPoint:rootViewPoint];
    [Formtable selectRowAtIndexPath:indexPath1 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:Formtable didSelectRowAtIndexPath:indexPath1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath1
{
    UILabel *formidlbl=(UILabel*)[[tableView cellForRowAtIndexPath:indexPath1].contentView.subviews objectAtIndex:3];
    UIButton *formidlbtn=(UIButton*)[[tableView cellForRowAtIndexPath:indexPath1].contentView.subviews objectAtIndex:0];
    [formidlbtn setHighlighted:YES];

    maindelegate.formid=formidlbl.text;
    int formid=[[FormTidarray objectAtIndex:indexPath1.row] intValue];
    maindelegate.formTid=[FormTidarray objectAtIndex:indexPath1.row];
    [self gotoForm:indexPath1.row :formid];
    maindelegate.Backflag=YES;
   
}

-(void)deleteForm:(id)Sender
{
    deleteID=[Sender tag];
    indexPath = [Formtable indexPathForCell:(UITableViewCell *)[Sender superview]];
    maindelegate.formid=[Formidarray objectAtIndex:[Sender tag]];

    UIAlertView *Alter = [[UIAlertView alloc] initWithTitle:@"Please choose your option." message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete form",@"Clear form data", nil];
    Alter.tag=111;
    [Alter show];
    
}
-(void)Clearformdata
{
    NSString *Query=[NSString stringWithFormat:@"Delete  from DetailTable where formid='%@'",maindelegate.formid];
    BOOL Status=   [ObjSharedDb ExexuteOperation:Query];
    
   
    if (Status) {
        //save for sync
        
        NSString *insertQuery1 = [NSString stringWithFormat:@"INSERT INTO OperationTable(OperationUrl,Tablename) VALUES ('%@','Form_data')",maindelegate.formid];
        BOOL Status=   [ObjSharedDb ExexuteOperation:insertQuery1];
        NSLog(@"%d",Status);
        
        [self getformsname ];
        [Formtable reloadData];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Data cleared successfully.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    NSString *Query1=[NSString stringWithFormat:@"Delete  from Mediatable where formid='%@'",maindelegate.formid];
    BOOL Status1=   [ObjSharedDb ExexuteOperation:Query1];
    
    
    if (Status1) {
        NSString *insertQuery1 = [NSString stringWithFormat:@"INSERT INTO OperationTable(OperationUrl,Tablename) VALUES ('%@','media')",maindelegate.formid];
        
        //save for sync
     BOOL subs=   [ObjSharedDb ExexuteOperation:insertQuery1];
        NSLog(@"%d",subs);
    }
    
    

    NSLog(@"%d",Status1);
    
}

-(void)Deleteconfirm
{
    NSArray *indexpatharr=[NSArray arrayWithObjects:indexPath, nil];
    [Formtable deleteRowsAtIndexPaths:indexpatharr withRowAnimation: UITableViewRowAnimationAutomatic];
    
    NSString *formname=[FormNamearray objectAtIndex:deleteID];
    [FormNamearray removeObjectAtIndex:deleteID];
    [Formtable reloadData];
    [self DeleteFromtable:formname];

}

#pragma mark:database methods

-(NSMutableArray*)GetLevelnames
{
    
        [ObjSharedDb openDB];
        sqlite3_stmt *statement;
        sqlite3 *dbref=ObjSharedDb.sDB;
        NSMutableArray *DetailArray1=[[NSMutableArray alloc]init];
        
        if (sqlite3_open(ObjSharedDb.dbpath, &dbref) == SQLITE_OK)
        {
            //select user id
            NSString *querySQL = [NSString stringWithFormat:@"select * FROM Levels where formid='%@' ",maindelegate.formid]; //order by id DESC limit 1
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(ObjSharedDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    const char* Lvl1 = (const char*)sqlite3_column_text(statement, 1);
                    NSString *level1 = Lvl1== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl1];
                    [DetailArray1 addObject:level1];

                    const char* Lvl2 = (const char*)sqlite3_column_text(statement, 2);
                    NSString *level2 = Lvl2== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl2];
                    [DetailArray1 addObject:level2];

                    const char* Lvl3 = (const char*)sqlite3_column_text(statement, 3);
                    NSString *level3 = Lvl3== NULL ? @"" : [[NSString alloc] initWithUTF8String:Lvl3];
                    [DetailArray1 addObject:level3];
                }
                sqlite3_finalize(statement);
            }
            
        }
        sqlite3_close(ObjSharedDb.sDB);
        
        return DetailArray1;
}


-(void)DeleteFromtable:(NSString*)Tablename
{
    NSString *Updatequery=[NSString stringWithFormat:@"DELETE FROM tp_forms where form_name='%@'",Tablename];
    [ObjSharedDb UpdateRecord:Updatequery];
}

-(void)Gotomanageform:(id)Sender
{
    maindelegate.Selectedtable=[FormNamearray objectAtIndex:[Sender tag]];

    ManageFormView *Obj=[[ManageFormView alloc]init];
    Obj.SelectedFormId=[Formidarray objectAtIndex:[Sender tag]];
    Obj.SelectedTbale=[FormNamearray objectAtIndex:[Sender tag]];
    maindelegate.formid=[Formidarray objectAtIndex:[Sender tag]];
    maindelegate.formTid=[FormTidarray objectAtIndex:[Sender tag]];
    [self.navigationController pushViewController:Obj animated:YES];
}

-(void)gotoForm:(NSInteger)sender :(int)formid
{
    if ([maindelegate.UserType isEqualToString:@"Liteuser"])
    {
        NSString *str=[Formdatacountarray objectAtIndex:sender];
        if ([str integerValue]>24) {
            maindelegate.Recordflag=1;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"You have reached the max limit of 25 records per Form." message:@"To capture more records, you can :\n-  Clear Form data using the Delate Menu or \n- sign up for the PRO version" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            maindelegate.Recordflag=0;
        }
    }
    
    if ([maindelegate.UserType isEqualToString:@"Prouser"])
    {
        NSString *str=[Formdatacountarray objectAtIndex:sender];
        if ([str intValue]>=[maindelegate.NOofFields intValue]) {
            maindelegate.Recordflag=1;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"You have reached the max limit of %@ records per Form.",maindelegate.NOofFields] message:@"To capture more records, you can :\n-  Clear Form data using the Delate Menu." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            maindelegate.Recordflag=0;
        }
    }

    maindelegate.Levelnamearray=[self GetLevelnames];
    maindelegate.Selectedtable=[FormNamearray objectAtIndex:sender];
    ZoneSelection *Obj=[[ZoneSelection alloc]init];
    Obj.formid=formid;
    [self.navigationController pushViewController:Obj animated:YES];
    NSLog(@"%d",sender);
}



#pragma mark:textfield Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)TabletouchesBegan
{
    NSInteger n=11;
    
    for (int i=0; i<FormNamearray.count; i++)
    {
        NSIndexPath* indexpath = [NSIndexPath indexPathForRow:i inSection:0]; // in case this row in in your first section
        UITableViewCell* cell = [Formtable cellForRowAtIndexPath:indexpath];
        UITextField* textfield =(UITextField*) [cell.contentView viewWithTag:n];
        if ([textfield isFirstResponder])
        {
            [textfield resignFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
