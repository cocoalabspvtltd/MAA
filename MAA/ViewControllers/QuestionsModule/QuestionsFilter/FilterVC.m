//
//  FilterVC.m
//  MAA
//
//  Created by Cocoalabs India on 10/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "FilterVC.h"

@interface FilterVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UIPickerView *typofAppoinments;
    UIPickerView *typofQuestions;
    UIPickerView *StatusPicker;
    UITapGestureRecognizer *gesture;
    UIDatePicker *FromdDatePicker;
    UIDatePicker *ToDatePicker;
}
@property (nonatomic, strong) NSMutableArray *questionsTypeArray;
@property (nonatomic, strong) NSString *fromDateString;
@property (nonatomic, strong) NSString *toDateString;
@property (nonatomic, strong) NSString *questionsTypeIdString;
@property (nonatomic, strong) NSMutableArray *appointmenTypeArray;
@property (nonatomic, strong) NSMutableArray *appointmenStatusArray;
@property (nonatomic, strong) NSString *appointmentStatusIdString;
@property (nonatomic, strong) NSString *appointmentTypeIdString;
@end

@implementation FilterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initialisation];
    _txtFrom.layer.borderWidth=.5f;
    _txtFrom.layer.cornerRadius=5;
    _txtFrom.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    _txtTo.layer.borderWidth=.5f;
    _txtTo.layer.cornerRadius=5;
    _txtTo.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    _txtTypOfAppoinment.layer.borderWidth=.5f;
    _txtTypOfAppoinment.layer.cornerRadius=5;
    _txtTypOfAppoinment.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    _Status.layer.borderWidth=.5f;
    _Status.layer.cornerRadius=5;
    _Status.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    _txtQuestionType.layer.borderWidth=.5f;
    _txtQuestionType.layer.cornerRadius=5;
    _txtQuestionType.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    typofAppoinments=[[UIPickerView alloc]init];
    typofAppoinments.delegate=self;
    typofAppoinments.dataSource=self;
    _txtTypOfAppoinment.inputView=typofAppoinments;
    typofAppoinments.tag = 10;
    
    StatusPicker=[[UIPickerView alloc]init];
    StatusPicker.delegate=self;
    StatusPicker.dataSource=self;
    _Status.inputView=StatusPicker;
    StatusPicker.tag = 20;
    
    typofQuestions=[[UIPickerView alloc]init];
    typofQuestions.delegate=self;
    typofQuestions.dataSource=self;
    _txtQuestionType.inputView=typofQuestions;
    typofQuestions.tag = 30;
    gesture.delegate=self;
    gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tapping)];
    [self.ChildView addGestureRecognizer:gesture];
    
    FromdDatePicker = [[UIDatePicker alloc] init];
    FromdDatePicker.datePickerMode = UIDatePickerModeDate;
    [FromdDatePicker addTarget:self action:@selector(FromDatePickerValueChanged) forControlEvents:UIControlEventValueChanged];
   
    _txtFrom.inputView = FromdDatePicker;
    
    ToDatePicker = [[UIDatePicker alloc] init];
    ToDatePicker.datePickerMode = UIDatePickerModeDate;
    [ToDatePicker addTarget:self action:@selector(ToDatePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    
    _txtTo.inputView = ToDatePicker;
    
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.fromDateString = @"";
    self.toDateString = @"";
    self.questionsTypeIdString = @"";
    self.appointmentStatusIdString = @"";
    self.appointmentTypeIdString = @"";
    [self initialisingTypeArray];
    [self initialisingAppointmentTypesArray];
    [self initialisingAppointmentStatusArray];
}

-(void)initialisingTypeArray{
    self.questionsTypeArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *questionTypeMutableDictionAry1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"All",@"name",@"0",@"typeId", nil];
     NSMutableDictionary *questionTypeMutableDictionAry2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Mine",@"name",@"1",@"typeId", nil];
    [self.questionsTypeArray addObject:questionTypeMutableDictionAry1];
     [self.questionsTypeArray addObject:questionTypeMutableDictionAry2];
}

-(void)initialisingAppointmentTypesArray{
    self.appointmenTypeArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *appointmentTypeMutableDictionAry0 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Any",@"name",@"0",@"typeId", nil];
     NSMutableDictionary *appointmentTypeMutableDictionAry1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Direct Appoinment",@"name",@"1",@"typeId", nil];
    NSMutableDictionary *appointmentTypeMutableDictionAry2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Chat",@"name",@"2",@"typeId", nil];
    NSMutableDictionary *appointmentTypeMutableDictionAry3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Audio Call",@"name",@"3",@"typeId", nil];
    NSMutableDictionary *appointmentTypeMutableDictionAry4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Video Call",@"name",@"4",@"typeId", nil];
    [self.appointmenTypeArray addObject:appointmentTypeMutableDictionAry0];
    [self.appointmenTypeArray addObject:appointmentTypeMutableDictionAry1];
    [self.appointmenTypeArray addObject:appointmentTypeMutableDictionAry2];
    [self.appointmenTypeArray addObject:appointmentTypeMutableDictionAry3];
    [self.appointmenTypeArray addObject:appointmentTypeMutableDictionAry4];
}

-(void)initialisingAppointmentStatusArray{
    self.appointmenStatusArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *appointmentStatusMutableDictionAry0 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"All",@"name",@"0",@"typeId", nil];
    NSMutableDictionary *appointmentStatusMutableDictionAry1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Active",@"name",@"1",@"typeId", nil];
    NSMutableDictionary *appointmentStatusMutableDictionAry2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Finished",@"name",@"2",@"typeId", nil];
    NSMutableDictionary *appointmentStatusMutableDictionAry3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Cancelled",@"name",@"3",@"typeId", nil];
    [self.appointmenStatusArray addObject:appointmentStatusMutableDictionAry0];
    [self.appointmenStatusArray addObject:appointmentStatusMutableDictionAry1];
    [self.appointmenStatusArray addObject:appointmentStatusMutableDictionAry2];
    [self.appointmenStatusArray addObject:appointmentStatusMutableDictionAry3];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==20)
    {
        _Status.text=[self.appointmenStatusArray[row] valueForKey:@"name"];
        self.appointmentStatusIdString  = [self.appointmenStatusArray[row] valueForKey:@"typeId"];
    }
    else if (pickerView.tag==10)
    {
        _txtTypOfAppoinment.text=[self.appointmenTypeArray[row] valueForKey:@"name"];
        self.appointmentTypeIdString  = [self.appointmenTypeArray[row] valueForKey:@"typeId"];
    }
    else if (pickerView.tag==30)
    {
        _txtQuestionType.text=[self.questionsTypeArray[row] valueForKey:@"name"];
        self.questionsTypeIdString = [self.questionsTypeArray[row] valueForKey:@"typeId"];
    }
    
}

-(void)Tapping
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView.tag==10) {
        return 1;
    }
    else if (pickerView.tag==20)
    {
        return 1;
    }
    else if (pickerView.tag==30)
    {
        return 1;
    }
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if(pickerView.tag==10)
    {
        return self.appointmenTypeArray.count;
    }
    else if (pickerView.tag==20)
    {
        return self.appointmenStatusArray.count;
    }
    else if (pickerView.tag==30)
    {
        return self.questionsTypeArray.count;
    }
    
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag==10)
    {
        return [self.appointmenTypeArray[row] valueForKey:@"name"];
    }
    else if (pickerView.tag==20)
    {
        return [self.appointmenStatusArray[row] valueForKey:@"name"];
    }
    else if (pickerView.tag==30)
    {
        return [self.questionsTypeArray[row] valueForKey:@"name"];
    }
    return nil;

}

-(void)FromDatePickerValueChanged
{
    UIDatePicker *picker = (UIDatePicker*)self.txtFrom.inputView;
    self.fromDateString = [self convertingDateToStringForApiWithDate:picker.date];
    self.txtFrom.text = [self convertingDateToStringForETxtFieldDate:picker.date];
}

-(void)ToDatePickerValueChanged
{
    UIDatePicker *picker = (UIDatePicker*)self.txtTo.inputView;
    self.toDateString = [self convertingDateToStringForApiWithDate:picker.date];
    self.txtTo.text = [self convertingDateToStringForETxtFieldDate:picker.date];
}

-(NSString *)convertingDateToStringForETxtFieldDate:(NSDate *)inputDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    return [dateFormatter stringFromDate:inputDate];
}

-(NSString *)convertingDateToStringForApiWithDate:(NSDate *)inputDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:inputDate];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Submit:(id)sender
{
    if(self.isFromAppointment){
        if(self.filterVCDelegate && [self.filterVCDelegate respondsToSelector:@selector(submitButtonActionForAppointmentWithFromDate:andToDateString:andAppointmenttype:andStatus:)]){
            [self.filterVCDelegate submitButtonActionForAppointmentWithFromDate:self.fromDateString andToDateString:self.toDateString andAppointmenttype:self.appointmentTypeIdString andStatus:self.appointmentStatusIdString];
        }
    }
    else{
        if(self.filterVCDelegate &&[self.filterVCDelegate respondsToSelector:@selector(submitButtonActionWithQuestionCategoryid:FromDate:andToDate:andType:)]){
            [self.filterVCDelegate submitButtonActionWithQuestionCategoryid:@"" FromDate:self.fromDateString andToDate:self.toDateString andType:self.questionsTypeIdString];
            
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Close:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SelectCategory:(id)sender
{
    //navigate to a category listing page
}
@end
