//
//  InvoiceFilterViewController.m
//  MAA
//
//  Created by Cocoalabs India on 14/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "InvoiceFilterViewController.h"

@interface InvoiceFilterViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *month_pickerArray;
    NSArray *year_pickerArray;
    UIPickerView *yearPicker;
    UIPickerView *monthPicker;
    NSString *month;
    NSString *year;
}
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;

@end

@implementation InvoiceFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self intialisation];
    [self addDoneToolBar];
    [self addingDonetoolBarForMonth];
    // Do any additional setup after loading the view.
}

-(void)intialisation{
    [self addingTapGesturerecognizer];
    month_pickerArray=@[@"All",@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    year_pickerArray=@[@"All",@"2016",@"2015",@"2014",@"2013",@"2012",@"2011",@"2010",@"2009"];
    yearPicker = [[UIPickerView alloc] init];
    monthPicker = [[UIPickerView alloc] init];
    yearPicker.dataSource = self;
    yearPicker.delegate = self;
    monthPicker.dataSource = self;
    monthPicker.delegate = self;
    self.yearTextField.inputView = yearPicker;
    self.monthTextField.inputView = monthPicker;
    month = [month_pickerArray objectAtIndex:0];
    year = [year_pickerArray objectAtIndex:0];
    self.yearTextField.text = [year_pickerArray objectAtIndex:self.yearSelectedIndex];
    self.monthTextField.text = [month_pickerArray objectAtIndex:self.monthSelectedIndex];
    
}

-(void)addingTapGesturerecognizer{
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.view addGestureRecognizer:tapgesture];
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tapgesture{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)resetButtonAction:(UIButton *)sender {
    month = [month_pickerArray objectAtIndex:0];
    year = [year_pickerArray objectAtIndex:0];
    self.monthTextField.text = @"";
    self.yearTextField.text  =@"";
    self.monthSelectedIndex = 0;
    self.yearSelectedIndex = 0;
}
- (IBAction)submitButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.invoiceFilterDelegate && [self.invoiceFilterDelegate respondsToSelector:@selector(submitButtonActionWithYearIndex:andMonthSelectedIndex:)]){
        [self.invoiceFilterDelegate submitButtonActionWithYearIndex:self.yearSelectedIndex andMonthSelectedIndex:self.monthSelectedIndex];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView ==monthPicker) {
        NSLog(@"Month Count:%lu",(unsigned long)[month_pickerArray count]);
        return [month_pickerArray count];
        
    }
    if (pickerView ==yearPicker) {
         NSLog(@"Month Count:%lu",(unsigned long)[year_pickerArray count]);
        return [year_pickerArray count];
        
    }
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    if (pickerView ==monthPicker) {
        return month_pickerArray[row];
        
    }
    if (pickerView ==yearPicker) {
        return year_pickerArray[row];
        
    }
    return @"a";
    
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==monthPicker) {
        month = month_pickerArray[row];
        self.monthSelectedIndex = row;
        
    }
    if (pickerView ==yearPicker) {
        year = year_pickerArray[row];
        self.yearSelectedIndex = row;
        
    }
}

-(void)addDoneToolBar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done1Touched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton1, nil]];
    self.yearTextField.inputAccessoryView = toolBar;
    
}

-(void)addingDonetoolBarForMonth{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done2Touched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton2, nil]];
    self.monthTextField.inputAccessoryView = toolBar;
}

- (void)done1Touched:(id)sender
{
    [self.view endEditing:YES];
    self.yearTextField.text = year;
}

- (void)done2Touched:(id)sender
{
    [self.view endEditing:YES];
    self.monthTextField.text = month;
}

@end
