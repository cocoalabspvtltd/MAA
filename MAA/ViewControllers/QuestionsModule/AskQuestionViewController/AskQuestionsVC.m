//
//  AskQuestionsVC.m
//  MAA
//
//  Created by Cocoalabs India on 21/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AskQuestionsVC.h"

@interface AskQuestionsVC ()

@end

@implementation AskQuestionsVC

- (void)viewDidLoad
{
    _tblCategories.hidden=YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

// [askQuestionMutableDictionary setValue:self.questionTextField.text forKey:@"question"];
    
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
    _tblCategories.hidden=NO;

}
@end
