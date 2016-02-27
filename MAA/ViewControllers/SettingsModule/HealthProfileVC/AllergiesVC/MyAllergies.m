//
//  MyAllergies.m
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define AllergyTableViewCellIdentifier @"allergyCell"
#import "MyAllergies.h"

@interface MyAllergies ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *allergyMutableArray;
@end

@implementation MyAllergies

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self callingGetAllergiesApi];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.allergyMutableArray = [[NSMutableArray alloc] init];
    _ppupView.hidden=YES;
    self.imgFloat.layer.cornerRadius = self.imgFloat.frame.size.width / 2;
    self.imgFloat.clipsToBounds = YES;
    [self.tblAllergies registerClass:[UITableViewCell class] forCellReuseIdentifier:AllergyTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allergyMutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AllergyTableViewCellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AllergyTableViewCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text  = [[self.allergyMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}


- (IBAction)FloatButton:(id)sender
{
    _ppupView.hidden=NO;
    _ppupView.backgroundColor=[UIColor blackColor];
    self.ppupView.layer.opacity = 0.5;
    
    
}

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)Cancel:(id)sender
{
    if (_ppupView.hidden==NO)
    {
        _ppupView.hidden=YES;
        //_ppupView.backgroundColor=[UIColor whiteColor];
        self.view.backgroundColor=[UIColor whiteColor];
    }
}

- (IBAction)addButtonAction:(UIButton *)sender {
    if([self isValidAllergyInput]){
        [self addingAllergies];
    }
}

#pragma mark - Api Calls

-(void)callingGetAllergiesApi{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *getAllergiesUrlString = [Baseurl stringByAppendingString:GetAllergiesUrl];
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getAllergiesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getAllergiesMutableDictionary setValue:tokenString forKey:@"token"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getAllergiesUrlString] withBody:getAllergiesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSArray *allergyarray = [responseObject valueForKey:Datakey];
        [self.allergyMutableArray addObjectsFromArray:allergyarray];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tblAllergies reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        [self callingAlertViewControllerWithMessageString:errorMessage];
    }];
}

-(void)addingAllergies{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *gaddAllergiesUrlString = [Baseurl stringByAppendingString:AddAllergiesUrl];
        NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
        NSMutableDictionary *addAllergiesMutableDictionary = [[NSMutableDictionary alloc] init];
        [addAllergiesMutableDictionary setValue:tokenString forKey:@"token"];
        [addAllergiesMutableDictionary setValue:self.allergyTextField.text forKey:@"name"];
        [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:gaddAllergiesUrlString] withBody:addAllergiesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
        [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
    
            [self.allergyMutableArray insertObject:[responseObject valueForKey:Datakey] atIndex:0];
            [self.tblAllergies reloadData];
            [self callingAlertViewControllerWithMessageString:@"Allergy added successfully"];
            _ppupView.hidden=YES;
            self.allergyTextField.text  =@"";
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
            [self callingAlertViewControllerWithMessageString:errorMessage];
        }];
}


#pragma mark - Validation

-(BOOL)isValidAllergyInput{
    BOOL valid = YES;
    NSString *errorMessageString = @"";
    if([self.allergyTextField.text empty]){
        errorMessageString = @"Please enter allergy";
        valid = NO;
    }
    if(!valid){
        [self callingAlertViewControllerWithMessageString:errorMessageString];
    }
    return valid;
}

#pragma mark - TExt Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Adding Alert View Controller

-(void)callingAlertViewControllerWithMessageString:(NSString *)alertMessage{
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
@end
