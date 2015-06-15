//
//  HomeScreen.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "HomeScreen.h"

@interface HomeScreen ()

@end

@implementation HomeScreen

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
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;

    for (UIView *views in self.view.subviews )
    {
        if (views.tag==15)
        {
             for (UIView *view in views.subviews )
             {
                 if ([view isKindOfClass:[UIButton class]])
                 {
                     UIButton *btn=(UIButton*)view;
                     if (view.tag==2)
                     {
                        [self getformCount];
                        NSString *formsname=[NSString stringWithFormat:@"(%d)",Formcount];
                        [btn setTitle:formsname forState:UIControlStateNormal];
                     }
                 }
             }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    ObjSharedDb=[DatabseInstance sharedInstance];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height)];
    [imageview setImage:[UIImage imageNamed:@"Background.png"]];
    [self.view addSubview:imageview];

    if (Adjust_Height ==20)
    {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];
        
    }

    UIImageView *Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    [Navbar setUserInteractionEnabled:YES];
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=@"Home Screen";
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.textAlignment=NSTextAlignmentCenter;
    Title.textColor=[UIColor whiteColor];
    Title.backgroundColor=[UIColor clearColor];
    [Navbar addSubview:Title];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+44, 320, self.view.frame.size.height-Adjust_Height)];
    view.tag=15;
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];

    UILabel *Titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10,240, 20)];
    Titlelabel.text=@"Welcome To mTrak";
    Titlelabel.font=[UIFont systemFontOfSize:16];
    Titlelabel.textAlignment=NSTextAlignmentCenter;
    Titlelabel.backgroundColor=[UIColor clearColor];
    [view addSubview:Titlelabel];

    UILabel *Titlesublabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 40,290, 25)];
    Titlesublabel.text=@"To continue, select one of the following options";
    Titlesublabel.font=[UIFont systemFontOfSize:13];
    Titlesublabel.textAlignment=NSTextAlignmentCenter;
    Titlesublabel.backgroundColor=[UIColor clearColor];
    [view addSubview:Titlesublabel];
    
    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    [Navbar addSubview:LogoutBtn];
    NSArray *btnarray=[NSArray arrayWithObjects:@"createnewform.png",@"openform.png",@"howuseapp.png", nil];
    int x=30;
    int y=120;
    
    for (int i=0;i<3 ; i++)
    {
        UIButton * Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake(x, y, 520/2, 76/2);
        Button.tag=i+1;
        [Button setBackgroundImage:[UIImage imageNamed:[btnarray objectAtIndex:i]] forState:UIControlStateNormal];
        Button.titleLabel.font=[UIFont systemFontOfSize:13];
        [Button addTarget:self action:@selector(ShowBtnPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Button];
        
        y=y+50;
    }

    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [self GetappDetails];

    }

#pragma mark setting varb for apps

-(void)GetappDetails
{
    [ObjSharedDb openDB];
    NSString *type=mainDelegate.UserType;
    if (type==nil) {
        type=@"Liteuser";
    }
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
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
                mainDelegate.NOofForms = formno == NULL ? nil : [[NSString alloc] initWithUTF8String:formno];
                
                const char* sectno = (const char*)sqlite3_column_text(statement1, 2);
                mainDelegate.NOofSections = sectno == NULL ? nil : [[NSString alloc] initWithUTF8String:sectno];
                
                const char* fieldno = (const char*)sqlite3_column_text(statement1, 3);
                mainDelegate.NOofFields = fieldno == NULL ? nil : [[NSString alloc] initWithUTF8String:fieldno];
                
                const char* imageno = (const char*)sqlite3_column_text(statement1, 4);
                mainDelegate.NOofimages = imageno == NULL ? nil : [[NSString alloc] initWithUTF8String:imageno];
                
                const char* videono = (const char*)sqlite3_column_text(statement1, 5);
                mainDelegate.NOofVideo = videono == NULL ? nil : [[NSString alloc] initWithUTF8String:videono];
                
                const char* audio = (const char*)sqlite3_column_text(statement1, 6);
                mainDelegate.NOofAudio = audio == NULL ? nil : [[NSString alloc] initWithUTF8String:audio];
                
          
            }
        }
        sqlite3_finalize(statement1);
        
    }
    
}


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
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [mainDelegate Showrootview];
    
}


-(void)ShowBtnPressed:(id)Sender
{

    int Val=[Sender tag];
    switch (Val) {
        case 1:
        {
            CreateForm *Objform=[[CreateForm alloc]init];
            [self.navigationController pushViewController:Objform animated:YES];
        }
            break;
        case 2:
        {
            mainDelegate.Comefromroot=NO;
            FormView *ObForms=[[FormView alloc]init];
            [self.navigationController pushViewController:ObForms animated:YES];
            
        }
            break;
        case 3:
        {
            mainDelegate.Comefromroot=NO;

            Help *Objhelp=[[Help alloc]init];
            [self.navigationController pushViewController:Objhelp animated:YES];
        }
            break;
        case 4:
        {
            mainDelegate.Comefromroot=NO;
        }

        default:
            break;
    }
}

-(void)getformCount
{
    [ObjSharedDb openDB];
    
      sqlite3_stmt *statement = nil;
    sqlite3 *Objsql=ObjSharedDb.sDB;
    if (sqlite3_open(ObjSharedDb.dbpath, &Objsql) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"SELECT count(id) FROM tp_forms  where usertype='%@' AND form_name NOT IN('Inspection Form','Service Call Form')",mainDelegate.UserType]; //order by id DESC limit 1
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(ObjSharedDb.sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *formcount = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                Formcount=[formcount integerValue];
                }
            sqlite3_finalize(statement);
                    
        }
    }
    sqlite3_close(Objsql);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
