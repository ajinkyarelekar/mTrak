//
//  RootViewTabbar.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 27/05/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//
#define HOME 1
#define FORM 2
#define INAPP 3
#define HELP 4


#import "RootViewTabbar.h"

@interface RootViewTabbar ()

@end

@implementation RootViewTabbar
@synthesize nav0,nav1,nav2,nav3;
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
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    if (!mainDelegate.LogoutFlag)
    {
        ViewController *Objlogin=[[ViewController alloc]init];
        UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:Objlogin];
        
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self presentViewController:nav4 animated:YES completion:nil];
        });
    
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    

    
    
     Baseview=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    [self.view addSubview:Baseview];
   
    
    HomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    HomeBtn.frame = CGRectMake(0,0,80,50);
    HomeBtn.tag=1;
    //    [HomeBtn setTitle:@"Media" forState:UIControlStateNormal];
    [HomeBtn setBackgroundImage:[UIImage imageNamed:@"Home_n.png"] forState:UIControlStateNormal];
    [HomeBtn setBackgroundImage:[UIImage imageNamed:@"Home_p.png"] forState:UIControlStateSelected];
    [HomeBtn addTarget:self action:@selector(TopmenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [Baseview addSubview:HomeBtn];
    
    FormBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FormBtn.frame = CGRectMake(80,0,80,50);
    FormBtn.tag=2;
    //    [HomeBtn setTitle:@"Media" forState:UIControlStateNormal];
    [FormBtn setBackgroundImage:[UIImage imageNamed:@"Form_n.png"] forState:UIControlStateNormal];
    [FormBtn setBackgroundImage:[UIImage imageNamed:@"Form_p.png"] forState:UIControlStateSelected];
    
    [FormBtn addTarget:self action:@selector(TopmenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [Baseview addSubview:FormBtn];
    
    InappBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    InappBtn.frame = CGRectMake(160,0,80,50);
    InappBtn.tag=3;
    //    [HomeBtn setTitle:@"Media" forState:UIControlStateNormal];
    [InappBtn setBackgroundImage:[UIImage imageNamed:@"sync_n.png"] forState:UIControlStateNormal];
    [InappBtn setBackgroundImage:[UIImage imageNamed:@"sync_p.png"] forState:UIControlStateSelected];
    
    [InappBtn addTarget:self action:@selector(TopmenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [Baseview addSubview:InappBtn];
    
    HelpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    HelpBtn.frame = CGRectMake(240,0,80,50);
    HelpBtn.tag=4;
    //    [HomeBtn setTitle:@"Media" forState:UIControlStateNormal];
    [HelpBtn setBackgroundImage:[UIImage imageNamed:@"Help_n.png"] forState:UIControlStateNormal];
    [HelpBtn setBackgroundImage:[UIImage imageNamed:@"Help_p.png"] forState:UIControlStateSelected];
    [HelpBtn addTarget:self action:@selector(TopmenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [Baseview addSubview:HelpBtn];

    [self getlogindetails];

    [self TopmenuClicked:HomeBtn];

}

-(void)getlogindetails
{
    ObjSharedDb=[DatabseInstance sharedInstance];
    [ObjSharedDb openDB];
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    sqlite3 *sDB=ObjSharedDb.sDB;
    sqlite3_stmt *statement1 = nil;
    if (sqlite3_open(ObjSharedDb.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = @"select * from userdetails";
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement1, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement1) == SQLITE_ROW)
			{
//                const char* formno = (const char*)sqlite3_column_text(statement1, 0);
//                mainDelegate.NOofForms = formno == NULL ? nil : [[NSString alloc] initWithUTF8String:formno];
                
                const char* sectno = (const char*)sqlite3_column_text(statement1, 1);
                  NSString *str  = sectno == NULL ? nil : [[NSString alloc] initWithUTF8String:sectno];
                mainDelegate.LogoutFlag=[str integerValue];
                mainDelegate.Firstloginflag=[str integerValue];
                
            }
        }
        sqlite3_finalize(statement1);
        
    }

    
}

-(void)TopmenuClicked:(id)Sender
{
    NSInteger tabBarItemSelected=[Sender tag];
    //handle in app preview show or hide
     mainDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    CGRect viewFrame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49);
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        if([UIScreen mainScreen].bounds.size.height==568)
        {
            //4 inch : 568
            viewFrame=CGRectMake(0, 0, 320, 568-49);
        }
        else
        {
            //3.5 inch: 480
            viewFrame=CGRectMake(0, 0, 320, 480-49);
        }
    }
    
    
    switch (tabBarItemSelected)
    {
        case HOME:
            if(nav0==nil)
            {
                //first time initialization
                HomeScreen *Objhome=[[HomeScreen alloc] init];
                nav0=[[UINavigationController alloc] initWithRootViewController:Objhome];
            }
            [nav0.view setFrame:viewFrame];
            
            if(currentView !=nil)
            {
                if(currentView!=nav0.view)
                {
                    //                    NSLog(@"amount raised subview added previous  removed");
                    [currentView removeFromSuperview];
                    currentView=nav0.view;
                    [self.view addSubview:nav0.view];
                }
                else
                {
                    [nav0 popToRootViewControllerAnimated:YES];
                }
                
            }
            else
            {
                currentView=nav0.view;
                [self.view addSubview:nav0.view];
            }
            [HomeBtn setBackgroundImage:[UIImage imageNamed:@"Home_p.png"] forState:UIControlStateNormal];
            [FormBtn setBackgroundImage:[UIImage imageNamed:@"Form_n.png"] forState:UIControlStateNormal];
            [InappBtn setBackgroundImage:[UIImage imageNamed:@"sync_n.png"] forState:UIControlStateNormal];
            [HelpBtn setBackgroundImage:[UIImage imageNamed:@"Help_n.png"] forState:UIControlStateNormal];

            
            break;
            
        case FORM:
            if(nav1==nil)
            {
                //first time initialization
                FormView *Objform=[[FormView alloc] init];
                nav1=[[UINavigationController alloc] initWithRootViewController:Objform];
            }
            mainDelegate.Comefromroot=YES;

            [nav1.view setFrame:viewFrame];
            //            [self.view addSubview:navContacts.view];
            
            
            if(currentView !=nil)
            {
                if(currentView!=nav1.view)
                {
                    //                    NSLog(@"amount raised subview added previous  removed");
                    [currentView removeFromSuperview];
                    currentView=nav1.view;
                    [self.view addSubview:nav1.view];
                }
                else
                {
                    [nav1 popToRootViewControllerAnimated:YES];
                }

            }
            else
            {
                currentView=nav1.view;
                [self.view addSubview:nav1.view];
            }
            [HomeBtn setBackgroundImage:[UIImage imageNamed:@"Home_n.png"] forState:UIControlStateNormal];
            [FormBtn setBackgroundImage:[UIImage imageNamed:@"Form_p.png"] forState:UIControlStateNormal];
            [InappBtn setBackgroundImage:[UIImage imageNamed:@"sync_n.png"] forState:UIControlStateNormal];
            [HelpBtn setBackgroundImage:[UIImage imageNamed:@"Help_n.png"] forState:UIControlStateNormal];

            break;
            
        case INAPP:
            if(nav2==nil)
            {
                //first time initialization
                Manageconnection *Manageobj=[[Manageconnection alloc]init];
//                InApppurchaseview *Objinapp=[[InApppurchaseview alloc] init];
                nav2=[[UINavigationController alloc] initWithRootViewController:Manageobj];
            }
            
            [nav2.view setFrame:viewFrame];
            if(currentView !=nil)
            {
                if(currentView!=nav2.view)
                {
                    //                    NSLog(@"amount raised subview added previous  removed");
                    [currentView removeFromSuperview];
                    currentView=nav2.view;
                    [self.view addSubview:nav2.view];
                }
            }
            else
            {
                currentView=nav2.view;
                [self.view addSubview:nav2.view];
            }
            [HomeBtn setBackgroundImage:[UIImage imageNamed:@"Home_n.png"] forState:UIControlStateNormal];
            [FormBtn setBackgroundImage:[UIImage imageNamed:@"Form_n.png"] forState:UIControlStateNormal];
            [InappBtn setBackgroundImage:[UIImage imageNamed:@"sync_p.png"] forState:UIControlStateNormal];
            [HelpBtn setBackgroundImage:[UIImage imageNamed:@"Help_n.png"] forState:UIControlStateNormal];

            break;
        case HELP:
            if(nav3==nil)
            {
                //first time initialization

                Help *objhelp=[[Help alloc] init];
                nav3=[[UINavigationController alloc] initWithRootViewController:objhelp];
            }
            mainDelegate.Comefromroot=YES;

            [nav3.view setFrame:viewFrame];
            //             [self.view addSubview:navSettings.view];
            
            if(currentView !=nil)
            {
                if(currentView!=nav3.view)
                {
                    //                    NSLog(@"amount raised subview added previous  removed");
                    [currentView removeFromSuperview];
                    currentView=nav3.view;
                    [self.view addSubview:nav3.view];
                }
            }
            else
            {
                currentView=nav3.view;
                [self.view addSubview:nav3.view];
            }
            
            [HomeBtn setBackgroundImage:[UIImage imageNamed:@"Home_n.png"] forState:UIControlStateNormal];
            [FormBtn setBackgroundImage:[UIImage imageNamed:@"Form_n.png"] forState:UIControlStateNormal];
            [InappBtn setBackgroundImage:[UIImage imageNamed:@"sync_n.png"] forState:UIControlStateNormal];
            [HelpBtn setBackgroundImage:[UIImage imageNamed:@"Help_p.png"] forState:UIControlStateNormal];

            break;

        default:
            break;
    }
    
    [self.view bringSubviewToFront:Baseview];
    
//    previousTabSelected=tabBarItemSelected;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
