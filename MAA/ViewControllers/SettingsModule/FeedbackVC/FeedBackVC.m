//
//  FeedBackVC.m
//  MAA
//
//  Created by Cocoalabs India on 26/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "FeedBackVC.h"

@interface FeedBackVC ()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedbacktextView.layer.borderWidth = .5f;
    self.feedbacktextView.layer.cornerRadius=15;
    self.feedbacktextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self addingGetureRecognizerToTheView];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)addingGetureRecognizerToTheView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)tapGestureAction{
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
- (IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitButtonAction:(UIButton *)sender {
    if([self isValidInput]){
        
    }
}


-(BOOL)isValidInput{
    BOOL isValid = YES;
    NSString *messageString = @"";
    if([self.feedbacktextView.text empty]){
       messageString = @"Please enter feedback message";
        isValid = NO;
    }
    if(!isValid){
        [self callingAlertViewControllerWithMessageString:messageString];
    }
    return isValid;
}

#pragma mark - adding Alert View Controller

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

#pragma mark - Text Field Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField == self.nameTextField){
        [self.emailTextField becomeFirstResponder];
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
}
@end
