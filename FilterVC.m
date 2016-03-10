//
//  FilterVC.m
//  MAA
//
//  Created by Cocoalabs India on 10/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "FilterVC.h"

@interface FilterVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    NSArray *types;
    NSArray *status;
    UIPickerView *typofAppoinments;
    UIPickerView *StatusPicker;
}

@end

@implementation FilterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    typofAppoinments=[[UIPickerView alloc]init];
    typofAppoinments.delegate=self;
    typofAppoinments.dataSource=self;
    _txtTypOfAppoinment.inputView=typofAppoinments;
    types=@[@"Any",@"Audio Call",@"Video Call",@"Direct Appoinment",@"Chat"];
    
    StatusPicker=[[UIPickerView alloc]init];
    StatusPicker.delegate=self;
    StatusPicker.dataSource=self;
    _Status.inputView=StatusPicker;
    
    status=@[@"All",@"Active",@"Cancelled"];

    
    UIDatePicker *FromdDatePicker = [[UIDatePicker alloc] init];
    FromdDatePicker.datePickerMode = UIDatePickerModeDate;
    [FromdDatePicker addTarget:self action:@selector(FromDatePickerValueChanged) forControlEvents:UIControlEventValueChanged];
   
    _txtFrom.inputView = FromdDatePicker;
    
    UIDatePicker *ToDatePicker = [[UIDatePicker alloc] init];
    ToDatePicker.datePickerMode = UIDatePickerModeDate;
    [ToDatePicker addTarget:self action:@selector(ToDatePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    
    _txtTo.inputView = ToDatePicker;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView==typofAppoinments) {
        return 1;
    }
    else if (pickerView==StatusPicker)
    {
        return 1;
    }
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if(pickerView==typofAppoinments)
    {
        return types.count;
    }
    else if (pickerView==StatusPicker)
    {
        return status.count;
    }
    
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return types[row];

}

-(void)FromDatePickerValueChanged
{
    
}

-(void)ToDatePickerValueChanged
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Submit:(id)sender {
}
@end
