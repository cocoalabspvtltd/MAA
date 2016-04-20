//
//  AskQuestionsVC.m
//  MAA
//
//  Created by Cocoalabs India on 21/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "CategoriesList.h"
#import "AskQuestionsVC.h"

@interface AskQuestionsVC ()<UITabBarControllerDelegate,UITabBarDelegate,UITextFieldDelegate,CategoryDelegate>
@property (nonatomic, strong) NSString *selectedCategoryId;
@property (nonatomic, strong) UITapGestureRecognizer *textFieldEditingTapgesture;
@end

@implementation AskQuestionsVC

- (void)viewDidLoad
{
    [self addingTapGeture];
    self.selectedCategoryId = @"";
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

-(void)addingTapGeture{
    self.textFieldEditingTapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singletapAction:)];
     self.textFieldEditingTapgesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: self.textFieldEditingTapgesture];
}

-(void)singletapAction:(UITapGestureRecognizer *)tapgesture{
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
- (IBAction)askButtonAction:(UIButton *)sender {
    if([self isValidInputs]){
        [self callingAskQuestionApi];
    }
}


#pragma mark - Ask Question api

-(void)callingAskQuestionApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *askQuestionMutableDictionary = [[NSMutableDictionary alloc] init];
    [askQuestionMutableDictionary setValue:accessToken forKey:@"token"];
    [askQuestionMutableDictionary setValue:self.selectedCategoryId forKey:@"category_id"];
    [askQuestionMutableDictionary setValue:self.questionTextField.text forKey:@"title"];
    [askQuestionMutableDictionary setValue:self.questionDescriptionTextField.text forKey:@"question"];
    NSString *askQuestionUrlString = [Baseurl stringByAppendingString:AskQuestionUrl];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:askQuestionUrlString] withBody:askQuestionMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"REsponse Object:%@",responseObject);
        [self callingAlertViewControllerAfterAddingQuestionWithString:[[responseObject valueForKey:Datakey] valueForKey:@"message"]];
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

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ChooseCategory:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoriesList *categoriesListVC = [storyboard instantiateViewControllerWithIdentifier:@"CategoriesList"];
    categoriesListVC.categoryDelegate = self;
    [self.navigationController pushViewController:categoriesListVC animated:YES];
}


#pragma mark - Category Delegate
-(void)tableViewSelectedActionWithCategoryDetails:(id)selectedCategoryDetails{
    self.selectedCategoryId = [selectedCategoryDetails valueForKey:@"id"];
    [self.chooseCategoryButton setTitle:[selectedCategoryDetails valueForKey:@"name"] forState:UIControlStateNormal];
    NSString *imageUrlString = [selectedCategoryDetails valueForKey:@"logo_image"];
    [self.categoryImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageForDocumentLoading]];
}

#pragma mark - Text field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.questionTextField){
        [textField resignFirstResponder];
        [self.questionDescriptionTextField becomeFirstResponder];
    }
    else if (textField == self.questionDescriptionTextField){
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Validation

-(BOOL)isValidInputs{
    BOOL valid = YES;
    NSString *alertMessage = @"";
    if([self.questionTextField.text empty]){
        alertMessage = @"Please enter your question";
        valid = NO;
    }
    else if ([self.questionDescriptionTextField.text empty]){
        alertMessage = @"Please enter your question description";
        valid = NO;
    }
    else if ([self.selectedCategoryId empty]){
        alertMessage = @"Please choose category";
        valid = NO;
    }
    if(![alertMessage empty]){
        [self callingAlertViewControllerWithString:alertMessage];
    }
    return valid;
}

-(void)callingAlertViewControllerWithString:(NSString *)alertMessage{
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

-(void)callingAlertViewControllerAfterAddingQuestionWithString:(NSString *)alertMessage{
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
@end
