//
//  CreateForm.m
//  trackperformance
//
//  Created by Nanostuffs's Macbook on 21/04/14.
//  Copyright (c) 2014 Trupti. All rights reserved.
//

#import "CreateForm.h"
#import <sqlite3.h>

@interface CreateForm ()

@end

@implementation CreateForm
@synthesize FormnameTxt,SelectFormTxt;
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
    
    self.navigationController.navigationBarHidden=YES;

    
    if (Adjust_Height ==20) {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];
        
    }
     Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    Navbar.userInteractionEnabled=YES;
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=@"Create New Form";
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.textAlignment=NSTextAlignmentCenter;
    Title.textColor=[UIColor whiteColor];
    Title.backgroundColor=[UIColor clearColor];
    [Navbar addSubview:Title];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,7,50,30);
    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:button];
    
    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:LogoutBtn];
  
    DbSharedObj=[DatabseInstance sharedInstance];


    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+44, 320, self.view.frame.size.height-Adjust_Height)];
    view.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    FieldnameArray=[self Getformnames];
    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectform.png"]];
    image.frame=CGRectMake(30,50, 260, 36);
    [view addSubview:image];
    if (self.SelectFormTxt) {
        [self.SelectFormTxt removeFromSuperview];
        self.SelectFormTxt=nil;
    }
    
    self.SelectFormTxt=[[UITextField alloc]initWithFrame:CGRectMake(35, 50, 250, 35)];
    self.SelectFormTxt.backgroundColor=[UIColor clearColor];
    self.SelectFormTxt.placeholder=@"Select a Form" ;
    self.SelectFormTxt.delegate=self;
    self.SelectFormTxt.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.SelectFormTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.SelectFormTxt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    self.SelectFormTxt.autocorrectionType=UITextAutocorrectionTypeNo;
    [view addSubview:self.SelectFormTxt];
    
    UIImageView *image1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf.png"]];
    image1.frame=CGRectMake(30,100, 260, 36);
    [view addSubview:image1];
    
    [self.FormnameTxt removeFromSuperview];
    self.FormnameTxt=[[UITextField alloc]initWithFrame:CGRectMake(35, 100, 255, 35)];
    self.FormnameTxt.backgroundColor=[UIColor clearColor];
    self.FormnameTxt.placeholder=@"Enter Form Name" ;
    self.FormnameTxt.delegate=self;
    self.FormnameTxt.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.FormnameTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.FormnameTxt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [view addSubview:self.FormnameTxt];
    
    [Formtable removeFromSuperview];
    Formtable=[[UITableView alloc]initWithFrame:CGRectMake(self.SelectFormTxt.frame.origin.x, self.SelectFormTxt.frame.origin.y+30,self.SelectFormTxt.frame.size.width, 100)];
    Formtable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [Formtable setDelegate:self];
    [Formtable setDataSource:self];
    [view addSubview:Formtable];
    Formtable.hidden=YES;
    
    UIButton *submitbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitbtn.frame=CGRectMake(15,self.view.frame.size.height-200, 135, 38);
    [submitbtn addTarget:self action:@selector(Createtable) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn setBackgroundImage:[UIImage imageNamed:@"creatform.png"] forState:UIControlStateNormal];
    [view addSubview:submitbtn];
    
    UIButton *CancelBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CancelBtn.frame=CGRectMake(165,self.view.frame.size.height-200, 135, 38);
    [CancelBtn addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    [CancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [view addSubview:CancelBtn];

    SelectedRole=@"Liteuser";
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==88)
    {
        if (buttonIndex==0) {
            SelectedRole=@"Admin";

        }
        else
        {
            SelectedRole=@"Liteuser";

        }
        [self INviewload];
    }
    if (alertView.tag==188) {
        if (buttonIndex==1) {
            [self Logout];
        }
    }
    
}

#pragma mark:logout
-(void)Logoutclicked
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to logout." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alert.tag=188;
    [alert show];
    
}


-(void)Logout
{
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [mainDelegate Showrootview];

    
}

-(void)INviewload
{
    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
     view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+44, 320, self.view.frame.size.height-Adjust_Height)];
    view.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self.view addSubview:view];

    FieldnameArray=[self Getformnames];

    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectform.png"]];
    image.frame=CGRectMake(30,50, 260, 36);
    [view addSubview:image];
    if (self.SelectFormTxt) {
        [self.SelectFormTxt removeFromSuperview];
        self.SelectFormTxt=nil;
    }
    
    self.SelectFormTxt=[[UITextField alloc]initWithFrame:CGRectMake(33, 50, 255, 35)];
    self.SelectFormTxt.backgroundColor=[UIColor clearColor];
    self.SelectFormTxt.placeholder=@"Select a Form" ;
    self.SelectFormTxt.delegate=self;
    self.SelectFormTxt.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.SelectFormTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.SelectFormTxt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    self.SelectFormTxt.autocorrectionType=UITextAutocorrectionTypeNo;
    [view addSubview:self.SelectFormTxt];
    
    UIImageView *image1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Textf.png"]];
    image1.frame=CGRectMake(30,100, 260, 36);
    [view addSubview:image1];
    
    [self.FormnameTxt removeFromSuperview];
    self.FormnameTxt=[[UITextField alloc]initWithFrame:CGRectMake(33, 100, 255, 35)];
    self.FormnameTxt.backgroundColor=[UIColor clearColor];
    self.FormnameTxt.placeholder=@"Enter Form Name" ;
    self.FormnameTxt.delegate=self;
    self.FormnameTxt.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.FormnameTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.FormnameTxt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [view addSubview:self.FormnameTxt];

    [Formtable removeFromSuperview];
    Formtable=[[UITableView alloc]initWithFrame:CGRectMake(self.SelectFormTxt.frame.origin.x, self.SelectFormTxt.frame.origin.y+30,self.SelectFormTxt.frame.size.width, 100)];
    Formtable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [Formtable setDelegate:self];
    [Formtable setDataSource:self];
    [view addSubview:Formtable];
    Formtable.hidden=YES;
    
    UIButton *submitbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitbtn.frame=CGRectMake(15,self.view.frame.size.height-200, 135, 38);
    [submitbtn addTarget:self action:@selector(Createtable) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn setBackgroundImage:[UIImage imageNamed:@"creatform.png"] forState:UIControlStateNormal];
    [view addSubview:submitbtn];
  
    UIButton *CancelBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CancelBtn.frame=CGRectMake(165,self.view.frame.size.height-200, 135, 38);
    [CancelBtn addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    [CancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [view addSubview:CancelBtn];
}



-(void)popViewback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Tableview delegate
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
    return FieldnameArray.count;
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
               NSString *str1=[FieldnameArray objectAtIndex:indexPath.row];
            cell.textLabel.text=str1;
            NSString *tempstr=self.SelectFormTxt.text;
    
            if (![tempstr isEqualToString:@""] && tempstr.length>1) {
                if ([tempstr rangeOfString:str1 ].location!=NSNotFound)
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
    
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.SelectFormTxt.text=[FieldnameArray objectAtIndex:indexPath.row];
    selectedId=[FieldArray objectAtIndex:indexPath.row];

      Formtable.hidden=YES;
    
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

#pragma mark:textdelegate

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        NSLog(@"shouldChangeCharactersInRange");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textfield began ");
    @try {
        if (self.FormnameTxt)
        {
            if (textField==self.SelectFormTxt) {
                [textField resignFirstResponder];
                
                Formtable.frame=CGRectMake(textField.frame.origin.x, textField.frame.origin.y+30, textField.frame.size.width,100);
                if (FieldnameArray.count>0) {
                    Formtable.hidden=NO;
                    
                }
                
            }
        }
    }
    @catch (NSException *exception) {
           NSLog(@"Catch : textfield began");
    }
    @finally
    {
           NSLog(@"Finally : textfield began");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"Touch began");
    sleep(0.5);
    if (Formtable!=nil) {
        Formtable.hidden=YES;
    }
    if (self.FormnameTxt!=nil)
    {
      if ([self.FormnameTxt isFirstResponder]) {
                [self.FormnameTxt resignFirstResponder];
            }
    }
}
#pragma  mark:textfield delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)TabletouchesBegan
{
    NSInteger n=11;
    
    for (int i=0; i<FieldnameArray.count; i++)
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


-(void)SaveFormname
{
}


-(void)Createtable
{
   BOOL Flag= [self CheckFields];
    
  
    
    if (!Flag) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the all field names." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    //if ([mainDelegate.UserType isEqualToString:@"Liteuser"]) {
        int countn=[self getformCount];
        
        if (countn>=[mainDelegate.NOofForms intValue]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"You have reached the max limit for creating forms." message:@"To create more forms, you can:\n-  Delete an existing form." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];//or\n-  Sign up for the PRO version.
            [alert show];
            
            return;
        }

    //}
       [self InsertFormatabledata];
    return;
    

}

-(int)getformCount
{
    int Formcount=0;
    [DbSharedObj openDB];
    
    sqlite3_stmt *statement = nil;
    sqlite3 *Objsql=DbSharedObj.sDB;
    if (sqlite3_open(DbSharedObj.dbpath, &Objsql) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT count(id)  FROM tp_forms  where usertype='%@'",mainDelegate.UserType]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(DbSharedObj.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *formcount = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                Formcount=[formcount intValue];
                
            }
            sqlite3_finalize(statement);
            
        }
    }
    sqlite3_close(Objsql);
    return Formcount;
}


-(BOOL)CheckFields
{
    if (self.SelectFormTxt.text.length<1) {
        return NO;
    }
    else
        if (self.FormnameTxt.text.length<1) {
            return NO;

        }
    
    return YES;
}


- (NSMutableArray*) Getformnames
{
    [DbSharedObj openDB];
    NSMutableArray *Formsarray=[[NSMutableArray alloc]init];
    FieldArray=[[NSMutableArray alloc]init];
    
    sqlite3 *sDB=DbSharedObj.sDB;
    sqlite3_stmt *statement1 = nil;
    if (sqlite3_open(DbSharedObj.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT id,Formname  FROM Formtable"]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement1) == SQLITE_ROW)
			{
                const char* fid = (const char*)sqlite3_column_text(statement1, 0);
               NSString *Formid = fid == NULL ? nil : [[NSString alloc] initWithUTF8String:fid];
                [FieldArray addObject:Formid];

                const char* Rolename1 = (const char*)sqlite3_column_text(statement1, 1);
               NSString *Rolename = Rolename1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Rolename1];
                [Formsarray addObject:Rolename];

            }
        }
        sqlite3_finalize(statement1);
        
    }
    sqlite3_close(DbSharedObj.sDB);
    return Formsarray;
}


#pragma mark: database methods

-(void)InsertFormatabledata
{
    
    NSString *query1=[NSString stringWithFormat:@"SELECT * FROM tp_forms where form_name='%@' AND role_name='%@'",self.FormnameTxt.text,mainDelegate.UserType];
    
    BOOL RESULT=[DbSharedObj isLevelPresentLocally:query1];
    
    if (!RESULT)
    {
        NSString *mid;
        NSString *ftid;
        int maxId = 0;
        if ([mainDelegate.UserType isEqualToString:@"Liteuser"])
        {
            NSString *query=@"SELECT MAX(rowid),id FROM tp_forms";
            mid= [DbSharedObj Getmaxid:query ForTable:@"tp_forms"];
            ftid=@"";
            NSArray *arr=[mid componentsSeparatedByString:@"L"];
            if (arr.count==1)
            {
                NSArray *arr=[mid componentsSeparatedByString:@"L"];
                if ([arr count]>1)
                    maxId=[[arr objectAtIndex:1] intValue]+1;
                else
                    maxId=[[arr objectAtIndex:0] intValue]+1;
            }
            else
                maxId=[[arr objectAtIndex:1] intValue]+1;

            mid=[NSString stringWithFormat:@"%d",maxId];
            ftid=[NSString stringWithFormat:@"%d",[selectedId intValue]];
            
            NSString *Query=[NSString stringWithFormat:@"INSERT INTO tp_forms (id,form_name,role_name,ftid,TableNmae,dateCreated,dateModified,usertype) values ('%@','%@','%@','%@','%@','%@','%@','%@')",mid,self.FormnameTxt.text,SelectedRole,ftid,self.SelectFormTxt.text,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
            
            
            NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
            
            
            BOOL result= [DbSharedObj ExexuteOperation:Query];
            if (!result)
            {
                NSLog(@"Operation Fail");
            }
            else
            {
                NSLog(@"Operation successfully");
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Form created Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }

        }
        else
        {
            NSString *urlsrt = [NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_max_formid.php?cid=%@&form_name=%@",mainDelegate.Companyid,self.FormnameTxt.text];
        
            urlsrt = [urlsrt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlsrt];
            NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
            UIAlertView *waitAlt = [[UIAlertView alloc]initWithTitle:@"Please Wait..." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [waitAlt show];
        
            [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 [waitAlt dismissWithClickedButtonIndex:0 animated:YES];
                 if (data)
                 {
                    NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                     
                     NSLog(@"%@",d);
                
                    NSString * maxId=[[d valueForKey:@"data"] valueForKey:@"id"];
                    NSString *FtId=[NSString stringWithFormat:@"%d",[selectedId intValue]];

                
                    NSString *Query=[NSString stringWithFormat:@"INSERT INTO tp_forms (id,form_name,role_name,ftid,TableNmae,dateCreated,dateModified,usertype) values ('%@','%@','%@','%@','%@','%@','%@','%@')",maxId,self.FormnameTxt.text,SelectedRole,FtId,self.SelectFormTxt.text,[mainDelegate Getcurrentdate],[mainDelegate Getcurrentdate],mainDelegate.UserType];
                
                
                    BOOL result= [DbSharedObj ExexuteOperation:Query];
                    if (!result)
                    {
                    NSLog(@"Operation Fail");
                    }
                    else
                    {
                        NSLog(@"Operation successfully");
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Form created Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
             }];
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Same form name already exist please choose another." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"warning in createform");
}



@end
