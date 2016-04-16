//
//  AddMessagesVC.m
//  MAA
//
//  Created by Cocoalabs India on 15/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AddMessagesVC.h"

@interface AddMessagesVC ()<UITextFieldDelegate>

@end

@implementation AddMessagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addingTapgesturerecognizer];
    
    _subjectTextfield.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.275 alpha:1.00]CGColor];
    _messagetTextField.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.000 blue:0.275 alpha:1.00]CGColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addingTapgesturerecognizer{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
   // tapGesture.numberOfTapsRequired = 1;
    //self.view.userInteractionEnabled  =YES;
    [self.view addGestureRecognizer:tapGesture];
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tapGesture{
    [self.view endEditing:YES];
}

#pragma mark - Button Actions

- (IBAction)submitButtonAction:(UIButton *)sender {
    if([self isValidInput]){
        [self callingSubmitMessagesApi];
    }
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Adding Submit Message Api

-(void)callingSubmitMessagesApi{
    NSString *sendEnquiryUrlString = [Baseurl stringByAppendingString:SendEnquiryUrl];
    NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *sendenquirymutableDictionary = [[NSMutableDictionary alloc] init];
    [sendenquirymutableDictionary setValue:accesstoken forKey:@"token"];
    [sendenquirymutableDictionary setValue:self.entityId forKey:@"doc_id"];
    [sendenquirymutableDictionary setValue:self.subjectTextfield.text forKey:@"subject"];
    [sendenquirymutableDictionary setValue:self.messagetTextField.text forKey:@"message"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:sendEnquiryUrlString] withBody:sendenquirymutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstoken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self addingAlertControllerForMessageSuccessViewController];
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

-(BOOL)isValidInput{
    BOOL isValid = YES;
    NSString *messageString = @"";
    if([self.subjectTextfield.text empty]){
        messageString = @"Please enter subject";
        isValid = NO;
    }
    else if ([self.messagetTextField.text empty]){
        messageString = @"Please enter message content";
        isValid = NO;
    }
    if(!isValid){
        [self addingAlertControllerForValidationWithMessage:messageString];
    }
    return isValid;
}

#pragma mark - Adding Alert Controllers

-(void)addingAlertControllerForValidationWithMessage:(NSString *)validationMessage{
    UIAlertController *validationController = [UIAlertController alertControllerWithTitle:AppName message:validationMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAlerAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [validationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [validationController addAction:okAlerAction];
    [self presentViewController:validationController animated:YES completion:nil];
}

-(void)addingAlertControllerForMessageSuccessViewController{
    UIAlertController *messageSuccessController = [UIAlertController alertControllerWithTitle:AppName message:@"Successfully sent your feed back" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAlerAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [messageSuccessController addAction:okAlerAction];
    [self presentViewController:messageSuccessController animated:YES completion:nil];
}

#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [textField resignFirstResponder];
    if(textField == self.subjectTextfield){
        [self.messagetTextField becomeFirstResponder];
    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
