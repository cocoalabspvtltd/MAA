//
//  SearchFilterVC.m
//  MAA
//
//  Created by Roshith on 15/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "SearchFilterVC.h"

@interface SearchFilterVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UIPickerView *type;
    UIPickerView *gender;
    NSArray *Type;
    NSArray *Gender;
    UITapGestureRecognizer *gesture;
    
    
}

@end

@implementation SearchFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self callingFilterInfoApi];
    Type=@[@"Clinic",@"Doctor",@"All"];
    Gender=@[@"Male",@"Female"];
    
    type=[[UIPickerView alloc]init];
    _txtType.inputView=type;
    type.delegate=self;
    type.dataSource=self;
    type.tag=10;
    
    gender=[[UIPickerView alloc]init];
    _txtGender.inputView=gender;
    gender.delegate=self;
    gender.dataSource=self;
    gender.tag=20;
    
    gesture.delegate=self;
    gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tapping)];
    [self.mainView addGestureRecognizer:gesture];
    
    
    _txtType.layer.borderWidth=0.5f;
    
    _txtType.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _txtFeeFrom.layer.borderWidth=0.5f;
    _txtFeeFrom.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _txtFeeTo.layer.borderWidth=0.5f;
    _txtFeeTo.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _txtAgeFrom.layer.borderWidth=0.5f;
    _txtAgeFrom.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _txtAgeTo.layer.borderWidth=0.5f;
    _txtAgeTo.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _txtGender.layer.borderWidth=0.5f;
    _txtGender.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _txtExperienceFrom.layer.borderWidth=0.5f;
    _txtExperienceFrom.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _txtExperienceTo.layer.borderWidth=0.5f;
    _txtExperienceTo.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnExperience.layer.borderWidth=0.5f;
    _btnExperience.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnConsultaionFee.layer.borderWidth=0.5f;
    _btnConsultaionFee.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnSun.layer.borderWidth=0.5f;
    _btnSun.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnMon.layer.borderWidth=0.5f;
    _btnMon.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnTue.layer.borderWidth=0.5f;
    _btnTue.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnWed.layer.borderWidth=0.5f;
    _btnWed.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnThu.layer.borderWidth=0.5f;
    _btnThu.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnFri.layer.borderWidth=0.5f;
    _btnFri.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    _btnSat.layer.borderWidth=0.5f;
    _btnSat.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
    // Do any additional setup after loading the view.
    
    
    
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
    
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if(pickerView.tag==10)
    {
        return Type.count;
    }
    else if (pickerView.tag==20)
    {
        return Gender.count;
    }
    
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag==10)
    {
        return Type[row];
    }
    else if (pickerView.tag==20)
    {
        return Gender[row];
    }
   
    return nil;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==10)
    {
        _txtType.text=Type[row];
        
    }
    else if (pickerView.tag==20)
    {
         _txtGender.text=Gender[row];
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

- (void)viewWillAppear:(BOOL)animated
{
    [self setLabelSize];
}

- (void)setLabelSize
{
    
}

#pragma mark - Calling Search Filter Api

-(void)callingFilterInfoApi{
    NSString *searchInfoUrlString = [Baseurl stringByAppendingString:GetFilterInfoUrl];
    NSLog(@"Search Info Url:%@",searchInfoUrlString);
    NSString *accessTokenString  = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *filterMutableDictionary = [[NSMutableDictionary alloc] init];
    [filterMutableDictionary setValue:accessTokenString forKey:@"token"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:searchInfoUrlString] withBody:filterMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessTokenString];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Response Object:%@",responseObject);
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
- (IBAction)maleButtonAction:(UIButton *)sender {
}

- (IBAction)isOnlineButtonAction:(UIButton *)sender {
}
- (IBAction)femaleButtonAction:(UIButton *)sender {
}
- (IBAction)Close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Experience:(id)sender {
}
- (IBAction)ConsultationFee:(id)sender {
}
@end
