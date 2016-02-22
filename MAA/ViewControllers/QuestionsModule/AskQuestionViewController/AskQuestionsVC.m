//
//  AskQuestionsVC.m
//  MAA
//
//  Created by Cocoalabs India on 21/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AskQuestionsVC.h"
#import "AskQuestionsCategoryView.h"

@interface AskQuestionsVC ()<UITabBarControllerDelegate,UITabBarDelegate,AskQuestionsCategoryViewDeleagte>
@property (nonatomic, strong) UIView *topTransparentView;
@property (nonatomic, strong) AskQuestionsCategoryView *askQuestionsCategoryView;
@property (nonatomic, strong) NSString *selectedCategoryId;
@end

@implementation AskQuestionsVC

- (void)viewDidLoad
{
    [self addingToptransparentView];
    self.topTransparentView.hidden = YES;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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
    [self callingAskQuestionApi];
}


#pragma mark - Ask Question api

-(void)callingAskQuestionApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *askQuestionMutableDictionary = [[NSMutableDictionary alloc] init];
    [askQuestionMutableDictionary setValue:accessToken forKey:@"token"];
    [askQuestionMutableDictionary setValue:[NSNumber numberWithInt:1] forKey:@"id"];
    [askQuestionMutableDictionary setValue:self.selectedCategoryId forKey:@"category_id"];
    [askQuestionMutableDictionary setValue:self.titleTextField.text forKey:@"title"];
    [askQuestionMutableDictionary setValue:self.questionTextField.text forKey:@"question"];
    NSString *askQuestionUrlString = [Baseurl stringByAppendingString:AskQuestionUrl];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:askQuestionUrlString] withBody:askQuestionMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"REsponse Object:%@",responseObject);
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
    self.topTransparentView.hidden = NO;
    self.askQuestionsCategoryView = [[[NSBundle mainBundle]
                             loadNibNamed:@"categories"
                             owner:self options:nil]
                            firstObject];
    CGFloat xMargin = 10,yMargin = 150;
    self.askQuestionsCategoryView.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
    self.askQuestionsCategoryView.askQuestionsCategoryDelegate = self;
   // [self populatingInvoiceDetailsInInVoiceview];
    [self.view addSubview:self.askQuestionsCategoryView];
    [self getCategoriesApiCall];

}

#pragma mark - Get Categories api

-(void)getCategoriesApiCall{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSLog(@"Access Token:%@",accessToken);
    NSString *getCategoriesUrlString = [Baseurl stringByAppendingString:GetCategoriesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:@"" forKey:@"keyword"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:0] forKey:Offsetkey];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:100] forKey:LimitKey];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getCategoriesUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
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

-(void)salectedCategoryWithIndex:(NSString *)selectedCategoryIndex withCategoryName:(NSString *)categoryName{
    self.selectedCategoryId = selectedCategoryIndex;
    self.topTransparentView.hidden = YES;
    [self.askQuestionsCategoryView removeFromSuperview];
    NSLog(@"Selectd category ID:%@",selectedCategoryIndex);
}

@end
