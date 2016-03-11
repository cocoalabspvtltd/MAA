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
    NSArray *types;
    NSArray *status;
    NSArray *typeOfQuestions;
    UIPickerView *typofAppoinments;
    UIPickerView *typofQuestions;
    UIPickerView *StatusPicker;
    UITapGestureRecognizer *gesture;
    UIDatePicker *FromdDatePicker;
    UIDatePicker *ToDatePicker;
}

@end

@implementation FilterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _btnSelectCategory.layer.borderWidth=.5f;
    _btnSelectCategory.layer.cornerRadius=5;
    _btnSelectCategory.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    typofAppoinments=[[UIPickerView alloc]init];
    typofAppoinments.delegate=self;
    typofAppoinments.dataSource=self;
    _txtTypOfAppoinment.inputView=typofAppoinments;
    types=@[@"Any",@"Audio Call",@"Video Call",@"Direct Appoinment",@"Chat"];
    typofAppoinments.tag = 10;
    
    StatusPicker=[[UIPickerView alloc]init];
    StatusPicker.delegate=self;
    StatusPicker.dataSource=self;
    _Status.inputView=StatusPicker;
    StatusPicker.tag = 20;
    status=@[@"All",@"Active",@"Cancelled"];
    
    typofQuestions=[[UIPickerView alloc]init];
    typofQuestions.delegate=self;
    typofQuestions.dataSource=self;
    _txtQuestionType.inputView=typofQuestions;
    typofQuestions.tag = 30;
    typeOfQuestions=@[@"All",@"Mine"];
    
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==20)
    {
        _Status.text=status[row];
    }
    else if (pickerView.tag==10)
    {
        _txtTypOfAppoinment.text=types[row];
    }
    else if (pickerView.tag==30)
    {
        _txtQuestionType.text=typeOfQuestions[row];
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
        return types.count;
    }
    else if (pickerView.tag==20)
    {
        return status.count;
    }
    else if (pickerView.tag==30)
    {
        return typeOfQuestions.count;
    }
    
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag==10)
    {
        return types[row];
    }
    else if (pickerView.tag==20)
    {
        return status[row];
    }
    else if (pickerView.tag==30)
    {
        return typeOfQuestions[row];
    }
    return nil;

}

-(void)FromDatePickerValueChanged
{
    UIDatePicker *picker = (UIDatePicker*)self.txtFrom.inputView;
    
    
    
    self.txtFrom.text = [NSString stringWithFormat:@"%@",picker.date];
}

-(void)ToDatePickerValueChanged
{
    UIDatePicker *picker = (UIDatePicker*)self.txtTo.inputView;
   
    
    self.txtTo.text = [NSString stringWithFormat:@"%@",picker.date];

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
