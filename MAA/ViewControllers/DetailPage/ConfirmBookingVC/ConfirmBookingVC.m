//
//  ConfirmBookingVC.m
//  MAA
//
//  Created by Cocoalabs India on 18/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define typeIdkey @"typeId"
#define typeNamekey @"typeName"

#import "ConfirmBookingVC.h"
#import "PaymentPageViewController.h"

@interface ConfirmBookingVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    NSMutableArray *appointmentTypePickerArray;
    UIPickerView *appointmentTypePickerView;
    NSInteger selectedAppointmwnttype;
    NSString *selectedappointmenttypeString;
}
@end

@implementation ConfirmBookingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    
    [self initialisationofPickerView];
    [self addDoneToolBar];
    self.dateLabel.text  = self.dateString;
    self.timeLabel.text = self.timeString;
    self.amountLabel.text = self.amountString;
    self.locationLabel.text = self.locationString;
}

-(void)initialisationofPickerView{
    NSLog(@"EntityDetails:%@",self.entityDetails);
    appointmentTypePickerArray = [[NSMutableArray alloc] init];
    if([[self.entityDetails valueForKey:@"e_audio_call_avail"] isEqualToString:@"1"]){
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setValue:@"Audio Call" forKey:typeNamekey];
        [dataDictionary setValue:@"3" forKey:typeIdkey];
        [appointmentTypePickerArray addObject:dataDictionary];
    }
    if([[self.entityDetails valueForKey:@"e_direct_cons_avail"] isEqualToString:@"1"]){
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setValue:@"Direct Appointment" forKey:typeNamekey];
        [dataDictionary setValue:@"1" forKey:typeIdkey];
        [appointmentTypePickerArray addObject:dataDictionary];
    }
    if([[self.entityDetails valueForKey:@"e_text_chat_avail"] isEqualToString:@"1"]){
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setValue:@"Text Chat" forKey:typeNamekey];
        [dataDictionary setValue:@"2" forKey:typeIdkey];
        [appointmentTypePickerArray addObject:dataDictionary];
    }
    if([[self.entityDetails valueForKey:@"e_video_call_avail"] isEqualToString:@"1"]){
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setValue:@"Video Call" forKey:typeNamekey];
        [dataDictionary setValue:@"4" forKey:typeIdkey];
        [appointmentTypePickerArray addObject:dataDictionary];
    }
    selectedAppointmwnttype = 0;
    selectedappointmenttypeString = [[appointmentTypePickerArray objectAtIndex:0] valueForKey:typeNamekey];
    appointmentTypePickerView = [[UIPickerView alloc] init];
    appointmentTypePickerView.dataSource = self;
    appointmentTypePickerView.delegate = self;
    self.appointmentTypetextfield.inputView = appointmentTypePickerView;
}

-(void)addDoneToolBar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton1, nil]];
    self.appointmentTypetextfield.inputAccessoryView = toolBar;
    
}

-(void)doneButtonTouched:(UIButton *)button{
    [self.appointmentTypetextfield resignFirstResponder];
    self.appointmentTypetextfield.text = selectedappointmenttypeString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker View Datasources

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView ==appointmentTypePickerView) {
        return [appointmentTypePickerArray count];
        
    }
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    if (pickerView ==appointmentTypePickerView) {
        return [appointmentTypePickerArray[row] valueForKey:typeNamekey];
        
    }
    return @"a";
    
    
}

#pragma mark - Picker view Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==appointmentTypePickerView) {
        selectedAppointmwnttype = [[[appointmentTypePickerArray objectAtIndex:row] valueForKey:typeIdkey] integerValue];;
        selectedappointmenttypeString = [appointmentTypePickerArray[row] valueForKey:typeNamekey];
    }
}

#pragma mark - Text Field Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([selectedappointmenttypeString isEqualToString:[[appointmentTypePickerArray objectAtIndex:0] valueForKey:typeNamekey]]){
        selectedAppointmwnttype = [[[appointmentTypePickerArray objectAtIndex:0] valueForKey:typeIdkey] integerValue];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirmButtonAction:(UIButton *)sender {
    if([self isValidInput]){
        [self callingBookAppointmentApi];
    }
    
}

-(BOOL)isValidInput{
    BOOL isValid = YES;
    NSString *errorMessageString;
    if(selectedAppointmwnttype == 0){
        errorMessageString = @"Please select appointment type";
        isValid = NO;
    }
    if(!isValid){
        [self callingAlertViewControllerWithString:errorMessageString];
    }
    return isValid;
}

#pragma mark - Adding Alert Controller

-(void)callingAlertViewControllerWithString:(NSString *)alertMessage{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:alertMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Calling Booking Api

-(void)callingBookAppointmentApi{
    NSString *bookingAppointmentUrlString = [Baseurl stringByAppendingString:BookAppointmentUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *bookAppointmentMutableDictionary = [[NSMutableDictionary alloc] init];
    [bookAppointmentMutableDictionary setValue:accesstoken forKey:@"token"];
    [bookAppointmentMutableDictionary setValue:self.timeSlotId forKey:@"time_slot_id"];
    [bookAppointmentMutableDictionary setValue:self.dateString forKey:@"date"];
    [bookAppointmentMutableDictionary setValue:self.entityIdString forKey:@"user_entity_id"];
    [bookAppointmentMutableDictionary setValue:[NSNumber numberWithInteger:selectedAppointmwnttype] forKey:@"appointment_type"];
    [bookAppointmentMutableDictionary setValue:@"" forKey:@"notes"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:bookingAppointmentUrlString] withBody:bookAppointmentMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response object:%@",responseObject);
        if([[responseObject valueForKey:StatusKey] isEqualToString:@"error"]){
            [self callingAlertViewControllerWithString:[responseObject valueForKey:@"error_message"]];
        }
        else{
            [self addingPaymentgateWayWithResponseData:[responseObject valueForKey:Datakey]];
        }
        
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

#pragma mark - Adding Payment Gateway Page

-(void)addingPaymentgateWayWithResponseData:(id)responseData{
    PaymentPageViewController *paymentVC = [[PaymentPageViewController alloc] init];
    UINavigationController *paymentNavController = [[UINavigationController alloc] initWithRootViewController:paymentVC];
    paymentVC.amountString = self.amountString;
    paymentVC.payeeEmailidString = [responseData valueForKey:@"patient_email"];
    paymentVC.payeeNameString = [responseData valueForKey:@"patient_name"];
    paymentVC.payeePhoneString = [responseData valueForKey:@"patient_phone"];
    paymentVC.productInfoString = [responseData valueForKey:@"ap_id"];
    paymentVC.appointmentIdString = [responseData valueForKey:@"ap_id"];
    [self presentViewController:paymentNavController animated:YES completion:nil];
}
@end
