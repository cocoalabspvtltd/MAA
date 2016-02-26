//
//  QuestionsSDetailVC.m
//  MAA
//
//  Created by kiran on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "QuestionsSDetailVC.h"

@interface QuestionsSDetailVC ()

@end

@implementation QuestionsSDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callingGetQuestionsDetailsApi];
    self.doctorProfileImageView.layer.cornerRadius = self.doctorProfileImageView.frame.size.width / 2;
    self.doctorProfileImageView.clipsToBounds = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)callingGetQuestionsDetailsApi{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getQuestionsMutableDictionary = [[NSMutableDictionary alloc] init];
    //[getQuestionsMutableDictionary setValue:getQuestionsText forKey:@"keyword"];
    [getQuestionsMutableDictionary setValue:accessToken forKey:@"token"];
    [getQuestionsMutableDictionary setValue:self.questionId forKey:@"id"];
    //[getQuestionsMutableDictionary setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
   // [getQuestionsMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    NSString *getQuestionsUrlString = [Baseurl stringByAppendingString:GetQuestionsApiUrl];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getQuestionsUrlString] withBody:getQuestionsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self populatingDetailPageOfQuestiosWithData:[[responseObject valueForKey:Datakey] objectAtIndex:0]];
        NSLog(@"Response Object:%@",responseObject);
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


-(void)populatingDetailPageOfQuestiosWithData:(id)detailsData{
    self.questionLabel.text = [detailsData valueForKey:@"title"];
    self.questionDetailLabe.text = [detailsData valueForKey:@"description"];
    self.dateLabel.text = [detailsData valueForKey:@"question_timestamp"];
    self.doctorNameLabel.text = [detailsData valueForKey:@"answeree_name"];
    self.doctorSpecialityLabel.text = [detailsData valueForKey:@"tagline"];
    self.answerDateLabel.text = [detailsData valueForKey:@"answer_timestamp"];
    self.answerLabe.text = [detailsData valueForKey:@"answer"];
    NSString *profileImageurlString = [detailsData valueForKey:@"answeree_image"];
    [self.doctorProfileImageView sd_setImageWithURL:[NSURL URLWithString:profileImageurlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
