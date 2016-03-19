//
//  AppoinmentDetailVC.m
//  MAA
//
//  Created by Cocoalabs India on 08/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "PayU_iOS_CoreSDK.h"
#import "PayUSAGetHashes.h"
#import "PayUSAOneTapToken.h"

#import "NotesPopUp.h"
#import "Invoicepopup.h"
#import "AppoinmentDetailVC.h"

#import "PreviousAppoinmentCell.h"

@interface AppoinmentDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) PayUModelPaymentParams *paymentParamForPassing;
@property (nonatomic, strong) PayUSAGetHashes *getHashesFromServer;
@property (strong, nonatomic) PayUModelPaymentParams *paymentParam;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;

@property (nonatomic, strong) NSArray *previousAppointmentsArray;
@property (nonatomic, strong) UIView *topTransparentView;
@property (nonatomic, strong) Invoicepopup *invoicePopupVew;
@property (nonatomic, strong) NotesPopUp *notesPopupView;
@property (nonatomic, strong) id invoiceDetails;
@property (nonatomic, strong) NSString *notesString;

@property (nonatomic, strong) NSString *statusString;
@property (nonatomic, strong) NSString *durationString;
@property (nonatomic, strong) NSString *timeStampString;
@property (nonatomic, strong) NSString *cancelDurationString;
@property (nonatomic, assign) BOOL whetherTimerStop;
@end

@implementation AppoinmentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self addingToptransparentView];
    [self getAppointmentsDetailsApi];
    
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.whetherTimerStop = NO;
}

-(void)viewWillLayoutSubviews{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addingToptransparentView{
    self.topTransparentView = [[UIView alloc] init];
    self.topTransparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.topTransparentView.backgroundColor = [UIColor blackColor];
    self.topTransparentView.layer.opacity = 0.5;
    self.topTransparentView.hidden = YES;
    [self.view addSubview:self.topTransparentView];
    [self addingTapGestureToToptransparentView];
}

-(void)addingTapGestureToToptransparentView{
    UITapGestureRecognizer *transparentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTransparentViewTapGestureAction:)];
    self.topTransparentView.userInteractionEnabled = YES;
    transparentTapGesture.numberOfTapsRequired = 1;
    [self.topTransparentView addGestureRecognizer:transparentTapGesture];
}

-(void)topTransparentViewTapGestureAction:(UITapGestureRecognizer *)tapGesture{
    [self.invoicePopupVew removeFromSuperview];
    [self.notesPopupView removeFromSuperview];
    self.topTransparentView.hidden = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View Datatsources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.previousAppointmentsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PreviousAppoinmentCell *cell = [self.previousAppointmentTableview dequeueReusableCellWithIdentifier:@"previousappointmentCell"forIndexPath:indexPath];
    cell.timeStampString = [[self.previousAppointmentsArray objectAtIndex:indexPath.row] valueForKey:@"timestamp"];
    cell.locationString = [[self.previousAppointmentsArray objectAtIndex:indexPath.row] valueForKey:@"location"];
    return cell;
}

- (IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Calling Appointment Detail Api

-(void)getAppointmentsDetailsApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSLog(@"Access Token:%@",accessToken);
    NSString *getPatientsAppointmentsDetailUrlString = [Baseurl stringByAppendingString:GetuserAppointmentDetailsurl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:self.appointmentIdString forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getPatientsAppointmentsDetailUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        [self settingDoctorDetailsWithDictionary:[[responseObject valueForKey:Datakey] valueForKey:@"doctor_details"]];
        if(!([[[responseObject valueForKey:Datakey] valueForKey:@"invoice"] valueForKey:@"amount"] == [NSNull null])){
            self.feesLabel.text = [[[responseObject valueForKey:Datakey] valueForKey:@"invoice"] valueForKey:@"amount"];
        }
        [self settingTypeWithtypeString:[[responseObject valueForKey:Datakey] valueForKey:@"type"]];
        self.statusString = [[responseObject valueForKey:Datakey] valueForKey:@"status"];
        self.durationString = [[responseObject valueForKey:Datakey] valueForKey:@"duration"];
        self.timeStampString = [[responseObject valueForKey:Datakey] valueForKey:@"timestamp"];
        self.cancelDurationString = [[responseObject valueForKey:Datakey] valueForKey:@"cancellation_interval"];
        [self settingStatusWithstatuString:self.statusString withCancellationInterval:self.timeStampString andDurationString:self.durationString andTimeStampString:self.timeStampString];
        [self addingTimerForCheckingAppointmentStatus];
        [self settingTimeStampString:self.timeStampString];
        self.previousAppointmentsArray = [[responseObject valueForKey:Datakey] valueForKey:@"previous_appointments"];
        [self.previousAppointmentTableview reloadData];
        if(self.previousAppointmentsArray.count == 0){
            self.noPrevoisappointmentsLAbel.hidden = NO;
        }
        self.invoiceDetails = [[responseObject valueForKey:Datakey] valueForKey:@"invoice"];
        if(![[[responseObject valueForKey:Datakey] valueForKey:@"notes"] isEqual:[NSNull null]]){
            self.notesString = [[responseObject valueForKey:Datakey] valueForKey:@"notes"];
        }
        
        if(self.notesString.length == 0){
            self.noteButton.hidden = YES;
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:AppName message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
    }];
}



-(void)settingDoctorDetailsWithDictionary:(id)doctorDetails{
    self.doctorNameLabel.text = [doctorDetails valueForKey:@"name"];
    NSString *docctorProfileUrlString = [doctorDetails valueForKey:@"logo_image"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:docctorProfileUrlString]];
        UIImage *tempImage = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.doctorImageView.image = tempImage;
        }
                       );
    });
}


-(void)settingTypeWithtypeString:(NSString *)typeString{
    if([typeString isEqualToString:@"1"]){
        self.appointmentTypeimageview.image = [UIImage imageNamed:@"direct-apnt-black"];
        self.appontmentTypeLabel.text = @"Direct Appointment";
        self.chatHistoryButton.hidden = YES;
        self.startAppointmentButton.hidden = YES;
        
    }
    else if ([typeString isEqualToString:@"2"]){
        self.appointmentTypeimageview.image = [UIImage imageNamed:@"chat-black"];
        self.appontmentTypeLabel.text = @"Text Chat";
        
    }
    else if ([typeString isEqualToString:@"3"]){
        self.appointmentTypeimageview.image = [UIImage imageNamed:@"audio-black"];
        self.appontmentTypeLabel.text = @"Audio Call";
        self.chatHistoryButton.hidden = YES;
    }
    else if ([typeString isEqualToString:@"4"]){
        self.appointmentTypeimageview.image = [UIImage imageNamed:@"video-black"];
        self.appontmentTypeLabel.text = @"Video Call";
        self.chatHistoryButton.hidden = YES;
    }
}
-(void)addingTimerForCheckingAppointmentStatus{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(runMethod:) userInfo:nil repeats:YES];
}
-(void)runMethod:(NSTimer *)timer{
    if(!self.whetherTimerStop){
        [self settingStatusWithstatuString:self.statusString withCancellationInterval:self.timeStampString andDurationString:self.durationString andTimeStampString:self.timeStampString];
    }
    else{
        [timer invalidate];
    }
}
-(void)settingStatusWithstatuString:(NSString *)statusString withCancellationInterval:(NSString *)cancelationTimeString andDurationString:(NSString *)durationTimeString andTimeStampString:(NSString *)timeStampString{
    if([statusString isEqualToString:@"1"]){
        [self.startAppointmentButton setTitle:@"START APPOINTMENT" forState:UIControlStateNormal];
         self.chatHistoryButton.hidden = YES;
        self.leftStatusImageview.backgroundColor = [UIColor colorWithRed:0 green:0.588 blue:0.533 alpha:1];
        [self checkingCurrentTimingsWithTimeStampString:timeStampString andDuration:durationTimeString andCancellationIntervalString:cancelationTimeString];
    }
    else if ([statusString isEqualToString:@"2"]){
        if(![self.appontmentTypeLabel.text isEqualToString:@"Text Chat"]){
            self.chatHistoryButton.hidden = YES;
        }
        self.whetherTimerStop = YES;
        [self.startAppointmentButton setTitle:@"PRESCRIPTIONS" forState:UIControlStateNormal];
        self.leftStatusImageview.backgroundColor = [UIColor colorWithRed:0.827 green:0.184 blue:0.184 alpha:1];
    }
    else if ([statusString isEqualToString:@"3"]){
        self.startAppointmentButton.hidden = YES;
         self.chatHistoryButton.hidden = YES;
        self.whetherTimerStop = YES;
        self.leftStatusImageview.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1];
    }
}

-(void)checkingCurrentTimingsWithTimeStampString:(NSString *)timeStampString andDuration:(NSString *)durationString andCancellationIntervalString:(NSString *)cacelDurationString{
    int duration = [durationString intValue];
    int cancelDuration = [cacelDurationString intValue];
    int numberOfMinutes = [self findingnumberOfMinutesInbetweenCurrentDateandDestinationDate:timeStampString];
    NSLog(@"Number Of Minutes:%d",numberOfMinutes);
    NSLog(@"Duration:%@",durationString);
    NSLog(@"Cancel Duration:%d",cancelDuration);
    if(numberOfMinutes>0){
        if(numberOfMinutes>cancelDuration){
            [self.startAppointmentButton setTitle:@"Cancel Appointment" forState:UIControlStateNormal];
            self.startAppointmentButton.hidden = NO;
        }
        else{
            self.startAppointmentButton.hidden = YES;
        }
    }
    else{
        numberOfMinutes = numberOfMinutes*-1;
        if(numberOfMinutes>duration){
            self.startAppointmentButton.hidden = NO;
            [self.startAppointmentButton setTitle:@"Prescriptions" forState:UIControlStateNormal];
        }
        else{
            self.startAppointmentButton.hidden = NO;
        }
    }
   
}
-(int)findingnumberOfMinutesInbetweenCurrentDateandDestinationDate:(NSString *)destinationDateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSDate *currentDate = [dateFormatter dateFromString:destinationDateString];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    // NSDate *date1 = [dateFormatter dateFromString:@"2010-01-01 11:00:00 +0000"];
    // NSDate *date2 = [dateFormatter dateFromString:@"2010-01-01 15:30:00 +0000"];
    NSDate *date1 = [NSDate date];
    NSDate *date2 = currentDate;
    NSLog(@"Date n1:%@",date1);
    NSLog(@"Date 2:%@",date2);
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    int numberOfMinutes = secondsBetween / 60;
    return numberOfMinutes;
    NSLog(@"There are %d minutes in between the two dates.", numberOfMinutes);
}

-(void)settingTimeStampString:(NSString *)timeStampString{
    NSLog(@"Time Stamp String:%@",timeStampString);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSDate *currentDate = [dateFormatter dateFromString:timeStampString];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    [self comparingDateWithToday:timeStampString];
    NSLog(@"ConvertedDate:%@",[dateFormatter stringFromDate:currentDate]);
    [dateFormatter setDateFormat:@"MMM"];
    NSString *monthFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.monthLabel.text = monthFromCurrentDateString;
    [dateFormatter setDateFormat:@"HH:mm a"];
    NSString *timeStringFromCurrentDateString = [dateFormatter stringFromDate:currentDate];
    self.timeLabel.text = timeStringFromCurrentDateString;
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [self splittingDate:currentDate];
    
}

-(void)splittingDate:(NSDate *)timeDate{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay| NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:timeDate];
    NSInteger day = [components day];
    self.dayLabel.text = [NSString stringWithFormat:@"%02ld",(long)day];
}

-(void)comparingDateWithToday:(NSString *)comparingDateString{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy HH:mm a";
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *responseDate = [formatter dateFromString:comparingDateString];
    if([responseDate compare:today] == NSOrderedAscending ){
//        self.playbutton.hidden = YES;
//        self.playImageView.hidden = YES;
//        self.closeButton.hidden = YES;
//        self.closeImageView.hidden = YES;
    }
    else{
//        self.playbutton.hidden = NO;
//        self.playImageView.hidden = NO;
//        self.closeButton.hidden = NO;
//        self.closeImageView.hidden = NO;
    }
}

#pragma mark - Note Button Action

- (IBAction)noteButtonAction:(id)sender {
    self.topTransparentView.hidden = NO;
    self.notesPopupView = [[[NSBundle mainBundle]
                            loadNibNamed:@"NotesPopUp"
                            owner:self options:nil]
                           firstObject];
    CGFloat xMargin = 10,yMargin = 150;
    self.notesPopupView.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
    [self populatingNotesDetailsInInVoiceview];
    [self.view addSubview:self.notesPopupView];
}

-(void)populatingNotesDetailsInInVoiceview{
    self.notesPopupView.notesString  = self.notesString;
}

#pragma mark - Invoice Button Action

- (IBAction)invoiceButtonAction:(UIButton *)sender {
    self.topTransparentView.hidden = NO;
     self.invoicePopupVew = [[[NSBundle mainBundle]
                     loadNibNamed:@"InvoicePopup"
                     owner:self options:nil]
                    firstObject];
    CGFloat xMargin = 10,yMargin = 100;
    self.invoicePopupVew.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
    [self populatingInvoiceDetailsInInVoiceview];
    [self.view addSubview:self.invoicePopupVew];
}

-(void)populatingInvoiceDetailsInInVoiceview{
    self.invoicePopupVew.invoiceDetails = self.invoiceDetails;
}

- (IBAction)chatHistorybuttonAction:(UIButton *)sender {
}




- (IBAction)startappointmentbuttonAction:(UIButton *)sender {
    [self intialisingPayUmoneyParametes];
}

#pragma mark - Initialising Payu money parameters

-(void)intialisingPayUmoneyParametes{
    self.paymentParamForPassing = [PayUModelPaymentParams new];
    self.paymentParamForPassing.key = @"0MQaQP";
    self.paymentParamForPassing.transactionID = @"Ywism0Q9XC88qvy";
    self.paymentParamForPassing.amount = @"10.0";
    self.paymentParamForPassing.productInfo = @"Nokia";
    self.paymentParamForPassing.firstName = @"Ram";
    self.paymentParamForPassing.email = @"email@testsdk1.com";
    self.paymentParamForPassing.userCredentials = @"ra:ra";
    self.paymentParamForPassing.phoneNumber = @"1111111111";
    self.paymentParamForPassing.SURL = @"https://payu.herokuapp.com/ios_success";
    self.paymentParamForPassing.FURL = @"https://payu.herokuapp.com/ios_failure";
    self.paymentParamForPassing.udf1 = @"u1";
    self.paymentParamForPassing.udf2 = @"u2";
    self.paymentParamForPassing.udf3 = @"u3";
    self.paymentParamForPassing.udf4 = @"u4";
    self.paymentParamForPassing.udf5 = @"u5";
    self.paymentParamForPassing.environment = ENVIRONMENT_PRODUCTION;
    self.paymentParamForPassing.offerKey = @"offertest@1411";
    [self initialsingExtraParameters];
}


-(void)initialsingExtraParameters{
    self.getHashesFromServer = [PayUSAGetHashes new];
    [self.getHashesFromServer generateHashFromServer:self.paymentParamForPassing withCompletionBlock:^(PayUModelHashes *hashes, NSString *errorString) {
        NSLog(@"Hashes:%@",hashes);
        [self callSDKWithHashes:hashes withError:errorString];
    }];
}

-(void)callSDKWithHashes:(PayUModelHashes *) allHashes withError:(NSString *) errorMessage{
    if (errorMessage == nil) {
        self.paymentParam.hashes = allHashes;
       // if (self.switchForOneTap.on) {
            PayUSAOneTapToken *OneTapToken = [PayUSAOneTapToken new];
            [OneTapToken getOneTapTokenDictionaryFromServerWithPaymentParam:self.paymentParam CompletionBlock:^(NSDictionary *CardTokenAndMerchantHash, NSString *errorString) {
                if (errorMessage) {
                    NSLog(@"Error message:%@",errorMessage);
                    
                }
                else{
                    [self callSDKWithOneTap:CardTokenAndMerchantHash];
                }
            }];
      //  }
       // else{
          //  [self callSDKWithOneTap:nil];
       // }
    }
    else{
       
    }
}

-(void) callSDKWithOneTap:(NSDictionary *)oneTapDict{
    
    self.paymentParam.OneTapTokenDictionary = oneTapDict;
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    [respo callVASForMobileSDKWithPaymentParam:self.paymentParam];        //FORVAS1
    self.webServiceResponse = [PayUWebServiceResponse new];
    [self.webServiceResponse getPayUPaymentRelatedDetailForMobileSDK:self.paymentParam withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
        
        if (errorMessage) {
            NSLog(@"Error Message:%@",errorMessage);
        }
        else{
            NSLog(@"Payment related Details:%@",paymentRelatedDetails);
//            PayUUIPaymentOptionViewController *paymentOptionVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_OPTION];
//            paymentOptionVC.paymentParam = self.paymentParam;
//            paymentOptionVC.paymentRelatedDetail = paymentRelatedDetails;
//            [self.navigationController pushViewController:paymentOptionVC animated:true];
        }
    }];
}
@end
