//
//  AppDelegate.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate
@synthesize Rootnav;
@synthesize Loginuser,Companyid,SelectedRidearray,Selectedtable,Selectedidarray,Levelnamearray,Backflag,LogoutFlag,Firstloginflag,UserType,Alldataflag,formTid;
@synthesize LastSyncdate,Recordflag;
@synthesize companyCode;
@synthesize Initilaflag;
//app detail varb
@synthesize NOofForms,NOofSections,NOofFields,NOofimages,NOofAudio,NOofVideo,Uid;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    LogoutFlag=[[NSUserDefaults standardUserDefaults] boolForKey:@"Logstatus"];
    Firstloginflag=[[NSUserDefaults standardUserDefaults] boolForKey:@"Flog"];
    UserType=[[NSUserDefaults standardUserDefaults] valueForKey:@"Usertype"];
    LastSyncdate=[[NSUserDefaults standardUserDefaults] valueForKey:@"Syncdate"] ;
    Companyid=[[NSUserDefaults standardUserDefaults] valueForKey:@"Companycode"];

    [self Showrootview1];
    [[UILabel appearance] setFont:[UIFont fontWithName:@"MYRIADPRO-REGULAR" size:13.0]];
        

        [self.window makeKeyAndVisible];
    return YES;
}

-(void)Showrootview
{
    NSString *query=@"DELETE from userdetails";
    ObjSharedDb=[DatabseInstance sharedInstance];
    [ObjSharedDb openDB];
    [ObjSharedDb ExexuteOperation:query];

    if (Rootnav!=nil)
    {
        Rootnav=nil;
    }
    Firstloginflag=NO;

    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Logstatus" ];
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey:@"Flog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    RootViewTabbar *obj0 =[[RootViewTabbar alloc]init];
    Rootnav=[[UINavigationController alloc]initWithRootViewController:obj0];

    [self.window setRootViewController:Rootnav];
    Initilaflag=1;
    }

-(void)Showrootview1
{
    if (Rootnav!=nil)
    {
        Rootnav=nil;
    }
    Firstloginflag=NO;
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Logstatus" ];
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey:@"Flog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    RootViewTabbar *obj0 =[[RootViewTabbar alloc]init];
    Rootnav=[[UINavigationController alloc]initWithRootViewController:obj0];
    
    [self.window setRootViewController:Rootnav];
    
}



-(BOOL)checkInternet
{
	//Test for Internet Connection
	Reachability *r = [Reachability reachabilityWithHostName:@"google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
    
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
    {
		internet = NO;
	}
    else
    {
		internet = YES;
	}
	return internet;
}

-(NSString*)Getcurrentdate
{
    NSString *Constdate=@"";
    

    //set timezones//en_IN
    NSLocale *indianEnglishLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Kolkata"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:indianEnglishLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:timeZone];
    
    Constdate=[dateFormatter stringFromDate:[NSDate date]];
    
    return Constdate;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

    [[NSUserDefaults standardUserDefaults] setBool:LogoutFlag forKey:@"Logstatus"];
    [[NSUserDefaults standardUserDefaults] setBool:Firstloginflag forKey:@"Flog"];
    [[NSUserDefaults standardUserDefaults] setValue:LastSyncdate forKey:@"Syncdate"];
    [[NSUserDefaults standardUserDefaults] setValue:UserType forKey:@"Usertype"];

       // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

-(void)Logout:(UINavigationController*)view
{
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Logstatus" ];
    [view.navigationController popToRootViewControllerAnimated:YES];
    [self Showrootview];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
