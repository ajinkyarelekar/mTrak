//
//  ViewController.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;

    mainDlegate=(AppDelegate *)[UIApplication sharedApplication].delegate;

    self.view.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
    if (!mainDlegate.Initilaflag) {
        
        if (!mainDlegate.Firstloginflag) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Flog"];
            [[NSUserDefaults standardUserDefaults]synchronize ];
          
            HUD = [[UIAlertView alloc] initWithTitle:@"" message:@"Please wait while loading initial details." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [HUD show];
      
            [self performSelector:@selector(delay) withObject:nil afterDelay:0.1];
         
        }
    }
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, -20, 320,self.view.frame.size.height+20)];
    [imageview setImage:[UIImage imageNamed:@"Loginbg.png"]];
    
    view=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    [view addSubview:imageview];

     X=44;
    if (!IS_IPHONE_5) {
        X=40;
    }
    Liteuser = [UIButton buttonWithType:UIButtonTypeCustom];
    Liteuser.frame = CGRectMake(15, X+125,293/2, 70/2);
    [Liteuser addTarget:self       action:@selector(Btnclicked:)
     forControlEvents:UIControlEventTouchDown];
    Liteuser.tag=1;
//    [Liteuser setBackgroundImage:[UIImage imageNamed:@"Liteuser_n.png"] forState:UIControlStateNormal];
    [Liteuser setBackgroundImage:[UIImage imageNamed:@"Liteuser_p.png"] forState:UIControlStateNormal];
    [view addSubview:Liteuser];

    Prouser = [UIButton buttonWithType:UIButtonTypeCustom];
    Prouser.frame = CGRectMake(320/2, X+125,293/2, 70/2);
    Prouser.tag=2;
    [Prouser addTarget:self       action:@selector(Btnclicked:)
     forControlEvents:UIControlEventTouchDown];
    [Prouser setBackgroundImage:[UIImage imageNamed:@"PROuser_n.png"] forState:UIControlStateNormal];
    [Prouser setBackgroundImage:[UIImage imageNamed:@"PROuser_p.png"] forState:UIControlStateSelected];
//    [Prouser setTitle:@"Pro user" forState:UIControlStateNormal];
    [view addSubview:Prouser];

    
    uname=[[UITextField alloc]initWithFrame:CGRectMake(35, X+192, 516/2, 35)];
    passwd=[[UITextField alloc]initWithFrame:CGRectMake(35, X+247, 516/2, 35)];
    Companycode=[[UITextField alloc]initWithFrame:CGRectMake(35, X+300,516/2, 35)];
    
    uname.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwd.clearButtonMode=UITextFieldViewModeWhileEditing;
    Companycode.clearButtonMode=UITextFieldViewModeWhileEditing;
   
    
    UIImageView *imagebg1=[[UIImageView alloc]initWithFrame:CGRectMake(30, X+192, 520/2,36)];
    [imagebg1 setImage:[UIImage imageNamed:@"Textf.png"]];
    [view addSubview: imagebg1];

    uname.backgroundColor=[UIColor clearColor];
    uname.placeholder=@"Enter user name" ;
    uname.autocapitalizationType=UITextAutocapitalizationTypeNone;
    uname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    uname.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    // [uname.layer setCornerRadius:8.0f];
    
    UIImageView *imagebg2=[[UIImageView alloc]initWithFrame:CGRectMake(30, X+247, 520/2,36)];
    [imagebg2 setImage:[UIImage imageNamed:@"Textf.png"]];
    [view addSubview: imagebg2];

    passwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwd.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    passwd.backgroundColor=[UIColor clearColor];
    passwd.placeholder=@"Enter password" ;
    // [passwd.layer setCornerRadius:8.0f];
    passwd.secureTextEntry=YES;
    
     imagebg3=[[UIImageView alloc]initWithFrame:CGRectMake(30, X+300, 520/2, 36)];
    [imagebg3 setImage:[UIImage imageNamed:@"Textf.png"]];
    [view addSubview: imagebg3];
    imagebg3.hidden=YES;
    
    Companycode.delegate=self;
    Companycode.backgroundColor=[UIColor clearColor];
    Companycode.placeholder=@"Enter company id" ;
    Companycode.autocapitalizationType=UITextAutocapitalizationTypeNone;
    Companycode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Companycode.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    Companycode.hidden=YES;
    
    uname.delegate=self;
    passwd.delegate=self;
    Companycode.delegate=self;
    
    uname.text=@"Liteuser";
    passwd.text=@"Prouser";
    
     LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LoginBtn.frame = CGRectMake(30, X+300,520/2, 38);
    [LoginBtn addTarget:self       action:@selector(loginbuttonclicked)
     forControlEvents:UIControlEventTouchDown];
//    [LoginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [LoginBtn setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [view addSubview:LoginBtn];

    ForgotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ForgotBtn.frame = CGRectMake(90, X+370,135, 38);
    [ForgotBtn addTarget:self       action:@selector(Forgotclicked)
       forControlEvents:UIControlEventTouchDown];
    ForgotBtn.titleLabel.font=[UIFont boldSystemFontOfSize:13];
    [ForgotBtn setTitle:@"Forgot password" forState:UIControlStateNormal];
    [ForgotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:ForgotBtn];
    ForgotBtn.hidden=YES;

       [view addSubview:uname];
    [view addSubview:passwd];
    [view addSubview:Companycode];
    
    ObjSharedDb=[DatabseInstance sharedInstance];
}

-(void)delay
{
    [self Getquetiondatafromserver];
//    [self savlogindata];
    mainDlegate.Firstloginflag=YES;
}

-(void)Forgotclicked
{
    Resetpassword *reset=[[Resetpassword alloc]init];
    [self.navigationController pushViewController:reset animated:YES];

}

-(void)Btnclicked:(id)Sender
{
    if ([Sender tag]==1)
    {
        SelectedUser=@"Liteuser";
        [Liteuser setBackgroundImage:[UIImage imageNamed:@"Liteuser_p.png"] forState:UIControlStateNormal];
        [Prouser setBackgroundImage:[UIImage imageNamed:@"PROuser_n.png"] forState:UIControlStateNormal];
        LoginBtn.frame =  CGRectMake(30, X+315,520/2, 38);
        ForgotBtn.frame=CGRectMake(90, X+355,135, 38);
        Companycode.hidden=YES;
        Compnlbl.hidden=YES;
        imagebg3.hidden=YES;
        ForgotBtn.hidden=YES;
        uname.text=@"";
        passwd.text=@"";
    }
    else
    {
        SelectedUser=@"Prouser";
        [Prouser setBackgroundImage:[UIImage imageNamed:@"PROuser_p.png"] forState:UIControlStateNormal];
        [Liteuser setBackgroundImage:[UIImage imageNamed:@"Liteuser_n.png"] forState:UIControlStateNormal];

        [self Showotherview];
    }
}

- (void)Showotherview
{
    ForgotBtn.hidden=NO;
    uname.text=@"";
    passwd.text=@"";
    Companycode.hidden=NO;
    Compnlbl.hidden=NO;
    imagebg3.hidden=NO;
    LoginBtn.frame= CGRectMake(30, X+370,520/2, 38);
    ForgotBtn.frame=CGRectMake(90, X+410,135, 38);
}

#pragma mark:textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if (textField==passwd) {
    if (range.location > 0 && range.length == 1 && string.length == 0)
    {
        // iOS is trying to delete the entire string
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return NO;
    }
    //}
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([uname resignFirstResponder] || [passwd resignFirstResponder] ||[Companycode resignFirstResponder])
    {
        [uname resignFirstResponder];
        [passwd resignFirstResponder];
        [Companycode resignFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
//        self.view.frame = CGRectMake(0 ,0, 320, 480);
        view.contentOffset=CGPointMake(0, 0);
        [UIView commitAnimations];
        
    }
    else
    {
        
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    view.contentOffset=CGPointMake(0, 0);

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
//    self.view.frame = CGRectMake(0 ,0, 320, 480);
    view.contentOffset=CGPointMake(0, 0);
    [UIView commitAnimations];
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%f",textField.frame.origin.y);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];

    int n=170;
    if (!IS_IPHONE_5) {
        n=140;
    }
    view.contentOffset=CGPointMake(0, textField.frame.origin.y-n);
    [UIView commitAnimations];
    
    if (textField==Companycode) {
//        self.view.frame = CGRectMake(0, -150, 320, 480);
        view.contentOffset=CGPointMake(0, textField.frame.origin.y-n);

    }
}


#pragma mark:DB get login details
- (BOOL) afterDelaymethod
{
    //    SelectedUser=nil;
//    NSMutableArray *Formsarray=[[NSMutableArray alloc]init];
//    NSMutableArray *TablenamArr=[[NSMutableArray alloc]init];
    NSString *username=@"";
    NSString *password=@"";
//    NSString *Rolename=@"Admin";

    [ObjSharedDb openDB];

    sqlite3 *sDB=ObjSharedDb.sDB;
    sqlite3_stmt *statement1 = nil;
    if (sqlite3_open(ObjSharedDb.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT companycode,username,password,uid FROM tp_users where username='%@' AND password='%@'",uname.text,passwd.text]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement1) == SQLITE_ROW)
			{
//                const char* Rolename1 = (const char*)sqlite3_column_text(statement1, 0);
//                Rolename = Rolename1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Rolename1];
//                mainDlegate.Companyid=Rolename;
                
                const char* unam = (const char*)sqlite3_column_text(statement1, 1);
                username = unam == NULL ? nil : [[NSString alloc] initWithUTF8String:unam];

                const char* pwd = (const char*)sqlite3_column_text(statement1, 2);
                password = pwd == NULL ? nil : [[NSString alloc] initWithUTF8String:pwd];
                
                const char* usid = (const char*)sqlite3_column_text(statement1, 3);
                mainDlegate.Uid = usid == NULL ? nil : [[NSString alloc] initWithUTF8String:usid];

//                SelectedUser=Rolename;
            }
        }
        sqlite3_finalize(statement1);
        
    }
    sqlite3_close(sDB);

    
 
    if (![username isEqualToString:uname.text] && ![password isEqualToString:passwd.text] )
            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Incorrect username or password." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//                alert.tag=3;
//                [alert show];
//                [alert release];
                return NO;
            }
            else
            {
//                mainDlegate.Companyid=Rolename;
                mainDlegate.Companyid=Companycode.text;
                [[NSUserDefaults standardUserDefaults] setValue: mainDlegate.Companyid forKey:@"Companycode"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return YES;
//                objform.Role=SelectedUser;//uname.text;//@"Data Entry";
//                [ self.navigationController pushViewController:objform animated:YES];
            }
}


#pragma mark:LoginBtnclick

-(void)loginbuttonclicked
{
        if (uname.text.length==0 || passwd.text.length==0)
        {
            UIAlertView *Alter = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter valid username or password." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alter show];
            
        }
        else
        {

            if ([SelectedUser isEqualToString:@"Prouser"]) {
                mainDlegate.UserType=@"Prouser";
               BOOL Flag=  [self afterDelaymethod ];
                [self Getcompanyid];
                
                if (!Flag) {
                    UIAlertView *Alter = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter correct Username OR Password." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [Alter show];
                    return;
                }
                if (![mainDlegate.companyCode isEqualToString:Companycode.text]) {
                   
                    UIAlertView *Alter = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter correct company code." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [Alter show];
                    return;
                }
                
            }
            else
            {
                mainDlegate.UserType=@"Liteuser";
                if (![uname.text isEqualToString:@"Liteuser"] && ![passwd.text isEqualToString:@"Liteuser"]) {
                    UIAlertView *Alter = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Liteuser as username or password." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [Alter show];
                    return;
                }

            }
            [uname resignFirstResponder];
            [passwd resignFirstResponder];
            [Companycode resignFirstResponder];

            if (!mainDlegate.Firstloginflag) {
                if (!mainDlegate.Initilaflag) {
                    [self Getquetiondatafromserver];
                    mainDlegate.Firstloginflag=YES;
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Flog"];
                }
                else
                    [self GetappDetails];
                

            }
            else
                [self GetappDetails];
            
                      [[NSUserDefaults standardUserDefaults] setValue:mainDlegate.UserType forKey:@"Usertype"];

//            [[NSUserDefaults standardUserDefaults] setBool: mainDlegate.Firstloginflag forKey:@"Flog"];

            mainDlegate.LogoutFlag=YES;
          
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Logstatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
            [self savlogindata];

        }
    
}
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

-(void)savlogindata
{
    NSString *query=[NSString stringWithFormat:@"INSERT INTO userdetails(id,loginstatus,usertype) VALUES ('1','1','')"];
    
    BOOL Result= [ObjSharedDb ExexuteOperation:query];

    NSLog(@"%hhd",Result);
}

-(void)Getquetiondatafromserver
{
    if (!mainDlegate.checkInternet) {
        [HUD dismissWithClickedButtonIndex:0 animated:YES];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load Initial data.App will not work correctly untill you load initial data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSString*urlString1;
    
    urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack1/get_initial_detail.php?"];
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
             [self GetappDetails];
             [self SynLogintables];
             [HUD dismissWithClickedButtonIndex:0 animated:YES];
         }
         else
         {
             [HUD dismissWithClickedButtonIndex:0 animated:YES];

             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
         }
//     }];
    
}


#pragma mark setting varb for apps

-(void)GetappDetails
{
    [ObjSharedDb openDB];
    NSString *type=mainDlegate.UserType;
    if (type==nil) {
        type=@"Liteuser";
    }
    mainDlegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    sqlite3 *sDB=ObjSharedDb.sDB;
    sqlite3_stmt *statement1 = nil;
    if (sqlite3_open(ObjSharedDb.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT *FROM AppdetailTable where usertype='%@'",type]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement1) == SQLITE_ROW)
			{
                const char* formno = (const char*)sqlite3_column_text(statement1, 1);
                mainDlegate.NOofForms = formno == NULL ? nil : [[NSString alloc] initWithUTF8String:formno];
                
                const char* sectno = (const char*)sqlite3_column_text(statement1, 2);
                mainDlegate.NOofSections = sectno == NULL ? nil : [[NSString alloc] initWithUTF8String:sectno];
                
                const char* fieldno = (const char*)sqlite3_column_text(statement1, 3);
                mainDlegate.NOofFields = fieldno == NULL ? nil : [[NSString alloc] initWithUTF8String:fieldno];
                
                const char* imageno = (const char*)sqlite3_column_text(statement1, 4);
                mainDlegate.NOofimages = imageno == NULL ? nil : [[NSString alloc] initWithUTF8String:imageno];
                
                const char* videono = (const char*)sqlite3_column_text(statement1, 5);
                mainDlegate.NOofVideo = videono == NULL ? nil : [[NSString alloc] initWithUTF8String:videono];
                
                const char* audio = (const char*)sqlite3_column_text(statement1, 6);
                mainDlegate.NOofAudio = audio == NULL ? nil : [[NSString alloc] initWithUTF8String:audio];
                
//                const char* companycode = (const char*)sqlite3_column_text(statement1, 7);
//                mainDlegate.companyCode = companycode == NULL ? nil : [[NSString alloc] initWithUTF8String:audio];
            }
        }
        sqlite3_finalize(statement1);
        
    }
    
}

-(void)Getcompanyid
{
    [ObjSharedDb openDB];
    
    mainDlegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    sqlite3 *sDB=ObjSharedDb.sDB;
    sqlite3_stmt *statement1 = nil;
    if (sqlite3_open(ObjSharedDb.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT *FROM companyidTable"]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement1) == SQLITE_ROW)
			{
                const char* companycode = (const char*)sqlite3_column_text(statement1, 1);
                mainDlegate.companyCode = companycode == NULL ? nil : [[NSString alloc] initWithUTF8String:companycode];
            }
            sqlite3_finalize(statement1);
            
        }
    }
}

-(void)Insertintotable:(NSArray*)Temparray
{
//    [ObjSharedDb openDB];
    ObjSharedDb=[DatabseInstance sharedInstance];

    NSArray *Temparray1=[Temparray objectAtIndex:0];
    NSArray *Temparray2=[Temparray objectAtIndex:1];
    NSArray *Temparray3=[Temparray objectAtIndex:2];
    NSArray *Temparray4=[Temparray objectAtIndex:3];
    NSArray *Temparray5=[Temparray objectAtIndex:4];
    NSArray *Temparray6=[Temparray objectAtIndex:5];
    NSArray *Temparray7=[Temparray objectAtIndex:6];
    NSArray *Temparray8=[Temparray objectAtIndex:7];
    NSArray *Temparray9=[Temparray objectAtIndex:8];
    
    for (int i=0; i< Temparray1.count;i++)
    {
        NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_forms(TableNmae,id,ftid,form_name,role_name,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','Liteuser')",[[Temparray1 objectAtIndex:i] valueForKey:@"TableName"],[[Temparray1 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray1 objectAtIndex:i] valueForKey:@"ftid"],[[Temparray1 objectAtIndex:i] valueForKey:@"form_name"],[[Temparray1 objectAtIndex:i] valueForKey:@"role_name"],[[Temparray1 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray1 objectAtIndex:i] valueForKey:@"dateModified"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }

    
    for (int i=0; i< Temparray2.count;i++) {
        
        NSString *query=[NSString stringWithFormat:@"INSERT INTO Formtable(id,Formname,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','Liteuser')",[[Temparray2 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray2 objectAtIndex:i] valueForKey:@"formname"],[[Temparray2 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray2 objectAtIndex:i] valueForKey:@"dateModified"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }

    
    for (int i=0; i< Temparray3.count;i++) {
        
        NSString *query=[NSString stringWithFormat:@"INSERT INTO Levels(rowid,formid,Level1_name,Level2_name,Level3_name,sectionid,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','Liteuser')",[[Temparray3 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray3 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray3 objectAtIndex:i] valueForKey:@"level1_name"],[[Temparray3 objectAtIndex:i] valueForKey:@"level2_name"],[[Temparray3 objectAtIndex:i] valueForKey:@"level3_name"],[[Temparray3 objectAtIndex:i] valueForKey:@"sectionid"],[[Temparray3 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray3 objectAtIndex:i] valueForKey:@"dateModified"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }

    
    for (int i=0; i< Temparray4.count;i++) {
        
        NSString *query=[NSString stringWithFormat:@"INSERT INTO FieldDetailtable(id,formid,fieldname,fieldtype,fieldno,sectionid,fielddescription,fieldsubtitle,editable,visible,dateCreated,dateModified,usertype) VALUES ('%d','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','Liteuser')",[[[Temparray4 objectAtIndex:i] valueForKey:@"unique_id"] intValue],[[Temparray4 objectAtIndex:i] valueForKey:@"formid"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldname"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldtype"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldno"],[[Temparray4 objectAtIndex:i] valueForKey:@"sectionid"],[[Temparray4 objectAtIndex:i] valueForKey:@"fielddescription"],[[Temparray4 objectAtIndex:i] valueForKey:@"fieldsubtitle"],[[Temparray4 objectAtIndex:i] valueForKey:@"editable"],[[Temparray4 objectAtIndex:i] valueForKey:@"visible"],[[Temparray4 objectAtIndex:i] valueForKey:@"dateCreated"] ,[[Temparray4 objectAtIndex:i] valueForKey:@"dateModified"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }

    for (int i=0; i< Temparray5.count;i++) {
        
        NSString *query=[NSString stringWithFormat:@"INSERT INTO AppdetailTable(id,no_of_audio,no_of_fields,no_of_forms,no_of_image,no_of_sections,no_of_video,usertype,company_code,usertype) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','Liteuser')",[[Temparray5 objectAtIndex:i] valueForKey:@"id"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_audio"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_fields"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_forms"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_image"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_sections"],[[Temparray5 objectAtIndex:i] valueForKey:@"no_of_video"],[[Temparray5 objectAtIndex:i] valueForKey:@"usertype"],[[Temparray5 objectAtIndex:i] valueForKey:@"company_code"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }
    
    for (int i=0; i< Temparray6.count;i++) {
        
        NSString *Query1=[NSString stringWithFormat:@"select * FROM SectionTable where formid=%@ AND sid='%@'",[[Temparray6 objectAtIndex:i] valueForKey:@"formid"],[[Temparray6 objectAtIndex:i] valueForKey:@"sid"]];
        BOOL ExistFlag=[ObjSharedDb isLevelPresentLocally:Query1];
        
        BOOL Result=NO;
        
        if (!ExistFlag) {
            NSString *query=[NSString stringWithFormat:@"INSERT INTO SectionTable(sid,section_name,formid,hidden,usertype) VALUES ('%@','%@','%@','1','Liteuser')",[[Temparray6 objectAtIndex:i] valueForKey:@"sid"],[[Temparray6 objectAtIndex:i] valueForKey:@"Name"],[[Temparray6 objectAtIndex:i] valueForKey:@"formid"]];
            
             Result= [ObjSharedDb ExexuteOperation:query];

        }
        
        NSLog(@"%d",Result);
    }

    for (int i=0; i< Temparray7.count;i++) {
        
        NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_level1_master(rowid,formid,level1_data,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','Liteuser')",[[Temparray7 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray7 objectAtIndex:i] valueForKey:@"formid"],[[Temparray7 objectAtIndex:i] valueForKey:@"level1_data"],[[Temparray7 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray7 objectAtIndex:i] valueForKey:@"dateModified"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }
    
    for (int i=0; i< Temparray8.count;i++) {
        
        NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_level2_master(rowid,level1_id,level2_data,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','Liteuser')",[[Temparray8 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray8 objectAtIndex:i] valueForKey:@"level1_id"],[[Temparray8 objectAtIndex:i] valueForKey:@"level2_data"],[[Temparray8 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray8 objectAtIndex:i] valueForKey:@"dateModified"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }
    
    for (int i=0; i< Temparray9.count;i++) {
        
        NSString *query=[NSString stringWithFormat:@"INSERT INTO tp_level3_master(rowid,level3_data,level2_id,level1_id,dateCreated,dateModified,usertype) VALUES ('%@','%@','%@','%@','%@','%@','Liteuser')",[[Temparray9 objectAtIndex:i] valueForKey:@"unique_id"],[[Temparray9 objectAtIndex:i] valueForKey:@"level3_data"],[[Temparray9 objectAtIndex:i] valueForKey:@"level2_id"],[[Temparray9 objectAtIndex:i] valueForKey:@"level1_id"],[[Temparray9 objectAtIndex:i] valueForKey:@"dateCreated"],[[Temparray9 objectAtIndex:i] valueForKey:@"dateModified"]];
        
        BOOL Result= [ObjSharedDb ExexuteOperation:query];
        
        NSLog(@"%d",Result);
    }

}

//syn login tabel
-(void)SynLogintables
{
    if (mainDlegate.Companyid.length<1) {
        mainDlegate.Companyid=@"";
    }
    
    NSString *urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack1/get_tp_role_user.php?&cid=%@",mainDlegate.Companyid];
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
            NSMutableArray *LoginArray=[NSMutableArray arrayWithArray:strretun1];
             [self RecordInsertQuery:LoginArray];
             
         }
         else
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert1 show];
         }
     }];
    
}

#pragma mark:database operations
-(void)RecordInsertQuery:(NSMutableArray*)LoginArray
{
    [ObjSharedDb openDB];
    int res = SQLITE_ERROR;
    //    int res1 = SQLITE_ERROR;
    sqlite3 *sDB=ObjSharedDb.sDB;
    res = sqlite3_open(ObjSharedDb.dbpath, &sDB);
	
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
        
        BOOL Flag=[ObjSharedDb isLevelPresentLocally:[NSString stringWithFormat:@"SELECT *FROM tp_users WHERE uid=%@",str1]];
        
        if (!Flag)
        {
            
            NSString *querySQL = [NSString stringWithFormat: @"insert into tp_users (name,username,password,email,phone) values('%@','%@','%@','%@','%@')",name,username,password,email,phone];
            
            const char *sql = [querySQL UTF8String];
            //NSLog(@"%@", querySQL);
            
            [ObjSharedDb openDB];
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
            
            
            [ObjSharedDb openDB];
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
        else
        {
            NSLog(@"Present");
        }
    }

}


-(void)Gettabledatafromsever
{
    NSString*urlString1;
    
    urlString1=[NSString stringWithFormat:@"http://ira-infosolutions.com/mtrack/get_question.php?"];
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
             
             //             strretun=[NSMutableArray arrayWithArray:strretun1];
             NSLog(@"%@",strretun1);
             [self Insertintotable:strretun1];
             
         }
         else
         {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
         }
     }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
