//
//  thirdViewController.m
//  LearningOpenTok
//
//  Created by Kiran on 29/12/15.
//  Copyright © 2015 tokboxkiran. All rights reserved.
//

#import "thirdViewController.h"
#import "markasFinishedViewController.h"
//#import "AppointmentsDocsViewController.h"

@interface thirdViewController ()

@end

@implementation thirdViewController
{
    OTSession* sessionN;
    NSString* _apiKey;
    NSString* apikey;
    NSString* _sessionId;
    NSString* sessionId;
    NSString* _token;
    NSString* token;
    OTPublisher* publisherR;
    OTSubscriber *subscriberr;
    NSString *x;
    NSString *y;
    NSMutableArray *arr;
    int i;
    int j;
    NSDictionary *dict;
    NSTimer *timer;
    int currMinute;
    int currSeconds;
    NSString *status;


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    token = [[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN];

    _connecting.hidden=NO;
    currMinute=0;
    currSeconds=00;
    _end.hidden = NO;
    _end1.hidden = NO;
    _up.hidden = NO;
    [self getSessionCredentials];
    _pat_image.clipsToBounds = YES;
    _pat_image.layer.cornerRadius = _docImage.frame.size.width/2;
    [self apiCall];
    
}
-(void)apiCall{
    NSString *yurl = @"http://freemaart.com/dev/my_maa/api/start_appointment";
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary setValue:_appID forKey:@"appointment_id"];
    
    
    [searchMutableDictionary setValue:token forKey:@"token"];
    
    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:yurl] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        //   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        dict = [responseObject valueForKey:@"data"];
        _sessionId = dict[@"session_id"];
        _token = dict[@"token"];
        x = dict[@"token"];
        [arr addObject:_token];
        [arr addObject:_sessionId];
        NSLog(@"%@",x);
        //        for (NSDictionary *item in thirdArray) {
        //            student *objy= [[student alloc]init];
        //
        //            objy.pp3 = item[@"name"];
        //            objy.pp4 = item[@"id"];
        //            //   NSLog(@"%@%@",objy.pp1,objy.pp2);
        //            //  [myo addObject:item[@"name"]];
        //            [disco addObject:objy];
        
        
        NSLog(@"Response object:%@",responseObject);
        [self getSessionCredentials];
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // [self.bottomProgressIndicatorView stopAnimating];
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
    
    
    
    //  [self apiCall];
    
    
    
    
    
    
    
    NSLog(@"%lu",(unsigned long)[arr count]);
    
    
    
    
    NSLog(@"%@%@%@",_token,_sessionId,x);
    
    
    _apiKey = @"45535562";
    if(!_apiKey || !_token || !_sessionId) {
        NSLog(@"Error blabla");
    } else {
        timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        
        [self doConnect];
    }

    
    //    _token = @"T1==cGFydG5lcl9pZD00NTQ0NjA4MiZzaWc9ZTg4NjZiN2RmNTBkMDJkNTExMTk0ZDUxMzkwZTgyODQ3NjVkZTViNjpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTFfTVg0ME5UUTBOakE0TW41LU1UUTFNRGt6TVRVM01EVXdOSDV5Wmt0b1JrUkdUbGx4VTJsblVqVlJNa3ByWnpkNk1pdC1VSDQmY3JlYXRlX3RpbWU9MTQ1MDkzMTY1MiZub25jZT0wLjgwMDkyNzgzMDAzNTc5ODcmZXhwaXJlX3RpbWU9MTQ1MzUyMzUzOSZjb25uZWN0aW9uX2RhdGE9Y29jb2FsYWJz";
    //    _sessionId = @"1_MX40NTQ0NjA4Mn5-MTQ1MDkzMTU3MDUwNH5yZktoRkRGTllxU2lnUjVRMkprZzd6Mit-UH4";
    //
    //    sessionId = @"2_MX40NTQ0NjA4Mn5-MTQ1MDg1MTE1MDE4NH5iYklOMmMybGQydlJhU1A0VHZFclh0QjZ-UH4";
    //    apikey = @"45446082";
    //    token= @"T1==cGFydG5lcl9pZD00NTQ0NjA4MiZzaWc9MmNkZDYzYzM3NjRiODE5MGU5OGU5ZTliNzA4M2YxYmVmYTY4ZWFmYTpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTFfTVg0ME5UUTBOakE0TW41LU1UUTFNRGt6TVRVM01EVXdOSDV5Wmt0b1JrUkdUbGx4VTJsblVqVlJNa3ByWnpkNk1pdC1VSDQmY3JlYXRlX3RpbWU9MTQ1MTI5MzM3NSZub25jZT0wLjA0NTk1OTQwMTQ5MTk3NTg2JmV4cGlyZV90aW1lPTE0NTM4ODUyMjQmY29ubmVjdGlvbl9kYXRhPWlsdWo=";
    
    /* if(!apikey || !token || !sessionId) {
     NSLog(@"Error blabla");
     } else {
     [self dooConnect];
     }*/
    
    
    
    /*
     NSString* urlPath = SAMPLE_SERVER_BASE_URL;
     urlPath = [urlPath stringByAppendingString:@"/session"];
     NSURL *url = [NSURL URLWithString: urlPath];
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
     [request setHTTPMethod: @"GET"];
     
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
     if (error){
     NSLog(@"Error,%@, URL: %@", [error localizedDescription],urlPath);
     }
     else{
     NSDictionary *roomInfo = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
     // _apiKey = [roomInfo objectForKey:@"apiKey"];
     //_token = [roomInfo objectForKey:@"token"];
     //_sessionId = [roomInfo objectForKey:@"sessionId"];
     
     if(!_apiKey || !_token || !_sessionId) {
     NSLog(@"Error invalid response from server, URL: %@",urlPath);
     } else {
     [self doConnect];
     }
     }
     }];*/
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



-(void)disconnect{
    OTError *e;
    
    [sessionN disconnect:&e];
    if (e) {
        NSLog(@"Unable to disconnect to the session (%@)",
              e.localizedDescription);

    }
    
}






# pragma mark - OTSession delegate callbacks

- (void)sessionDidConnect:(OTSession*)session
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _connecting.hidden=YES;
    NSLog(@"Connected to the session.");
    OTPublisher*  publisher = [[OTPublisher alloc]initWithDelegate:self];
   // [publisher.view setFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:publisher.view];
    
    
    
   /* [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
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
    }];*/
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if(granted){
            // Access to the camera is granted. You can publish.
            
            
            OTError* error = nil;
            [sessionN publish:publisher error:&error];
            if (error) {
                NSLog(@"publishing failed with error: (%@)", error);
            }
        } else {
            NSLog(@"MICROFONE CANNOT BE ACCESSED");
            // Access to the camera is not granted.
        }
    }];

    

    
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






- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    NSLog(@"helooooooo");
    
   // [subscriberr.view setFrame:CGRectMake(0, 300, 400, 300)];
   // [self.view addSubview:subscriberr.view];
}


- (IBAction)connnnnnnn:(id)sender {
    
    OTError *error = nil;
    [sessionN connectWithToken:_token error:&error];
    if (error)
    {
        NSLog(@"Unable to connect to the session (%@)",
              error.localizedDescription);
    }

    
    
    
}

- (IBAction)disccccccc:(id)sender {
    [self disconnect];
}

- (IBAction)accept:(id)sender {
    _accept.hidden = YES;
    _reject.hidden = YES;
    _end.hidden = NO;
    _end1.hidden = NO;
    _docImage.hidden = NO;
    _docName.hidden = NO;
    _up.hidden = NO;
    
    if(!_apiKey || !_token || !_sessionId) {
        NSLog(@"Error blabla");
    } else {
        timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];

        [self doConnect];
    }

}

- (IBAction)reject:(id)sender {
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
            [_progress setText:[NSString stringWithFormat:@"%d%@%02d",currMinute,@":",currSeconds]];
        
//    }
//    else
//    {
//        [timer invalidate];
//    }
}
- (IBAction)end:(id)sender {
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"Alert!!" message:@"Are you sure" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        status = @"2";
        [self disconnect];
        [self finishChatAoi];
    }];
    UIAlertAction *Act2 = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [ctr addAction:act];
    [ctr addAction:Act2];
    [self presentViewController:ctr animated:YES completion:nil];
    
    
}
-(void)finishChatAoi{
    NSString *yurl = @"http://freemaart.com/dev/my_maa/api/change_appointment_status";
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary setValue:_appID forKey:@"appointment_id"];
    [searchMutableDictionary setValue:@"2" forKey:@"status"];
    
    [searchMutableDictionary setValue:token forKey:@"token"];
    
    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:yurl] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [[NSUserDefaults standardUserDefaults]setValue:@"cancel" forKey:@"cancel"];
        
        NSLog(@"Response object:%@",responseObject);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        markasFinishedViewController *resetOTPPage = (markasFinishedViewController *)[storyboard instantiateViewControllerWithIdentifier:@"finish"];
        [self.navigationController pushViewController:resetOTPPage animated:YES];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // [self.bottomProgressIndicatorView stopAnimating];
        NSString *errorMessage;
        if([errorDescription isEqualToString:@"No internet Access"]){
            errorMessage = @"No internet Access";
        }
        else{
            errorMessage = @"Connection to server failed!";
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:@"MAA" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
    }];
    
}
-(void)activeApi{
    NSString *yurl = @"http://freemaart.com/dev/my_maa/api/change_appointment_status";
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary setValue:_appID forKey:@"appointment_id"];
    [searchMutableDictionary setValue:@"1" forKey:@"status"];
    
    [searchMutableDictionary setValue:token forKey:@"token"];
    
    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:yurl] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSLog(@"Response object:%@",responseObject);
        
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // [self.bottomProgressIndicatorView stopAnimating];
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

@end
