//
//  Resetpassword.m
//  Shpockpages
//
//  Created by Nanostuffs on 8/14/13.
//  Copyright (c) 2013 Trupti. All rights reserved.
//
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#import "Resetpassword.h"
#import <QuartzCore/QuartzCore.h>
@interface Resetpassword ()

@end

@implementation Resetpassword

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
      [Emailaddr becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title=@"Reset Password";
    UIImageView *img=[[UIImageView alloc]init];
    img.image=[UIImage imageNamed:@"Background.png"];
    [self.view addSubview:img];
    
    if (Adjust_Height ==20) {
        UIView *statbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,20)];
        [statbar setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
        [self.view addSubview:statbar];
        
    }

    maindelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    UIImageView *Navbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320,46)];
    [Navbar setImage:[UIImage imageNamed:@"Navigation1.png"]];
    Navbar.userInteractionEnabled=YES;
    [self.view addSubview:Navbar];
    
    UILabel *Title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    Title.text=@"Reset Password";
    Title.font=[UIFont boldSystemFontOfSize:13];
    Title.backgroundColor=[UIColor clearColor];
    Title.textAlignment=NSTextAlignmentCenter;
    [Navbar addSubview:Title];
    Title.textColor=[UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,7,50,30);
    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Backview) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [Navbar addSubview:button];
  //  [self.view addSubview:view];

    UILabel *Label=[[UILabel alloc]initWithFrame:CGRectMake(30,Adjust_Height+20, 250,100)];
    Label.lineBreakMode=NSLineBreakByCharWrapping;
    Label.numberOfLines=4;
    Label.backgroundColor=[UIColor clearColor];
    Label.textColor=[UIColor blackColor];
    Label.font=[UIFont systemFontOfSize:13];
    Label.text=@"Please Enter the email address  & follow instruction in the email you get from us.";
    [self.view addSubview:Label];
    
    UIImageView *imagebg1=[[UIImageView alloc]initWithFrame:CGRectMake(30, Adjust_Height+99, 260, 41)];
    [imagebg1 setImage:[UIImage imageNamed:@"Textf.png"]];
    [self.view addSubview: imagebg1];

    Emailaddr=[[UITextField alloc]initWithFrame:CGRectMake(50, Adjust_Height+99, 260, 40)];
 //   [Emailaddr setBorderStyle:UITextBorderStyleBezel];
    Emailaddr.backgroundColor=[UIColor clearColor];
    Emailaddr.placeholder=@"Email Address";
    Emailaddr.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Emailaddr.keyboardType=UIKeyboardTypeEmailAddress;
    Emailaddr.font=[UIFont fontWithName:@"Roboto" size:14];
    Emailaddr.autocapitalizationType=UITextAutocapitalizationTypeNone;
    
//    UIImageView *ftemp=[[UIImageView alloc]initWithFrame:CGRectMake(10, 85, 300, 40)];
//    ftemp.image=[UIImage imageNamed:@"Row2.png"];

    
    if (IS_IPHONE_5) {
        if (SYSTEM_VERSION_GREATER_THAN(@"6.8")) {
            img.frame= CGRectMake(0, 20, 320,568);
        }
        else
            img.frame= CGRectMake(0, 0, 320,568);

    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN(@"6.8")) {
            img.frame= CGRectMake(0, 20, 320,480);

        }
        else
            img.frame= CGRectMake(0, 0, 320,480);

    }
    
    UIButton *buttonReg=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonReg setFrame:CGRectMake(30, 200, 260, 38)];
    [buttonReg addTarget:self       action:@selector(Resetbuttonclicked)
        forControlEvents:UIControlEventTouchDown];
    [buttonReg setTitle:@"Send" forState:UIControlStateNormal];
    [buttonReg.titleLabel setTextAlignment:NSTextAlignmentCenter];
    buttonReg.layer.borderWidth=1.0;
    buttonReg.layer.cornerRadius=5.0;
    buttonReg.layer.borderColor=[UIColor grayColor].CGColor;
    [buttonReg setBackgroundColor:[UIColor colorWithRed:(43/255.0) green:(120/255.0) blue:(169/255.0) alpha:1.0]];
//    [buttonReg setImage:[UIImage imageNamed:@"save1.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonReg];
//    [self.view addSubview:ftemp];
     [self.view addSubview:Emailaddr];

  
}

-(void)done
{
    [Emailaddr resignFirstResponder];
}

-(void)Backview
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)validateEmail:(NSString *)inputText
{
    NSString *emailRegex = @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    
    
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:inputText];
    
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

int direction=1;
int shakes=5;

-(void)shake:(UIView *)theOneYouWannaShake
{
    [UIView animateWithDuration:0.03 animations:^
     {
         theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*direction, 0);
     }
                     completion:^(BOOL finished)
     {
         if(shakes >= 10)
         {
             theOneYouWannaShake.transform = CGAffineTransformIdentity;
             return;
         }
         shakes++;
         direction = direction * -1;
         [self shake:theOneYouWannaShake];
     }];
}

-(void)Resetbuttonclicked
{
  
    if (Emailaddr.text.length<2) {
        [self shake:Emailaddr];
        return;
    }
    
    if (Emailaddr) {
        [Emailaddr resignFirstResponder];
        
    }
      if(maindelegate.checkInternet==NO)
    {
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: NSLocalizedString(@"Network Error", @"Network Error")
                     message: NSLocalizedString(@"You need an Internet connection to proceed.", @"Network error")
                     delegate: self
                     cancelButtonTitle: NSLocalizedString(@"Close", @"Network Error") otherButtonTitles: nil];
        
        [errorView show];
        return;
    }

    indiAlter = [[UIAlertView alloc] initWithTitle:@"Please Wait..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [indiAlter show];
    UIActivityIndicatorView *activityview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityview.center = CGPointMake(indiAlter.bounds.size.width / 2,indiAlter.bounds.size.height - 50);
    [activityview startAnimating];
    [indiAlter addSubview:activityview];
    
    [self performSelector:@selector(afterDelaymethod) withObject:nil afterDelay:0.5];
}

-(void)afterDelaymethod
{
   if([self NSStringIsValidEmail:Emailaddr.text])
   {
    NSString *urlStr = [NSString stringWithFormat:@"http://ira.com/mtrack/forget.php?email=%@&cid=%@&uid=%@",Emailaddr.text,maindelegate.Companyid,maindelegate.Uid];
    
    NSLog(@" URL : %@",urlStr);
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
        
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
       
//    NSLog(@"Return Data is:%@", returnString);
       
       NSRange textRange;
       textRange =[returnString rangeOfString:@"1"];
       
       if(textRange.location != NSNotFound)
       {
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Check your email to reset password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
           [alert show];

       }
       else
       {
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter a Registered email id" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
           [alert show];
       }
   }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter a valid email id" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];

    }
        
    [indiAlter dismissWithClickedButtonIndex:0 animated:YES];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    [Emailaddr resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [Emailaddr resignFirstResponder];

    //[textField resignFirstResponder];
    
       
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
