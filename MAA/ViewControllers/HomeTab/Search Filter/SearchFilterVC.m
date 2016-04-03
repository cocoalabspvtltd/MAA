//
//  SearchFilterVC.m
//  MAA
//
//  Created by Roshith on 15/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#define TypePickerViewTag 10
#define GenderPickerViewTag 20
#define AgePickerViewTag 30
#define FeePickerViewTag 40
#define ExperiencePickerViewTag 50

#import "SearchFilterVC.h"

@interface SearchFilterVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UIPickerView *typePickerview;
    UIPickerView *genderPickerView;
    UIPickerView *agePickerView;
    UIPickerView *feePickerView;
    UIPickerView *experiencePickerView;
    UITapGestureRecognizer *gesture;
    
    
}
@property (nonatomic, strong) id selectedType;
@property (nonatomic, strong) id selectedGender;
@property (nonatomic, strong) id selectedFromAge;
@property (nonatomic, strong) id selectedToAge;
@property (nonatomic, strong) id selectedFromFee;
@property (nonatomic, strong) id selectedTofee;
@property (nonatomic, strong) id selectedFromExperience;
@property (nonatomic, strong) id selectedToExperience;
@property (nonatomic, strong) NSMutableArray *selectedAvailabltyDateArray;

@property (nonatomic, strong) id filterCriteriaData;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *genderArray;
@property (nonatomic, strong) NSArray *ageArray;
@property (nonatomic, strong) NSArray *feeArray;
@property (nonatomic, strong) NSArray *experienceArray;
@end

@implementation SearchFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    
    [self callingFilterInfoApi];
    typePickerview=[[UIPickerView alloc]init];
    _txtType.inputView = typePickerview;
    typePickerview.delegate = self;
    typePickerview.dataSource = self;
    typePickerview.tag = TypePickerViewTag;
    
    genderPickerView = [[UIPickerView alloc]init];
    _txtGender.inputView = genderPickerView;
    genderPickerView.delegate = self;
    genderPickerView.dataSource = self;
    genderPickerView.tag = GenderPickerViewTag;
    
    
    agePickerView = [[UIPickerView alloc]init];
    _txtAgeFrom.inputView = agePickerView;
    _txtAgeTo.inputView = agePickerView;
    agePickerView.delegate = self;
    agePickerView.dataSource = self;
    agePickerView.tag = AgePickerViewTag;
    
    feePickerView = [[UIPickerView alloc]init];
    _txtFeeFrom.inputView = feePickerView;
    _txtFeeTo.inputView = feePickerView;
    feePickerView.delegate = self;
    feePickerView.dataSource = self;
    feePickerView.tag = FeePickerViewTag;
    
    experiencePickerView = [[UIPickerView alloc]init];
    _txtExperienceFrom.inputView = experiencePickerView;
    _txtExperienceTo.inputView = experiencePickerView;
    experiencePickerView.delegate = self;
    experiencePickerView.dataSource = self;
    experiencePickerView.tag = ExperiencePickerViewTag;
    
    gesture.delegate=self;
    gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tapping)];
    [self.mainView addGestureRecognizer:gesture];
    
    _txtCategory.layer.borderWidth=0.5f;
    _txtCategory.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.271 alpha:1.00]CGColor];
    
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

-(void)initialisation{
    self.selectedAvailabltyDateArray = [[NSMutableArray alloc] init];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView.tag== TypePickerViewTag) {
        return 1;
    }
    else if (pickerView.tag == GenderPickerViewTag)
    {
        return 1;
    }
    else if (pickerView.tag == AgePickerViewTag){
        return 1;
    }
    else if (pickerView.tag == FeePickerViewTag){
        return 1;
    }
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if(pickerView.tag == TypePickerViewTag)
    {
        return self.typeArray.count;
    }
    else if (pickerView.tag == GenderPickerViewTag)
    {
        return self.genderArray.count;
    }
    else if (pickerView.tag == AgePickerViewTag){
        return self.ageArray.count;
    }
    else if (pickerView.tag == FeePickerViewTag){
        return self.feeArray.count;
    }
    else if (pickerView.tag == ExperiencePickerViewTag){
        return self.experienceArray.count;
    }
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == TypePickerViewTag)
    {
        return [self.typeArray[row] valueForKey:@"label"];
    }
    else if (pickerView.tag == GenderPickerViewTag)
    {
        return [self.genderArray[row] valueForKey:@"label"];
    }
    else if (pickerView.tag == AgePickerViewTag)
    {
        return [self.ageArray[row] valueForKey:@"label"];
    }
    else if (pickerView.tag == FeePickerViewTag)
    {
        return [self.feeArray[row] valueForKey:@"label"];
    }
    else if (pickerView.tag == ExperiencePickerViewTag)
    {
        return [self.experienceArray[row] valueForKey:@"label"];
    }
    return nil;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == TypePickerViewTag)
    {
        self.selectedType = self.typeArray[row];
        _txtType.text = [self.typeArray[row] valueForKey:@"label"];
        [_txtType resignFirstResponder];
    }
    else if (pickerView.tag == GenderPickerViewTag)
    {
        self.selectedGender = self.genderArray[row];
        _txtGender.text = [self.genderArray[row] valueForKey:@"label"];
        [_txtGender resignFirstResponder];
    }
    else if (pickerView.tag == AgePickerViewTag)
    {
        self.selectedFromAge = self.ageArray[row];
        _txtAgeFrom.text = [self.ageArray[row] valueForKey:@"label"];
        _txtAgeTo.text = [self.ageArray[row] valueForKey:@"label"];
        [_txtAgeFrom resignFirstResponder];
        [_txtAgeTo resignFirstResponder];
        NSLog(@"slectd Gender:%@",self.selectedType);
    }
    else if (pickerView.tag == FeePickerViewTag)
    {
        self.selectedFromFee = self.feeArray[row];
        _txtFeeFrom.text = [self.feeArray[row] valueForKey:@"label"];
        _txtFeeTo.text = [self.feeArray[row] valueForKey:@"label"];
        [_txtFeeFrom resignFirstResponder];
        [_txtFeeTo resignFirstResponder];
        NSLog(@"slectd Gender:%@",self.selectedType);
    }
    else if (pickerView.tag == ExperiencePickerViewTag)
    {
        self.selectedFromExperience = self.experienceArray[row];
        _txtExperienceFrom.text = [self.experienceArray[row] valueForKey:@"label"];
        _txtExperienceTo.text = [self.experienceArray[row] valueForKey:@"label"];
        [_txtExperienceFrom resignFirstResponder];
        [_txtExperienceTo resignFirstResponder];
        NSLog(@"slectd Gender:%@",self.selectedType);
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
        self.filterCriteriaData = [responseObject valueForKey:Datakey];
        [self gettingTypeArrayFromresponse];
        [self gettingGenderFromResponse];
        [self gettingAgeFromResponse];
        [self gettingFeeFromResponse];
        [self gettingExperienceFromResponse];
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

-(void)gettingTypeArrayFromresponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"type"] intValue];
    self.typeArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    self.selectedType = [self.typeArray objectAtIndex:0];
    self.txtType.text = [self.selectedType valueForKey:@"label"];
}

-(void)gettingGenderFromResponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"gender"] intValue];
    self.genderArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    self.selectedGender = [self.genderArray objectAtIndex:0];
    self.txtGender.text = [self.selectedGender valueForKey:@"label"];
}

-(void)gettingAgeFromResponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"age"] intValue];
    self.ageArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    self.selectedFromAge = [self.ageArray objectAtIndex:0];
    self.selectedToAge = [self.ageArray objectAtIndex:0];
    self.txtAgeFrom.text = [self.selectedFromAge valueForKey:@"label"];
    self.txtAgeTo.text = [self.selectedToAge valueForKey:@"label"];
}

-(void)gettingFeeFromResponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"fee"] intValue];
    self.feeArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    self.selectedFromFee = [self.feeArray objectAtIndex:0];
    self.selectedTofee = [self.feeArray objectAtIndex:0];
    self.txtFeeFrom.text = [self.selectedFromFee valueForKey:@"label"];
    self.txtFeeTo.text = [self.selectedTofee valueForKey:@"label"];
}

-(void)gettingExperienceFromResponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"experience"] intValue];
    self.experienceArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    self.selectedFromExperience = [self.experienceArray objectAtIndex:0];
    self.selectedToExperience = [self.experienceArray objectAtIndex:0];
    self.txtExperienceFrom.text = [self.selectedFromExperience valueForKey:@"label"];
    self.txtExperienceTo.text = [self.selectedToExperience valueForKey:@"label"];
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

- (IBAction)availabilityButtonaction:(UIButton *)sender {
    NSNumber *senderTagNumber;
    if([sender isSelected]){
        sender.selected = NO;
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
         senderTagNumber = [NSNumber numberWithInteger:sender.tag];
        [self.selectedAvailabltyDateArray removeObject:senderTagNumber];
    }
    else{
        sender.selected = YES;
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        senderTagNumber = [NSNumber numberWithInteger:sender.tag];
        [self.selectedAvailabltyDateArray addObject:senderTagNumber];
    }
    NSLog(@"Date Array:%@",self.selectedAvailabltyDateArray);
    NSLog(@"Sender Tag:%ld",(long)sender.tag);
}
- (IBAction)cancelFilterButtonAction:(UIButton *)sender {
}
- (IBAction)submitButtonAction:(UIButton *)sender {
}
@end
