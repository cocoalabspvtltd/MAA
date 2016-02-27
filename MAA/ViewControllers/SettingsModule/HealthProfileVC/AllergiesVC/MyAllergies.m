//
//  MyAllergies.m
//  MAA
//
//  Created by Cocoalabs India on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define AllergyTableViewCellIdentifier @"allergiesCell"
#import "MyAllergies.h"
#import "AllergiesTableViewCell.h"

@interface MyAllergies ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AllergiesCellDelegate>
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
    [self.tblAllergies registerNib:[UINib nibWithNibName:@"AllergiesTableViewCell" bundle:nil] forCellReuseIdentifier:AllergyTableViewCellIdentifier];
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
    AllergiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AllergyTableViewCellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllergiesTableViewCell" owner:self options:nil];
        cell = (AllergiesTableViewCell *)[nib objectAtIndex:0];
    }
    cell.tag = 100+indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.allergiesCellDelegate = self;
    cell.allergyNameLabel.text  = [[self.allergyMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"];
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
    self.allergyTextField.text = @"";
    if (_ppupView.hidden==NO)
    {
        _ppupView.hidden=YES;
        //_ppupView.backgroundColor=[UIColor whiteColor];
        self.view.backgroundColor=[UIColor whiteColor];
    }
}

- (IBAction)addButtonAction:(UIButton *)sender {
    if([self isValidAllergyInput]){
        [self.allergyTextField resignFirstResponder];
        if(self.isFromupdate){
            self.isFromupdate = NO;
            [self callingEditOrDeleteAllergyApiWithStatus:1 withSelectdIndex:self.selectedIndex];
        }
        else{
            [self addingAllergies];
        }
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

-(void)callingEditOrDeleteAllergyApiWithStatus:(int)status withSelectdIndex:(NSUInteger)selectedIndex{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *editAccountInfoUrlString = [Baseurl stringByAppendingString:EditAccountInfoUrl];
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *contentDictionary = [[NSMutableDictionary alloc] init];
    [contentDictionary setValue:[NSNumber numberWithInt:status] forKey:@"status"];
    NSString *nameString = [[self.allergyMutableArray objectAtIndex:selectedIndex] valueForKey:@"name"];
    NSString *idString = [[self.allergyMutableArray objectAtIndex:selectedIndex] valueForKey:@"id"];
    if(status == 0){
        [contentDictionary setValue:nameString forKey:@"name"];
    }
    else{
        [contentDictionary setValue:self.allergyTextField.text forKey:@"name"];
    }
    [contentDictionary setValue:idString forKey:@"id"];
    NSMutableArray *contentsArray = [[NSMutableArray alloc] init];
    [contentsArray addObject:contentDictionary];
    NSMutableDictionary *editAccountInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    [editAccountInfoMutableDictionary setValue:contentsArray forKey:@"allergies"];
    [editAccountInfoMutableDictionary setValue:tokenString forKey:@"token"];
    NSLog(@"Edit Account Dictionary:%@",editAccountInfoMutableDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:editAccountInfoUrlString] withBody:editAccountInfoMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object:%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(status == 0){
            [self.allergyMutableArray removeObjectAtIndex:selectedIndex];
            [self callingAlertViewControllerWithMessageString:@"Allergy removed successfully"];
        }
        else{
            [self.allergyMutableArray replaceObjectAtIndex:selectedIndex withObject:contentDictionary];
            [self callingAlertViewControllerWithMessageString:@"Allergy updated successfully"];
            _ppupView.hidden=YES;
            self.allergyTextField.text  =@"";
        }
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

#pragma mark - Allergies Cell Delegate

-(void)longPressGestureActionWithCellTag:(NSUInteger)cellTag{
    NSUInteger index = cellTag - 100;
    NSLog(@"Index:%lu",(unsigned long)index);
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped do nothing.
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit Title" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _ppupView.hidden=NO;
                                _ppupView.backgroundColor=[UIColor blackColor];
                                self.allergyTextField.text = [[self.allergyMutableArray objectAtIndex:index] valueForKey:@"name"];;
                                self.ppupView.layer.opacity = 0.5;
                                self.isFromupdate = YES;
                                self.selectedIndex = index;
                            }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self callingEditOrDeleteAllergyApiWithStatus:0 withSelectdIndex:index];
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
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
