//
//  Help.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "Help.h"

@interface Help ()

@end

@implementation Help

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
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height)];
    [imageview setImage:[UIImage imageNamed:@"Background.png"]];
    [self.view addSubview:imageview];

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
    Title.text=@"Help & User Guide";
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

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, Adjust_Height+93, 320, self.view.frame.size.height-(Adjust_Height+93))];
    
    [webView setDelegate:self];
    webView.dataDetectorTypes=UIDataDetectorTypeAll;
    [self.view addSubview:webView];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0,Adjust_Height+43,106.5,54);
    button1.tag=1;
    [button1 setTitle:@"Quick start"  forState:UIControlStateNormal];
    button1.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [button1 setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(topMenuclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(106.5,Adjust_Height+43,106.5,54);
        button2.tag=2;
    button2.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [button2 setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
    [button2 setTitle:@"User guide"  forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(topMenuclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(213,Adjust_Height+43,106.5,54);
        button3.tag=3;
    button3.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [button3 setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateSelected];
    [button3 setTitle:@"About"  forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(topMenuclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];

    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;

    if (!mainDelegate.Comefromroot) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0,7,50,30);
        [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
        [Navbar addSubview:button];
    }
  
    

    [self topMenuclicked:button1];
}

-(void)topMenuclicked:(id)Sender
{
    int i=[Sender tag];
    
    if (Prevbtn) {
        [Prevbtn setBackgroundImage:[UIImage imageNamed:@"F_n.png"] forState:UIControlStateNormal];
        
    }
    UIButton *Btn=(UIButton*)Sender;
    
    
    Prevbtn=Btn;
    [Btn setBackgroundImage:[UIImage imageNamed:@"F_p.png"] forState:UIControlStateNormal];


    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *myFile;
  
    if (i==1) {
        myFile = [mainBundle pathForResource: @"quick_start" ofType: @"docx"];

    }
    else
        if (i==2) {
            myFile = [mainBundle pathForResource: @"user_guide" ofType: @"docx"];

        }
    else
    {
        myFile = [mainBundle pathForResource: @"About" ofType: @"docx"];

    }
    
    NSURL *url = [NSURL fileURLWithPath:myFile];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    webView.scalesPageToFit=YES;

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
}

#pragma mark - webview delegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    activityIndicatorLoading =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorLoading.center=self.view.center;
    activityIndicatorLoading.hidesWhenStopped=YES;
    [self.view addSubview:activityIndicatorLoading];
    
    [activityIndicatorLoading startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    
    [webView1 stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    
    //font size
    [webView1 stringByEvaluatingJavaScriptFromString: @"document.getElementsByTagName('body')[0].style.fontSize = '26px'"];
    [activityIndicatorLoading stopAnimating];
    
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error in loading : %@",error);
    [activityIndicatorLoading stopAnimating];
}


-(void)Logout
{
    mainDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    mainDelegate.LogoutFlag=NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [mainDelegate Showrootview];
    
}

-(void)popViewback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
