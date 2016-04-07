//
//  SearchFilterVC.m
//  MAA
//
//  Created by Roshith on 15/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#define TypePickerViewTag 10
#define GenderPickerViewTag 20
#define FromAgePickerViewTag 30
#define ToAgePickerViewTag 70
#define FromFeePickerViewTag 40
#define ToFeePickerViewTag 80
#define FromExperiencePickerViewTag 50
#define ToExperiencePickerViewTag 100
#define CategoryPickerViewTag 60

#import "SearchFilterVC.h"

@interface SearchFilterVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UIPickerView *typePickerview;
    UIPickerView *genderPickerView;
    UIPickerView *fromAgePickerView;
    UIPickerView *toAgePickerView;
    UIPickerView *fromFeePickerView;
    UIPickerView *ToFeePickerView;
    UIPickerView *fromExperiencePickerView;
    UIPickerView *toExperiencePickerView;
    UIPickerView *categoryPickerView;
    UITapGestureRecognizer *gesture;
    
    
}

@property (nonatomic, strong) id selectedFromAge;
@property (nonatomic, strong) id selectedToAge;
@property (nonatomic, strong) id selectedFromFee;
@property (nonatomic, strong) id selectedTofee;
@property (nonatomic, strong) id selectedFromExperience;
@property (nonatomic, strong) id selectedToExperience;

@property (nonatomic, strong) id filterCriteriaData;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *genderArray;
@property (nonatomic, strong) NSArray *ageArray;
@property (nonatomic, strong) NSArray *feeArray;
@property (nonatomic, strong) NSArray *experienceArray;
@property (nonatomic, strong) NSArray *categoriesArray;
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
    
    
    fromAgePickerView = [[UIPickerView alloc]init];
    _txtAgeFrom.inputView = fromAgePickerView;
    fromAgePickerView.delegate = self;
    fromAgePickerView.dataSource = self;
    fromAgePickerView.tag = FromAgePickerViewTag;
    
    toAgePickerView = [[UIPickerView alloc]init];
    _txtAgeTo.inputView = toAgePickerView;
    toAgePickerView.delegate = self;
    toAgePickerView.dataSource = self;
    toAgePickerView.tag = ToAgePickerViewTag;
    
    fromFeePickerView = [[UIPickerView alloc]init];
    _txtFeeFrom.inputView = fromFeePickerView;
    fromFeePickerView.delegate = self;
    fromFeePickerView.dataSource = self;
    fromFeePickerView.tag = FromFeePickerViewTag;
    
    ToFeePickerView = [[UIPickerView alloc]init];
    _txtFeeTo.inputView = ToFeePickerView;
    ToFeePickerView.delegate = self;
    ToFeePickerView.dataSource = self;
    ToFeePickerView.tag = ToFeePickerViewTag;
    
    fromExperiencePickerView = [[UIPickerView alloc]init];
    _txtExperienceFrom.inputView = fromExperiencePickerView;
    fromExperiencePickerView.delegate = self;
    fromExperiencePickerView.dataSource = self;
    fromExperiencePickerView.tag = FromExperiencePickerViewTag;
    
    toExperiencePickerView = [[UIPickerView alloc]init];
    _txtExperienceTo.inputView = toExperiencePickerView;
    toExperiencePickerView.delegate = self;
    toExperiencePickerView.dataSource = self;
    toExperiencePickerView.tag = ToExperiencePickerViewTag;
    
    categoryPickerView = [[UIPickerView alloc]init];
    _txtCategory.inputView = categoryPickerView;
    categoryPickerView.delegate = self;
    categoryPickerView.dataSource = self;
    categoryPickerView.tag = CategoryPickerViewTag;
    
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
    if(self.selectedAvailabltyDateArray.count == 0){
        self.selectedAvailabltyDateArray = [[NSMutableArray alloc] init];
    }
    else{
        for (int i = 0; i<self.selectedAvailabltyDateArray.count; i++) {
            if(([[self.selectedAvailabltyDateArray objectAtIndex:i] intValue] == 1)){
                self.btnSun.backgroundColor = [UIColor redColor];
                [self.btnSun setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if(([[self.selectedAvailabltyDateArray objectAtIndex:i] intValue] == 2)){
                self.btnMon.backgroundColor = [UIColor redColor];
                [self.btnMon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if(([[self.selectedAvailabltyDateArray objectAtIndex:i] intValue] == 3)){
                self.btnTue.backgroundColor = [UIColor redColor];
                [self.btnTue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if(([[self.selectedAvailabltyDateArray objectAtIndex:i] intValue] == 4)){
                self.btnWed.backgroundColor = [UIColor redColor];
                [self.btnWed setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if(([[self.selectedAvailabltyDateArray objectAtIndex:i] intValue] == 5)){
                self.btnThu.backgroundColor = [UIColor redColor];
                [self.btnThu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if(([[self.selectedAvailabltyDateArray objectAtIndex:i] intValue] == 6)){
                self.btnFri.backgroundColor = [UIColor redColor];
                [self.btnFri setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if(([[self.selectedAvailabltyDateArray objectAtIndex:i] intValue] == 7)){
                self.btnSat.backgroundColor = [UIColor redColor];
                [self.btnSat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    if(self.sortBasedOnExperience){
        [self.btnExperience setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnExperience.backgroundColor = [UIColor redColor];
    }
    else if (self.sortBasedOnFee){
        [self.btnConsultaionFee setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnConsultaionFee.backgroundColor = [UIColor redColor];
    }
    else{
        self.sortBasedOnExperience = YES;
        self.sortBasedOnFee = NO;
        [self.btnExperience setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnExperience.backgroundColor = [UIColor redColor];
    }
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
    else if ((pickerView.tag == FromAgePickerViewTag)||(pickerView.tag == ToAgePickerViewTag)){
        return 1;
    }
    else if ((pickerView.tag == FromFeePickerViewTag)||(pickerView.tag == ToFeePickerViewTag)){
        return 1;
    }
    else if (pickerView.tag == CategoryPickerViewTag){
        return 1;
    }
    else if ((pickerView.tag == FromExperiencePickerViewTag)||(pickerView.tag == ToExperiencePickerViewTag)){
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
    else if ((pickerView.tag == FromAgePickerViewTag)||(pickerView.tag == ToAgePickerViewTag)){
        return self.ageArray.count;
    }
    else if ((pickerView.tag == FromFeePickerViewTag)||(pickerView.tag == ToFeePickerViewTag)){
        return self.feeArray.count;
    }
    else if ((pickerView.tag == FromExperiencePickerViewTag)||(pickerView.tag == ToExperiencePickerViewTag)){
        return self.experienceArray.count;
    }
    else if (pickerView.tag == CategoryPickerViewTag){
        return self.categoriesArray.count;
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
    else if ((pickerView.tag == FromAgePickerViewTag)||(pickerView.tag == ToAgePickerViewTag))
    {
        return [self.ageArray[row] valueForKey:@"label"];
    }
    else if ((pickerView.tag == FromFeePickerViewTag)||(pickerView.tag == ToFeePickerViewTag))
    {
        return [self.feeArray[row] valueForKey:@"label"];
    }
    else if ((pickerView.tag == FromExperiencePickerViewTag)||(pickerView.tag == ToExperiencePickerViewTag))
    {
        return [self.experienceArray[row] valueForKey:@"label"];
    }
    else if (pickerView.tag == CategoryPickerViewTag)
    {
        return [self.categoriesArray[row] valueForKey:@"name"];
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
    else if (pickerView.tag == FromAgePickerViewTag)
    {
        self.selectedFromAge = self.ageArray[row];
        _txtAgeFrom.text = [self.ageArray[row] valueForKey:@"label"];
        [_txtAgeFrom resignFirstResponder];
    }
    else if (pickerView.tag == ToAgePickerViewTag)
    {
        self.selectedToAge = self.ageArray[row];
        _txtAgeTo.text = [self.ageArray[row] valueForKey:@"label"];
        [_txtAgeTo resignFirstResponder];
    }
    else if (pickerView.tag == FromFeePickerViewTag){
        self.selectedFromFee = self.feeArray[row];
        _txtFeeFrom.text = [self.feeArray[row] valueForKey:@"label"];
        [_txtFeeFrom resignFirstResponder];
    }
    else if (pickerView.tag == ToFeePickerViewTag)
    {
        self.selectedTofee = self.feeArray[row];
        _txtFeeTo.text = [self.feeArray[row] valueForKey:@"label"];
        [_txtFeeTo resignFirstResponder];
    }
    else if (pickerView.tag == FromExperiencePickerViewTag)
    {
        self.selectedFromExperience = self.experienceArray[row];
        _txtExperienceFrom.text = [self.experienceArray[row] valueForKey:@"label"];
        [_txtExperienceFrom resignFirstResponder];
    }
    else if (pickerView.tag == ToExperiencePickerViewTag)
    {
        self.selectedToExperience = self.experienceArray[row];
        _txtExperienceTo.text = [self.experienceArray[row] valueForKey:@"label"];
        [_txtExperienceTo resignFirstResponder];
    }
    else if (pickerView.tag == CategoryPickerViewTag)
    {
        self.selectedCategory = self.categoriesArray[row];
        _txtCategory.text = [self.categoriesArray[row] valueForKey:@"name"];
        [_txtCategory resignFirstResponder];
        NSLog(@"slectd Category:%@",self.selectedCategory);
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
        [self getCategoriesApiCall];
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
    NSLog(@"type Details:%@",self.selectedType);
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"type"] intValue];
    self.typeArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    if(![self.selectedType valueForKey:@"value"]){
        self.selectedType = [self.typeArray objectAtIndex:0];
    }
    self.txtType.text = [self.selectedType valueForKey:@"label"];
}

-(void)gettingGenderFromResponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"gender"] intValue];
    self.genderArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    if(![self.selectedGender valueForKey:@"value"]){
        self.selectedGender = [self.genderArray objectAtIndex:0];
    }
    self.txtGender.text = [self.selectedGender valueForKey:@"label"];
}

-(void)gettingAgeFromResponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"age"] intValue];
    self.ageArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    if(self.selectedAgeMutableArray.count>0){
        NSPredicate *agepredicate1 = [NSPredicate predicateWithFormat:@"SELF.value == %@",[self.selectedAgeMutableArray objectAtIndex:0]];
        NSArray *filteredArray1 = [self.ageArray filteredArrayUsingPredicate:agepredicate1];
        _txtAgeFrom.text = [filteredArray1[0] valueForKey:@"label"];
        self.selectedFromAge = [filteredArray1 objectAtIndex:0];
        NSPredicate *agepredicate2 = [NSPredicate predicateWithFormat:@"SELF.value == %@",[self.selectedAgeMutableArray objectAtIndex:1]];
        NSArray *filteredArray2 = [self.ageArray filteredArrayUsingPredicate:agepredicate2];
        _txtAgeTo.text = [filteredArray2[0] valueForKey:@"label"];
        self.selectedToAge = [filteredArray2 objectAtIndex:0];
    }
    else{
        self.selectedFromAge = [self.ageArray objectAtIndex:0];
        self.selectedToAge = [self.ageArray objectAtIndex:0];
        self.txtAgeFrom.text = [self.selectedFromAge valueForKey:@"label"];
        self.txtAgeTo.text = [self.selectedToAge valueForKey:@"label"];
    }
}

-(void)gettingFeeFromResponse{
    id indicesDetails = [self.filterCriteriaData valueForKey:@"indices"];
    int index = [[indicesDetails valueForKey:@"fee"] intValue];
    self.feeArray = [[[self.filterCriteriaData valueForKey:@"filter_data"] objectAtIndex:index] valueForKey:@"values"];
    
    if(self.selectedFeeMutableArray.count>0){
        NSPredicate *feepredicate1 = [NSPredicate predicateWithFormat:@"SELF.value == %@",[self.selectedFeeMutableArray objectAtIndex:0]];
        NSArray *filteredArray1 = [self.feeArray filteredArrayUsingPredicate:feepredicate1];
        _txtFeeFrom.text = [filteredArray1[0] valueForKey:@"label"];
        self.selectedFromFee = [filteredArray1 objectAtIndex:0];
        NSPredicate *feepredicate2 = [NSPredicate predicateWithFormat:@"SELF.value == %@",[self.selectedFeeMutableArray objectAtIndex:1]];
        NSArray *filteredArray2 = [self.feeArray filteredArrayUsingPredicate:feepredicate2];
        _txtFeeTo.text = [filteredArray2[0] valueForKey:@"label"];
        self.selectedTofee = [filteredArray2 objectAtIndex:0];
    }
    else{
        self.selectedFromFee = [self.feeArray objectAtIndex:0];
        self.selectedTofee = [self.feeArray objectAtIndex:0];
        self.txtFeeFrom.text = [self.selectedFromFee valueForKey:@"label"];
        self.txtFeeTo.text = [self.selectedTofee valueForKey:@"label"];
    }
   
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

#pragma mark - Get Categories Api Calle

-(void)getCategoriesApiCall{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *getCategoriesUrlString = [Baseurl stringByAppendingString:GetCategoriesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:@"" forKey:@"keyword"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:0] forKey:Offsetkey];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:100] forKey:LimitKey];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getCategoriesUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object:%@",responseObject);
        self.categoriesArray = [responseObject valueForKey:Datakey];
        NSLog(@"Selected Department Details :%@",self.selectedDepartmentDetails);
        NSPredicate *filterArrayPrediate = [NSPredicate predicateWithFormat:@"SELF.id == %@",[self.selectedDepartmentDetails valueForKey:@"id"]];
        NSArray *filteredArray = [self.categoriesArray filteredArrayUsingPredicate:filterArrayPrediate];
        NSLog(@"Filtered Array;%@",filteredArray);
        self.selectedCategory = [filteredArray objectAtIndex:0];
        self.txtCategory.text =[self.selectedCategory valueForKey:@"name"];
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

#pragma mark - Button Actions

- (IBAction)isOnlineButtonAction:(UIButton *)sender {
}

- (IBAction)Close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)consultationFeeButtonAction:(UIButton *)sender {
    self.sortBasedOnFee = YES;
    self.sortBasedOnExperience = NO;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor redColor];
    [self.btnExperience setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnExperience.backgroundColor = [UIColor whiteColor];
}
- (IBAction)experienceButtonAction:(UIButton *)sender {
    self.sortBasedOnFee = NO;
    self.sortBasedOnExperience = YES;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor redColor];
    [self.btnConsultaionFee setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnConsultaionFee.backgroundColor = [UIColor whiteColor];
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
    self.selectedType = [self.typeArray objectAtIndex:0];
    self.txtType.text = [self.selectedType valueForKey:@"label"];
    [typePickerview selectRow:0 inComponent:0 animated:NO];
    self.sortBasedOnFee = NO;
    self.sortBasedOnExperience = YES;
    [self.btnExperience setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnExperience.backgroundColor = [UIColor redColor];
    [self.btnConsultaionFee setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnConsultaionFee.backgroundColor = [UIColor whiteColor];
    [self.selectedAvailabltyDateArray removeAllObjects];
    self.btnSun.selected = NO;
    self.btnSun.backgroundColor = [UIColor whiteColor];
    [self.btnSun setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnMon.selected = NO;
    self.btnMon.backgroundColor = [UIColor whiteColor];
    [self.btnMon setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnTue.selected = NO;
    self.btnTue.backgroundColor = [UIColor whiteColor];
    [self.btnTue setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnWed.selected = NO;
    self.btnWed.backgroundColor = [UIColor whiteColor];
    [self.btnWed setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnThu.selected = NO;
    self.btnThu.backgroundColor = [UIColor whiteColor];
    [self.btnThu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnFri.selected = NO;
    self.btnFri.backgroundColor = [UIColor whiteColor];
    [self.btnFri setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btnSat.selected = NO;
    self.btnSat.backgroundColor = [UIColor whiteColor];
    [self.btnSat setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.selectedFromFee = [self.feeArray objectAtIndex:0];
    self.txtFeeFrom.text = [self.selectedFromFee valueForKey:@"label"];
    [fromFeePickerView selectRow:0 inComponent:0 animated:NO];
    self.selectedTofee = [self.feeArray objectAtIndex:0];
    self.txtFeeTo.text = [self.selectedTofee valueForKey:@"label"];
    [ToFeePickerView selectRow:0 inComponent:0 animated:NO];
    self.selectedFromAge = [self.ageArray objectAtIndex:0];
    self.txtAgeFrom.text = [self.selectedFromAge valueForKey:@"label"];
    [fromAgePickerView selectRow:0 inComponent:0 animated:NO];
    self.selectedToAge = [self.ageArray objectAtIndex:0];
    self.txtAgeTo.text = [self.selectedToAge valueForKey:@"label"];
    [toAgePickerView selectRow:0 inComponent:0 animated:NO];
    self.selectedGender = [self.genderArray objectAtIndex:0];
    self.txtGender.text = [self.selectedGender valueForKey:@"label"];
    [genderPickerView selectRow:0 inComponent:0 animated:NO];
    self.selectedFromExperience = [self.experienceArray objectAtIndex:0];
    self.txtExperienceFrom.text = [self.selectedFromExperience valueForKey:@"label"];
    [fromExperiencePickerView selectRow:0 inComponent:0 animated:NO];
    self.selectedToExperience = [self.experienceArray objectAtIndex:0];
    self.txtExperienceTo.text = [self.selectedToExperience valueForKey:@"label"];
    [toExperiencePickerView selectRow:0 inComponent:0 animated:NO];
    
}
- (IBAction)submitButtonAction:(UIButton *)sender {
    if(self.selectedFeeMutableArray.count == 0){
        self.selectedFeeMutableArray = [[NSMutableArray alloc] init];
        if([self.selectedFromFee valueForKey:@"value"]){
            [self.selectedFeeMutableArray addObject:[self.selectedFromFee valueForKey:@"value"]];
        }
        if([self.selectedTofee valueForKey:@"value"]){
            [self.selectedFeeMutableArray addObject:[self.selectedTofee valueForKey:@"value"]];
        }
    }
    if(self.selectedAgeMutableArray.count == 0){
        self.selectedAgeMutableArray= [[NSMutableArray alloc] init];
        if([self.selectedFromAge valueForKey:@"value"]){
            [self.selectedAgeMutableArray addObject:[self.selectedFromAge valueForKey:@"value"]];
        }
        if([self.selectedToAge valueForKey:@"value"]){
            [self.selectedAgeMutableArray addObject:[self.selectedToAge valueForKey:@"value"]];
        }
    }
    NSMutableArray *experienceArray = [[NSMutableArray alloc] init];
    if([self.selectedFromExperience valueForKey:@"value"]){
        [experienceArray addObject:[self.selectedFromExperience valueForKey:@"value"]];
    }
    if([self.selectedToExperience valueForKey:@"value"]){
        [experienceArray addObject:[self.selectedToExperience valueForKey:@"value"]];
    }
    
    if(self.searchFilterDelagate && [self.searchFilterDelagate respondsToSelector:@selector(submitButtonActionWithType:andWhetherSortbyExperience:andwhetherSortByConsultationFee:andAvailabilityArra:andCategory:andFeeDetails:andAgeDetail:andGenderDetail:andExperienceDetail:)]){
        [self.searchFilterDelagate submitButtonActionWithType:self.selectedType andWhetherSortbyExperience:self.sortBasedOnExperience andwhetherSortByConsultationFee:self.sortBasedOnFee andAvailabilityArra:self.selectedAvailabltyDateArray andCategory:self.selectedCategory andFeeDetails:self.selectedFeeMutableArray andAgeDetail:self.selectedAgeMutableArray andGenderDetail:self.selectedGender andExperienceDetail:experienceArray];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
