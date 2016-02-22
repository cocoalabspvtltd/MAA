//
//  AskQuestionsVC.m
//  MAA
//
//  Created by Cocoalabs India on 21/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AskQuestionsVC.h"
#import "AskQuestionsCategoryView.h"

@interface AskQuestionsVC ()<UITabBarControllerDelegate,UITabBarDelegate>
@property (nonatomic, strong) UIView *topTransparentView;
@property (nonatomic, strong) AskQuestionsCategoryView *askQuestionsCategoryView;
@end

@implementation AskQuestionsVC

- (void)viewDidLoad
{
    _tblCategories.hidden=YES;
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
    [askQuestionMutableDictionary setValue:[NSNumber numberWithInt:1] forKey:@"category_id"];
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

- (IBAction)ChooseCategory:(id)sender
{
    self.topTransparentView.hidden = NO;
    _tblCategories.hidden=NO;
    self.askQuestionsCategoryView = [[[NSBundle mainBundle]
                             loadNibNamed:@"categories"
                             owner:self options:nil]
                            firstObject];
    CGFloat xMargin = 10,yMargin = 150;
    self.askQuestionsCategoryView.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
   // [self populatingInvoiceDetailsInInVoiceview];
    [self.view addSubview:self.askQuestionsCategoryView];

}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
