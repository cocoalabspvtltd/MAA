//
//  ViewController.h
//  Getting Started
//
//  Created by Jeff Swartz on 11/19/14.
//  Copyright (c) 2014 TokBox, Inc. All rights reserved.

#import "ViewController.h"
#import <OpenTok/OpenTok.h>
//#import "AppointmentsDocsViewController.h"


@interface ViewController ()
@property (nonatomic, strong) UIView *bar;
@property (nonatomic, strong) UIView *topbar;


@end

@implementation ViewController {
    OTSession* sessionN;
    NSString* _apiKey;
    NSString* apikey;
    NSString* _sessionId;
    NSString* sessionId;
    NSString* _token;
    NSString* token;
    OTPublisher* publisher;
    OTSubscriber *subscriberr;
    NSDictionary *dict;
    NSString *x;
    NSString *y;
    NSMutableArray *arr;
    UIButton *button ;
    UIButton *button1 ;
    UIButton *button2 ;
    UILabel *upLabel;
    UILabel *progress;

    int i;
    int j;
    int p;
    NSTimer *timer;
    int currMinute;
    int currSeconds;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialisation];
    token = [[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN];
    progress.textColor=[UIColor whiteColor];
    progress.backgroundColor=[UIColor clearColor];
    progress=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, 100, 50)];


    currSeconds=00;
    currMinute=0;
    i = 0;
    j = 0;
    p = 0;
    arr = [[NSMutableArray alloc]init];
    self.bar = [[UIView alloc]init];
    self.bar.backgroundColor = [UIColor redColor];
    self.topbar = [[UIView alloc]init];
    self.topbar.backgroundColor = [UIColor lightGrayColor];
    _docImage.clipsToBounds = YES;
    [self setRoundedView:_docImage toDiameter:50.0];
    [self apiCall];
}

-(void)initialisation{
    self.doctorNameLabel.text = self.doctorNamneString;
    [self.docImage sd_setImageWithURL:[NSURL URLWithString:self.doctorProfUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
}

-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

-(void)apiCall{
    NSString *startAppointmenturlsTring = [Baseurl stringByAppendingString:StartAppointmentUrl];
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary setValue:_appID forKey:@"appointment_id"];
    [searchMutableDictionary setValue:token forKey:@"token"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:startAppointmenturlsTring] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        dict = [responseObject valueForKey:@"data"];
        _sessionId = dict[@"session_id"];
        _token = dict[@"token"];
        x = dict[@"token"];
        [arr addObject:_token];
        [arr addObject:_sessionId];
        [self getSessionCredentials];

    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        if([errorDescription isEqualToString:@"No internet Access"]){
            errorMessage = @"No internet Access";
        }
        else if ([errorResponse[@"error_code"] isEqual:@"invalid_token"])
        {
            UIAlertController *contr = [UIAlertController alertControllerWithTitle:@"Alert!!!" message:@"You have been logged out" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Act = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
                UINavigationController *navigationController = [sb instantiateViewControllerWithIdentifier:@"LogInNavigationController"];
                
                [self presentViewController:navigationController animated:YES completion:nil];
                
            }];
            [contr addAction:Act];
            [self presentViewController:contr animated:YES completion:nil];
            
            
        }

        else{
            errorMessage = @"Connection to server failed!";
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:@"MAA" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
    }];
    
    
    
    
    
    

}
- (void)getSessionCredentials
{
    NSLog(@"%lu",(unsigned long)[arr count]);
   _apiKey = @"45567942";
    if(!_apiKey || !_token || !_sessionId) {
        NSLog(@"Error blabla");
    } else {
        [self doConnect];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice]
                                      userInterfaceIdiom])
    {
        return NO;
    } else {
        return YES;
    }
}
#pragma mark - OpenTok methods

- (void)doConnect
{
    // Initialize a new instance of OTSession and begin the connection process.
    
   sessionN = [[OTSession alloc] initWithApiKey:_apiKey
                                       sessionId:_sessionId
                                        delegate:self];
    OTError *error = nil;
    [sessionN connectWithToken:_token error:&error];
    if (error)
    {
        NSLog(@"Unable to connect to the session (%@)",
              error.localizedDescription);
    }
}
-(void)viewWillLayoutSubviews
{
    //    self.secondV.frame = CGRectMake(50, 50, 100, 100);
    //    self.secondV.backgroundColor = [UIColor redColor];
    CGFloat myVideoViewWidth = 150,myVideoViewHeight = 150;
    CGFloat mybarHieght = 40;
    self.bar.frame = CGRectMake(0, self.view.frame.size.height-mybarHieght, self.view.frame.size.width, mybarHieght);
     button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(video)
     forControlEvents:UIControlEventTouchUpInside];
    //[button setTitle:@"WRITE REVIEW" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
  //  button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(10, 5, 30, 30);
  //  [button setBackgroundImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];
    upLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    
    [upLabel setTextColor:[UIColor blackColor]];
    [upLabel setBackgroundColor:[UIColor clearColor]];
    [upLabel setFont:[UIFont fontWithName: @"00:00" size: 14.0f]];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self
               action:@selector(end)
     forControlEvents:UIControlEventTouchUpInside];
    //[button setTitle:@"WRITE REVIEW" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:17];
 //   button.backgroundColor = [UIColor whiteColor];
    button2.frame = CGRectMake((self.bar.frame.size.width)-40, 5, 30, 30);
  //  [button2 setBackgroundImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self
               action:@selector(audio)
     forControlEvents:UIControlEventTouchUpInside];
    //[button setTitle:@"WRITE REVIEW" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:17];
 //   button.backgroundColor = [UIColor whiteColor];
    button1.frame = CGRectMake((self.bar.frame.size.width)/2, 5, 30, 30);
    [button1 setBackgroundImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];

    self.topbar.frame = CGRectMake(0, 0, self.view.frame.size.width, mybarHieght);

    subscriberr.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    publisher.view.frame = CGRectMake(self.view.frame.size.width - myVideoViewWidth - 10, self.view.frame.size.height - myVideoViewHeight - 50, myVideoViewWidth, myVideoViewHeight);
    
   // progress.textColor=[UIColor whiteColor];
//    progress=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, 100, 50)];

    
    //self.secondV.frame = CGRectMake(150, 150, 100, 40);
}
-(void)video{
    
  if (p==0) {
        p = 1;
        subscriberr.subscribeToAudio = YES;
        subscriberr.subscribeToVideo = NO;
        
    }
    else
    {
        p = 0;
        subscriberr.subscribeToAudio = YES;
        subscriberr.subscribeToVideo = YES;
        
    }

    
}
-(void)audio{  if (i==0) {
    i = 1;
    publisher.publishAudio = NO;
    
}
else
{
    i = 0;
    publisher.publishAudio = YES;
    
}
    
}
-(void)end{
    [self disconnect];

}
/*-(void)dooConnect
{
    
    session = [[OTSession alloc] initWithApiKey:_apiKey
                                       sessionId:_sessionId
                                        delegate:self];
    OTError *errori = nil;
    [session connectWithToken:_token error:&errori];
    if (errori)
    {
        NSLog(@"Unable to connect to the session (%@)",
              errori.localizedDescription);
    }

    
    
    
}*/

-(void)disconnect{
    OTError *e;
    
    [sessionN disconnect:&e];
    if (e) {
        NSLog(@"Unable to disconnect to the session (%@)",
              e.localizedDescription);

    }
  
}

- (IBAction)diconnect:(id)sender {
        [self disconnect];

   

}

- (IBAction)MUTE:(id)sender {
    if (i==0) {
        i = 1;
        publisher.publishAudio = NO;

    }
    else
    {
        i = 0;
        publisher.publishAudio = YES;

    }
    

}






# pragma mark - OTSession delegate callbacks

- (void)sessionDidConnect:(OTSession*)session
{
   // [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"Connected to the session.");
 //   _streams =[NSDictionary dictionaryWithObject:@"fvev" forKey:@"veqve"];
    // [self publish:(OTPublisher*)_streams];
    //  OTSubscriber* subscriber = [OTSubscriber alloc];
    //[subscriber initWithStream:(OTStream *)_streams delegate:self];
   publisher = [[OTPublisher alloc]initWithDelegate:self name:@"Kiran"];
   // subscriber = [[OTSubscriber alloc]initWithStream:<#(OTStream *)#> delegate:<#(id<OTSubscriberKitDelegate>)#>];
    // [_session publish:publisher];
  //  [publisher.view initWithFrame:_secondView.frame];
    // [publisher.view setFrame:CGRectMake(207, 442, 113, 126)];
   // [self.view addSubview:publisher.view];
  
    //  [self.view addSubview:publisher.view];

    
   [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if(granted){
            // Access to the camera is granted. You can publish.
            
            
            OTError* error = nil;
           [sessionN publish:publisher error:&error];
            if (error) {
                NSLog(@"publishing failed with error: (%@)", error);
            }
        } else {
            NSLog(@"CAMERA CANNOT BE ACCESSED");
            // Access to the camera is not granted.
        }
    }];
    
    //to unpublish
   /* OTError* error = nil;
    [_session unpublish:publisher error:&error];
    if (error) {
        NSLog(@"publishing failed with error: (%@)", error);
    }*/

    
    
}

- (void)sessionDidDisconnect:(OTSession*)session
{
    NSString* alertMessage =
    [NSString stringWithFormat:@"Session disconnected: (%@)",
     sessionN.sessionId];
    NSLog(@"sessionDidDisconnect (%@)", alertMessage);
}



- (void)session:(OTSession*)session
streamDestroyed:(OTStream *)stream
{
    NSLog(@"session streamDestroyed (%@)", stream.streamId);
}

- (void)  session:(OTSession *)session
connectionCreated:(OTConnection *)connection
{
    NSLog(@"session connectionCreated (%@)", connection.connectionId);
}

- (void)    session:(OTSession *)session
connectionDestroyed:(OTConnection *)connection
{
    NSLog(@"session connectionDestroyed (%@)", connection.connectionId);
}

- (void) session:(OTSession*)session
didFailWithError:(OTError*)error
{
    NSLog(@"session didFailWithError: (%@)", error);
}


-(void)subscriberVideoDataReceived:(OTSubscriber *)subscriber
{
    NSLog(@"subscriber video data received");
    
}
-(void)subscriber:(OTSubscriberKit *)subscriber didFailWithError:(OTError *)error
{
    NSLog(@"subscriber did fail with error");
    
}
-(void)publisher:(OTPublisherKit *)publisher didFailWithError:(OTError *)error
{
    NSLog(@"publisher with fail with error");
    
}


/*!-(void)publisher:(OTPublisherKit *)publisher streamCreated:(OTStream *)stream
{
    NSLog(@" VIDEO CAN BE PUBLISH NOWw");
     subscriber = [[OTSubscriber alloc]initWithStream:stream delegate:self];
    

    OTError* errorr = nil;
    [session subscribe:subscriber error:&errorr];
    if (errorr) {
        NSLog(@"subscribe failed with error: (%@)", errorr);
    }
    
    
    
    if ([stream.connection.connectionId isEqualToString: session.connection.connectionId]) {
        // This is my own stream
        NSLog(@"This is my own stream");
    } else {
        // This is a stream from another client.
        NSLog(@"This is a stream from another client");
        
    }

    //  publisher.publishVideo=YES;
    // [publisher publishVideo];
}*/

- (void)session:(OTSession*)session streamCreated:(OTStream*)stream
{
 
    
    // See the declaration of subscribeToSelf above.
    
   subscriberr = [[OTSubscriber alloc] initWithStream:stream delegate:self];
    OTError* errorr = nil;
    [sessionN subscribe:subscriberr error:&errorr];
    if (errorr) {
        NSLog(@"subscribe failed with error: (%@)", errorr.description);
    }
    
    
    
    if ([stream.connection.connectionId isEqualToString: sessionN.connection.connectionId]) {
        // This is my own stream
        NSLog(@"This is my own stream");
    } else {
        // This is a stream from another client.
        NSLog(@"This is a stream from another client");
        
    }
}



-(void)subscriberDidDisconnectFromStream:(OTSubscriberKit *)subscriber
{
//    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"Alert!!" message:@"Call disconnected" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *act = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        AppointmentsDocsViewController *resetOTPPage = (AppointmentsDocsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"appoint"];
//        [self.navigationController pushViewController:resetOTPPage animated:YES];    }];
//    UIAlertAction *Act2 = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
//    [ctr addAction:act];
//    [ctr addAction:Act2];
//    [self presentViewController:ctr animated:YES completion:nil];

}


- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    
    NSLog(@"helooooooo");
  //  [subscriberr.view setFrame:CGRectMake(0, 0, 320, 300)];

    [self.view addSubview:subscriberr.view];
    [self.view addSubview:self.bar];
    [self.bar addSubview:button];
    [self.bar addSubview:button1];
    [self.bar addSubview:button2];
    self.topbar.alpha=0.5;
    [self.view addSubview:self.topbar];
   [self.topbar addSubview:progress];
  //  [self.view addSubview:progress];

    [self.view addSubview:publisher.view];
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];

}













    
    



- (IBAction)connect:(id)sender {
    
    OTError *error = nil;
    [sessionN connectWithToken:_token error:&error];
    if (error)
    {
        NSLog(@"Unable to connect to the session (%@)",
              error.localizedDescription);
    }
    
    
    
    
}
- (IBAction)unpublish:(id)sender {
    
    [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    
    
    
    
}
-(void)timerFired
{
    //    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    //    {
    currSeconds = currSeconds+1;
    if(currSeconds==59)
    {
        currMinute=currMinute+1;
        currSeconds=00;
    }
    //        else if(currSeconds>0)
    //        {
    //            currSeconds-=1;
    //        }
    //        if(currMinute>-1)
//        [progress setText:@"0:00"];

    [progress setText:[NSString stringWithFormat:@"%d%@%02d",currMinute,@":",currSeconds]];
    
    //    }
    //    else
    //    {
    //        [timer invalidate];
    //    }
}



- (IBAction)UNMUTE:(id)sender {
    publisher.publishAudio = YES;

}
@end