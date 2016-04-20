//
//  newTableViewController.m
//  textChat_uiImplementation
//
//  Created by Kiran on 29/03/16.
//  Copyright © 2016 Kiran. All rights reserved.
//

#import "newTableViewController.h"
//#import "AppointmentsDocsViewController.h"
#import "markasFinishedViewController.h"

@interface newTableViewController ()<UITextFieldDelegate>
{
    NSMutableArray *arr;
    NSMutableArray *check;

    UITableViewCell *cell;
    int i;
    OTSession* sessionN;
    NSString* _apiKey;
    NSString* apikey;
    NSString* _sessionId;
    NSString* sessionId;
    NSString* _token;
    NSString* token;
    OTPublisher* publisher;
    OTSubscriber *subscriberr;
    NSString *typee;
    NSString *x;
    NSString *y;
    int j;
    NSDictionary *dict;
    NSString *status;
    NSTimer *timer;
    int currMinute;
    int currSeconds;

    

}

@end

@implementation newTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageComposerView = [[MessageComposerView alloc] init];
    self.messageComposerView.delegate = self;
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setTitle:@"Send" forState:UIControlStateNormal];
    [send setTintColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]];
   // [self.messageComposerView setSendButton:send];
    [self.view addSubview:self.messageComposerView];
    _textf.delegate=self;
    _app_dur.hidden = YES;
    token = [[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN];

    currMinute = 0;
    currSeconds = 00;
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pat_image.layer.borderWidth = 1;
    _pat_image.layer.borderColor = [UIColor whiteColor].CGColor;
    arr = [[NSMutableArray alloc]init];
    check = [[NSMutableArray alloc]init];

    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    [[NSUserDefaults standardUserDefaults]setValue:@"text" forKey:@"tex"];
    [self apiCall];
    status = @"1";
  //  [self activeApi];
    typee=@"150";

    
}
- (void)getSessionCredentials
{
    
    
    
    //  [self apiCall];
    
    
    
    
    
    
    
    NSLog(@"%lu",(unsigned long)[arr count]);
    
    
    
    
    NSLog(@"%@%@%@",_token,_sessionId,x);
    
    
    _apiKey = @"45535562";
    //    _token = @"T1==cGFydG5lcl9pZD00NTQ0NjA4MiZzaWc9ZTg4NjZiN2RmNTBkMDJkNTExMTk0ZDUxMzkwZTgyODQ3NjVkZTViNjpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTFfTVg0ME5UUTBOakE0TW41LU1UUTFNRGt6TVRVM01EVXdOSDV5Wmt0b1JrUkdUbGx4VTJsblVqVlJNa3ByWnpkNk1pdC1VSDQmY3JlYXRlX3RpbWU9MTQ1MDkzMTY1MiZub25jZT0wLjgwMDkyNzgzMDAzNTc5ODcmZXhwaXJlX3RpbWU9MTQ1MzUyMzUzOSZjb25uZWN0aW9uX2RhdGE9Y29jb2FsYWJz";
    //    _sessionId = @"1_MX40NTQ0NjA4Mn5-MTQ1MDkzMTU3MDUwNH5yZktoRkRGTllxU2lnUjVRMkprZzd6Mit-UH4";
    //
    //    sessionId = @"2_MX40NTQ0NjA4Mn5-MTQ1MDg1MTE1MDE4NH5iYklOMmMybGQydlJhU1A0VHZFclh0QjZ-UH4";
    //    apikey = @"45446082";
    //    token= @"T1==cGFydG5lcl9pZD00NTQ0NjA4MiZzaWc9MmNkZDYzYzM3NjRiODE5MGU5OGU5ZTliNzA4M2YxYmVmYTY4ZWFmYTpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTFfTVg0ME5UUTBOakE0TW41LU1UUTFNRGt6TVRVM01EVXdOSDV5Wmt0b1JrUkdUbGx4VTJsblVqVlJNa3ByWnpkNk1pdC1VSDQmY3JlYXRlX3RpbWU9MTQ1MTI5MzM3NSZub25jZT0wLjA0NTk1OTQwMTQ5MTk3NTg2JmV4cGlyZV90aW1lPTE0NTM4ODUyMjQmY29ubmVjdGlvbl9kYXRhPWlsdWo=";
    
    if(!_apiKey || !_token || !_sessionId) {
        NSLog(@"Error blabla");
    } else {
        [self doConnect];
    }
    
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
-(void)apiCall{
    NSString *yurl = @"http://freemaart.com/dev/my_maa/api/start_appointment";
//    NSString *yurl = @"http://freemaart.com/dev/my_maa/api/start_appointment";

    
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary setValue:_appID forKey:@"appointment_id"];
    
    
    [searchMutableDictionary setValue:token forKey:@"token"];
    
    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:yurl] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
//           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        dict = [responseObject valueForKey:@"data"];
        _sessionId = dict[@"session_id"];
        _token = dict[@"test_token"];
        x = dict[@"token"];
        _pat_name.text = dict[@"pt_name"];
        
        NSLog(@"Response object:%@",responseObject);
        [self getSessionCredentials];
        
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
    NSLog(@"Unable to disconnect to the session (%@)",
          e.localizedDescription);
    
}






# pragma mark - OTSession delegate callbacks

- (void)sessionDidConnect:(OTSession*)session
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];


    NSLog(@"Connected to the session.");
    
    publisher = [[OTPublisher alloc]initWithDelegate:self name:@"Kiran"];
    
    
    
    
    
    
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




-(void)session:(OTSession *)session receivedSignalType:(NSString *)typeee fromConnection:(OTConnection *)connection withString:(NSString *)string
{
    NSLog(@"fffffffff%@",string);
    if ([typeee isEqual:typee]) {
        [check addObject:@"a"];
        NSData *nsdataFromBase64String = [[NSData alloc]
                                          initWithBase64EncodedString:string options:0];
        NSLog(@"%@decodedddddd",nsdataFromBase64String);
//
//        // Decoded NSString from the NSData
//        NSString *base64Decoded = [[NSString alloc]
//                                   initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
//        [arr addObject:string];

        [_tablee reloadData];
        if (arr.count>0) {
            [_tablee scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:arr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }


    }
    else
    {
        NSData *nsdataFromBase64String = [[NSData alloc]
                                          initWithBase64EncodedString:string options:0];
        
        // Decoded NSString from the NSData
        NSString *base64Decoded = [[NSString alloc]
                                   initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
        NSLog(@"decode string isssssss%@",base64Decoded);
        [check addObject:@"b"];
        
        _docView.hidden = YES;
        i = 20;
        
        [arr addObject:string];
        [_tablee reloadData];
        if (arr.count>0) {
            [_tablee scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:arr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }


    }
//    .text = [NSString stringWithFormat:@"%@",string];
}




- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    NSLog(@"helooooooo");
    
    
    
}










-(void)tap{
    [self.view endEditing:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDent = @"cellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIDent];
    if (cell==nil) {
        [[NSBundle mainBundle]loadNibNamed:@"chat" owner:self options:nil];
        cell=_celll;
    }
    cell.backgroundColor=[UIColor clearColor];
//    cell.backgroundView=[UIView new];
//    cell.selectedBackgroundView=[UIView new];
    _docView = (UIView*)[cell viewWithTag:20];
    if ([check[indexPath.row] isEqual:@"a"]) {
        _docView.hidden = NO;
        _pat_image.hidden=YES;
       // _pat_name.hidden = YES;
        _pat_label.hidden=YES;
        _pat_date.hidden=YES;
        _pat_ballon.hidden=YES;
    }
    else
    {
        _docView.hidden = YES;

    }
    _docLAbel = (UILabel*)[cell viewWithTag:10];
    _docLAbel.text =arr[indexPath.row];
    _pat_label = (UILabel*)[cell viewWithTag:50];
    _pat_label.text =arr[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static dispatch_once_t onceToken;
//
//    dispatch_once(&onceToken, ^{
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
//
//        [[NSBundle mainBundle]loadNibNamed:@"chat" owner:self options:nil];
//
//        cell = _celll;
//    });
//
//    //[_tablee reloadData];
//    return [self calculateHeightForConfiguredSizingCell:cell];
//}
//
//- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell
//{
//    [sizingCell layoutIfNeeded];
//
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)send:(id)sender {
//    [_tablee setContentOffset:CGPointMake(0, CGFLOAT_MAX)];

    _docView.hidden = NO;
    i = 10;
    [arr addObject:_textf.text];
    OTError* error = nil;
    
    
    NSData *nsdata = [_textf.text
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];

    
    NSLog(@"encodedddd%@",base64Encoded);
    
    
    
    [sessionN signalWithType:typee string:[NSString stringWithFormat:@"%@",_textf.text] connection:nil error:&error];
    // [session signalWithType:type string:@"hello" connection:stream.connection error:&error];
    _textf.text = @"";
    if (error) {
        NSLog(@"signal error %@", error);
    } else {
        NSLog(@"signal sent");
    }

}
- (IBAction)patientSend:(id)sender {
   }
- (IBAction)finishChat:(id)sender {
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"Alert!!" message:@"Are you sure" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        status = @"2";
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
        else{
            errorMessage = @"Connection to server failed!";
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:@"MAA" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
    }];
    
}
-(void)timerFired
{
    _app_dur.hidden = NO;
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
    [_app_dur setText:[NSString stringWithFormat:@"%d%@%02d",currMinute,@":",currSeconds]];
    
    //    }
    //    else
    //    {
    //        [timer invalidate];
    //    }
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


-(void)textFieldDidBeginEditing:(UITextField *)sender
{
        //move the main view, so that the keyboard does not hide it.
  
}

- (void)messageComposerSendMessageClickedWithMessage:(NSString*)message
{
    
    
    _docView.hidden = NO;
    i = 10;
    [arr addObject:message];
    
    OTError* error = nil;
    
    
    NSData *nsdata = [_textf.text
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    
    NSLog(@"encodedddd%@",base64Encoded);
    
    
    
    [sessionN signalWithType:typee string:[NSString stringWithFormat:@"%@",message] connection:nil error:&error];
    // [session signalWithType:type string:@"hello" connection:stream.connection error:&error];
    _textf.text = @"";
    if (error) {
        NSLog(@"signal error %@", error);
    } else {
        NSLog(@"signal sent");
    }

}
-(void)messageComposerUserTyping
{
   


}
- (void)viewDidAppear:(BOOL)animated{
    self.oldFrame = self.view.frame;
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
