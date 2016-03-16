//
//  FeedBackVC.m
//  MAA
//
//  Created by Cocoalabs India on 26/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "FeedBackVC.h"

@interface FeedBackVC ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,assign)CGRect oldFrame;
@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedbacktextView.layer.borderWidth = .5f;
    self.feedbacktextView.layer.cornerRadius=5;
    self.feedbacktextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self addingGetureRecognizerToTheView];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)addingGetureRecognizerToTheView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)tapGestureAction{
    [UIView animateWithDuration:0.20 animations:^{
        CGRect newFrame = self.oldFrame;
        [self.feedbacktextView resignFirstResponder];
        [self.nameTextField resignFirstResponder];
        [self.emailTextField resignFirstResponder];
        [self.view setFrame:newFrame];
    }completion:^(BOOL finished)
     {
         
     }];
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
    [UIView animateWithDuration:0.30 animations:^{
        CGRect newFrame = self.oldFrame;
        [self.view setFrame:newFrame];
    }completion:^(BOOL finished)
     {
         
     }];
    if([self isValidInput]){
        [self callingFeedBackApi];
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

#pragma mark - Feedback Api Call

-(void)callingFeedBackApi{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *feedbackUrlString = [Baseurl stringByAppendingString:FeedbackUrl];
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *feedbackMutableDictionary = [[NSMutableDictionary alloc] init];
    [feedbackMutableDictionary setValue:self.feedbacktextView.text forKey:@"message"];
    [feedbackMutableDictionary setValue:self.nameTextField.text forKey:@"name"];
    [feedbackMutableDictionary setValue:self.emailTextField.text forKey:@"email"];
    [feedbackMutableDictionary setValue:tokenString forKey:@"token"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:feedbackUrlString] withBody:feedbackMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        if([[responseObject valueForKey:@"status"] isEqualToString:@"success"]){
           [self callingPushAlertViewControllerWithMessageString:[responseObject valueForKey:@"data"]];
        }
        else{
          [self callingAlertViewControllerWithMessageString:@"Feed back submission failed"];
        }
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

-(void)callingPushAlertViewControllerWithMessageString:(NSString *)alertMessage{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:alertMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   [self.navigationController popViewControllerAnimated:YES];
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Text Field Delegates

- (void)viewDidAppear:(BOOL)animated{
    self.oldFrame = self.view.frame;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.nameTextField ) {
        [UIView animateWithDuration:0.30 animations:^{
            CGRect newFrame = self.oldFrame;
            newFrame.origin.y -= self.nameTextField.y-150;
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    else if (textField == self.emailTextField ) {
        [UIView animateWithDuration:0.30 animations:^{
            CGRect newFrame = self.oldFrame;
            newFrame.origin.y -= self.emailTextField.y-170;
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    
}

//self.Outlet_nameOFthegift.height
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.nameTextField){
        [self.emailTextField becomeFirstResponder];
    }
    else{
        [UIView animateWithDuration:0.20 animations:^{
            CGRect newFrame = self.oldFrame;
            [self.emailTextField resignFirstResponder];
            [self.view setFrame:newFrame];
        }completion:^(BOOL finished)
         {
             
         }];
    }
    return YES;
}
@end
