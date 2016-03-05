//
//  AskQuestionsVC.m
//  MAA
//
//  Created by Cocoalabs India on 21/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AskQuestionsVC.h"
#import "AskQuestionsCategoryView.h"

@interface AskQuestionsVC ()<UITabBarControllerDelegate,UITabBarDelegate,UITextFieldDelegate,AskQuestionsCategoryViewDeleagte>
@property (nonatomic, strong) UIView *topTransparentView;
@property (nonatomic, strong) AskQuestionsCategoryView *askQuestionsCategoryView;
@property (nonatomic, strong) NSString *selectedCategoryId;
@property (nonatomic, strong) UITapGestureRecognizer *textFieldEditingTapgesture;
@end

@implementation AskQuestionsVC

- (void)viewDidLoad
{
    [self addingTapGeture];
    [self addingToptransparentView];
    self.topTransparentView.hidden = YES;
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

-(void)addingToptransparentView{
    self.topTransparentView = [[UIView alloc] init];
    self.topTransparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.topTransparentView.backgroundColor = [UIColor blackColor];
    self.topTransparentView.layer.opacity = 0.5;
    self.topTransparentView.hidden = YES;
    [self.view addSubview:self.topTransparentView];
    [self addingTapGestureToToptransparentView];
}

-(void)addingTapGestureToToptransparentView{
    UITapGestureRecognizer *transparentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTransparentViewTapGestureAction:)];
    self.topTransparentView.userInteractionEnabled = YES;
    transparentTapGesture.numberOfTapsRequired = 1;
    [self.topTransparentView addGestureRecognizer:transparentTapGesture];
}

-(void)topTransparentViewTapGestureAction:(UITapGestureRecognizer *)tapGesture{
    [self.view addGestureRecognizer:self.textFieldEditingTapgesture];
    [self.askQuestionsCategoryView removeFromSuperview];
    self.topTransparentView.hidden = YES;
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
    [self.view removeGestureRecognizer:self.textFieldEditingTapgesture];
    [self.view endEditing:YES];
    self.topTransparentView.hidden = NO;
    self.askQuestionsCategoryView = [[[NSBundle mainBundle]
                             loadNibNamed:@"categories"
                             owner:self options:nil]
                            firstObject];
    CGFloat xMargin = 10,yMargin = 150;
    
    self.askQuestionsCategoryView.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
    self.askQuestionsCategoryView.askQuestionsCategoryDelegate = self;
   // [self populatingInvoiceDetailsInInVoiceview];
    [self.view  addSubview:self.topTransparentView];
    [self.view addSubview:self.askQuestionsCategoryView];
    [self getCategoriesApiCall];

}

#pragma mark - Get Categories api

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
        self.askQuestionsCategoryView.categoriesArray = [responseObject valueForKey:Datakey];
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

#pragma mark - Ask Questions Category view Delegate

-(void)salectedCategoryWithIndex:(NSString *)selectedCategoryIndex withCategoryName:(NSString *)categoryName withImageUrlString:(NSString *)imageUrlString{
    self.selectedCategoryId = selectedCategoryIndex;
    self.topTransparentView.hidden = YES;
    [self.chooseCategoryButton setTitle:categoryName forState:UIControlStateNormal];
    [self.askQuestionsCategoryView removeFromSuperview];
    [self.categoryImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    [self.view addGestureRecognizer:self.textFieldEditingTapgesture];
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
