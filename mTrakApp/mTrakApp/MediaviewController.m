//
//  MediaviewController.m
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 19/05/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#import "MediaviewController.h"

@interface MediaviewController ()

@end

@implementation MediaviewController
@synthesize Mediatype,Selectedtable;

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

    mainDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Objshareddb=[DatabseInstance sharedInstance];
    
    self.navigationController.navigationBarHidden=YES;
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0,0,51,32);
//    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
//    
//    [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    UIImageView *img;
    img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    img.image=[UIImage imageNamed:@"Background.png"];
    [self.view addSubview:img];
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
    Title.text=@"Media View";
    Title.font=[UIFont boldSystemFontOfSize:16];
    Title.backgroundColor=[UIColor clearColor];
    Title.textColor=[UIColor whiteColor];
    Title.textAlignment=NSTextAlignmentCenter;
    [Navbar addSubview:Title];
    
    UIButton *LogoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutBtn.frame = CGRectMake(278,0,42,44);
    [LogoutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [LogoutBtn addTarget:self action:@selector(Logoutclicked) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [Navbar addSubview:LogoutBtn];

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height+44, 320, self.view.frame.size.height-Adjust_Height)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,7,50,30);
    [button setBackgroundImage:[UIImage imageNamed:@"Back_N.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewback) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [Navbar addSubview:button];

    if ([self.Mediatype isEqualToString:@"audio"]) {
        self.title=@"Audio";
    }
else
   if( [self.Mediatype isEqualToString:@"video"])
{
    self.title=@"Video";

}
    else
    {
        self.title=@"Images";
    }
    
    MainUIview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, self.view.frame.size.height-100)];
    MainUIview.scrollEnabled=YES;
    MainUIview.backgroundColor=[UIColor whiteColor];
    [view addSubview:MainUIview];
    
    [self ShowMedia];
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

#pragma mark:show media methods
int flag=0;

-(void)ShowMedia
{
    [self GetDetailarray];
    if (DetailsArray.count<1) {
        
        UILabel *label=[[UILabel alloc]initWithFrame: CGRectMake(0, 100, 300, 80)];
        label.textAlignment=NSTextAlignmentCenter;
        label.lineBreakMode=NSLineBreakByWordWrapping;
        label.font=[UIFont systemFontOfSize:13];
        label.numberOfLines=0;
          label.text=[NSString stringWithFormat:@"No %@ to display please press on plus button then select action & finally press save button ",Mediatype ];
        [MainUIview addSubview:label];

    }
    
    Totalrows = ([DetailsArray count]/3)+1;
    flag=0;
    for (int i = 0; i < Totalrows; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            flag++;
            
            if (flag < [DetailsArray count]+1)
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[DetailsArray objectAtIndex:flag-1]];
//                UIImage *img1  =[[UIImage alloc]init];
                NSData *data= [NSData dataWithContentsOfFile:savedImagePath];
                
                UIImage *thumbImg=[UIImage imageWithData:data];
                UIImageView *imageView = [[UIImageView alloc]  initWithFrame:CGRectMake(5.5+(104*j),10+(120 * i),100 ,100)];
                imageView.tag = flag;
                imageView.image =thumbImg;
                imageView.userInteractionEnabled = YES;
                [MainUIview addSubview:imageView];
                if (imageView.image==nil) {
                    imageView.image=[UIImage imageNamed:@"icon@2x.png"];
                }

                
                if ([Mediatype isEqualToString:@"video"]) {
                    
                    NSURL *vidURL=[NSURL URLWithString:savedImagePath];
                    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:vidURL options:nil];
                    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
                    NSError *err = NULL;
                    CMTime time = CMTimeMake(1, 60);
                    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
                    NSLog(@"err==%@, imageRef==%@", err, imgRef);
                    
                    thumbImg= [[UIImage alloc] initWithCGImage:imgRef];
                    
                    NSURL *moveUrl= [NSURL fileURLWithPath:savedImagePath];
                    
                    NSURL *sourceMovieURL = moveUrl;
                    AVURLAsset *sourceAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
                    
                    AVAssetImageGenerator* generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:sourceAsset];
                    
                    //Get the 1st frame 3 seconds in
                    int frameTimeStart = 3;
                    int frameLocation = 1;
                    
                    //Snatch a frame
                    CGImageRef frameRef = [generator copyCGImageAtTime:CMTimeMake(frameTimeStart,frameLocation) actualTime:nil error:nil];
                    UIImage *thumbImg1=[UIImage imageWithCGImage:frameRef];
                    imageView.image=thumbImg1;

                }
               
                
                NSString *imgname=[DetailsArray objectAtIndex:flag-1];
                UILabel *labelimgname=[[UILabel alloc]initWithFrame: CGRectMake(5.5+(104*j),110+(120 * i),100 ,20)];
                labelimgname.text=imgname;
                labelimgname.textAlignment=NSTextAlignmentCenter;
                labelimgname.font=[UIFont systemFontOfSize:13];
                [MainUIview addSubview:labelimgname];

                    UITapGestureRecognizer *SingleTapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap :)];
                    SingleTapGuesture.numberOfTapsRequired = 1;
                    SingleTapGuesture.delegate = self;
                    [imageView addGestureRecognizer:SingleTapGuesture];
                
                    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(Handlelongpress:)];
                lpgr.numberOfTouchesRequired=1;
                    lpgr.minimumPressDuration = 0.5;
                    [imageView addGestureRecognizer:lpgr];
                
                MainUIview.contentSize=CGSizeMake(320, 180+(120 * i));
                }
            }
        }
}

-(void)singleTap :(UITapGestureRecognizer*)recogniser
{
    int n=[recogniser view].tag;
    NSLog(@"%d",n);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[DetailsArray objectAtIndex:n-1]];
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];

    if ([self.Mediatype isEqualToString:@"video"]) {
        MPMoviePlayerViewController * playerController = [[MPMoviePlayerViewController alloc] initWithContentURL:fileURL];
        
        [mainDelegate.Rootnav presentMoviePlayerViewControllerAnimated:(MPMoviePlayerViewController *)playerController];
        
        playerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [playerController.moviePlayer play];
        playerController=nil;
    }
    else
        if ([self.Mediatype isEqualToString:@"image"]) {
            
            if (detailview) {
                detailview=nil;
            }
            detailview=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320, self.view.frame.size.height-(Adjust_Height))];
            //    detailview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
            detailview.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
            detailview.userInteractionEnabled=YES;
            [self.view addSubview:detailview];
            
            UIImageView *image=[[UIImageView alloc]init];
            image.frame=CGRectMake(10,90, 300, 300);
            [detailview addSubview:image];
            
            NSData *data=[NSData dataWithContentsOfFile:path];
            UIImage *images=[UIImage imageNamed:@"icon@2x.png"];
            if (data.length>0) {
                 images=[UIImage imageWithData:data];

            }
            
            image.image=images;
            UIButton *CloseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            CloseBtn.frame=CGRectMake(285, 5, 25, 25);
            [CloseBtn addTarget:self action:@selector(removedataView) forControlEvents:UIControlEventTouchUpInside];
            CloseBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
            [CloseBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
            [detailview addSubview:CloseBtn];


        }
    else
    if ([self.Mediatype isEqualToString:@"audio"])
    {
        if ([avPlayer isPlaying]) {
            return;
        }
        
        NSError *error=nil;
        avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
        NSLog(@"Play Path:%@%@", fileURL,error);
        [avPlayer prepareToPlay];
        [avPlayer play];
        
        Playview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        Playview.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        [self.view addSubview:Playview];
        Playview.center=self.view.center;
        
        Timelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 20)];
        Timelable.backgroundColor=[UIColor clearColor];
        Timelable.text=@"";
        Timelable.textColor=[UIColor whiteColor];
        Timelable.textAlignment=NSTextAlignmentCenter;
        [Playview addSubview:Timelable];

          Recordtimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
        
        UIButton *stopbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        stopbtn.frame=CGRectMake(10, 50, 80, 40);
        [stopbtn setTitle:@"Stop" forState:UIControlStateNormal];
        [Playview addSubview:stopbtn];
        [stopbtn addTarget:self action:@selector(Stopplaying) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}

-(void)removedataView{
    [detailview removeFromSuperview];
    detailview=nil;
}
- (void)updateSlider {
    // Update the slider about the music time
    if(![avPlayer isPlaying])
    {
        [Playview removeFromSuperview];
        [Recordtimer invalidate];
        Recordtimer=nil;
    }
    else
    {
        float minutes = floor(avPlayer.currentTime/60);
        float seconds = avPlayer.currentTime - (minutes * 60);
        
        NSString *time = [[NSString alloc]
                          initWithFormat:@"%0.0f.%0.0f",
                          minutes, seconds];
        Timelable.text = time;
         }
}

-(void)Stopplaying
{
    [avPlayer stop];
    avPlayer=nil;
    [Playview removeFromSuperview];
    
}

//manage selected view operations
-(void)Handlelongpress :(UITapGestureRecognizer*)recogniser
{
    int n=[recogniser view].tag;
    NSLog(@"%d",n);
    Selectedarrayid=n;
    SelectedID=[DetailIdArray objectAtIndex:n-1];
//      if ([Sheet isVisible])
//          return;
    if (recogniser.state == UIGestureRecognizerStateBegan) {

    Sheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Rename File",@"Delete File", nil];
    Sheet.tag=3;
  
//        [Sheet showFromTabBar:mainDelegate.objTabBarController.tabBar];
        [Sheet showInView:mainDelegate.Rootnav.view];


    }

    }

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *SelectedOption=@"";
     NSString *Query=@"";
    if (actionSheet.tag==3)
    {
        if (buttonIndex==0)
        {
            
            [self ShowRenameview];
            SelectedOption=@"Rename";
            [self ShowMedia];

        }
        else
            if (buttonIndex==1)
            {
                SelectedOption=@"Delete";
                Query=[NSString stringWithFormat:@"DELETE FROM MediaTable WHERE id='%@' ",SelectedID];
               BOOL Result= [Objshareddb ExexuteOperation:Query];

                if (Result) {
                    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Sucessfully Deleted." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    alert1.tag=1;
                    [alert1 show];
                    
                                       
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                    NSString *documentsDirectory = [paths objectAtIndex:0];
                    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[DetailsArray objectAtIndex:Selectedarrayid-1]];

                    NSError *error=nil;
                    [[NSFileManager defaultManager] removeItemAtPath:savedImagePath error:&error];

                    [self refreshview];

                }
                else
                {
                    
                }
            }
    }
    
}

-(void)refreshview
{
    for (__strong UIView *view in [MainUIview subviews]) {
        //                        if ([view isKindOfClass:[UIImageView class]]) {
        [view removeFromSuperview];
        view=nil;
        //                        }
    }
    [self ShowMedia];

}

-(void)ShowRenameview
{
    RenameView=[[UIView alloc]initWithFrame:CGRectMake(0, Adjust_Height, 320, 300)];
    RenameView.center=self.view.center;
    RenameView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:RenameView];
    
    UITextField *Texname=[[UITextField alloc]initWithFrame:CGRectMake(60, 50, 200, 35)];
    Texname.background=[UIImage imageNamed:@"Textf1.png"];
    UILabel * leftViews = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftViews.backgroundColor = [UIColor clearColor];
    Texname.leftView = leftViews;
    Texname.leftViewMode = UITextFieldViewModeAlways;
    Texname.delegate=self;
    Texname.textAlignment=NSTextAlignmentCenter;
    Texname.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Texname.backgroundColor=[UIColor clearColor];
    [RenameView addSubview:Texname];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30,150,260,38);
    [button setBackgroundImage:[UIImage imageNamed:@"save1.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Save) forControlEvents:UIControlEventTouchUpInside];
    [RenameView addSubview:button];
    
    UIButton *CloseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.frame=CGRectMake(265, 5, 25, 25);
    [CloseBtn addTarget:self action:@selector(removeRenameView) forControlEvents:UIControlEventTouchUpInside];
    CloseBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [CloseBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [RenameView addSubview:CloseBtn];

    
    
}

-(void)removeRenameView
{
    [RenameView removeFromSuperview];
    RenameView=nil;
}

-(void)Save
{
     NSString *mediaxtension=@"";
    if ([self.Mediatype isEqualToString:@"image"]) {
        mediaxtension=@"png";
    }
    else
        if ([self.Mediatype isEqualToString:@"audio"]) {
            mediaxtension=@"caf";
        }
    else
        if ([self.Mediatype isEqualToString:@"video"]) {
            mediaxtension=@"mp4";
        }
    
    NSString *name=@"";
    for (UITextField *textf in RenameView.subviews) {
        if ([textf isKindOfClass:[UITextField class]]) {
            name=textf.text;

        }
    }
    NSString *Query=[NSString stringWithFormat:@"Update  MediaTable SET medianame='%@',dateModified='%@' WHERE id='%@'",name,[mainDelegate Getcurrentdate],SelectedID];
   BOOL Result= [Objshareddb ExexuteOperation:Query];
    if (Result) {
        NSLog(@"success");
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Sucessfully Updated." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        alert1.tag=1;
        [alert1 show];
        [self removeRenameView];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[DetailsArray objectAtIndex:Selectedarrayid-1]];
        //                UIImage *img1  =[[UIImage alloc]init];
        NSData *data= [NSData dataWithContentsOfFile:savedImagePath];
        NSError *error=nil;
        [[NSFileManager defaultManager] removeItemAtPath:savedImagePath error:&error];
        
        NSString *newpath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,mediaxtension]];
        [data writeToFile:newpath atomically:NO];
        [self refreshview];
    }
    else
    {
        
    }
    
}
#pragma mark:textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark:Db methods
-(NSMutableArray*)GetDetailarray
{
//    NSString *Selectedtable=@"";
    NSMutableArray *temparr=[[NSMutableArray alloc]init];
    
    if(DetailsArray !=nil)
        DetailsArray=nil;
    DetailsArray=[[NSMutableArray alloc]init];
    
    if(DetailIdArray !=nil)
        DetailIdArray=nil;
    DetailIdArray=[[NSMutableArray alloc]init];

    
    sqlite3_stmt    *statement;
	
	[Objshareddb openDB];
    sqlite3 *sDB=Objshareddb.sDB;
    
	if (sqlite3_open(Objshareddb.dbpath, &sDB) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat:@"select id,medianame from MediaTable where mediatype='%@' AND formid='%@' AND level1id='%@' AND level2id='%@' AND level3id='%@' AND sectionid=%d",self.Mediatype,mainDelegate.formid,[mainDelegate.Selectedidarray objectAtIndex:0],[mainDelegate.Selectedidarray objectAtIndex:1],[mainDelegate.Selectedidarray objectAtIndex:2],[self.Selectedtable integerValue]];
		
		const char *query_stmt = [querySQL UTF8String];
        
		if (sqlite3_prepare_v2(sDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *DetailLabelStr = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                if ([self.Mediatype isEqualToString:@"video"]) {
                    DetailLabelStr=[DetailLabelStr stringByAppendingString:@".mp4"];

                }
                else
                    if ([self.Mediatype isEqualToString:@"audio"]) {
                        DetailLabelStr=[DetailLabelStr stringByAppendingString:@".caf"];

                    }
                else
                DetailLabelStr=[DetailLabelStr stringByAppendingString:@".png"];
//                NSString *IndexID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [DetailsArray addObject:DetailLabelStr];
                
                NSString *DetailIDStr = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [DetailIdArray addObject:DetailIDStr ];
                
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(sDB);
	}

    
    return temparr;
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (avPlayer) {
        if ([avPlayer isPlaying]) {
            [avPlayer stop];

        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
