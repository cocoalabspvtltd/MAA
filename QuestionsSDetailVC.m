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
    self.navigationController.navigationBar.hidden = YES;
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
    [self settingDoctorProfileImageWithUrlStrimg:[detailsData valueForKey:@"answeree_image"] withAnswereID: [detailsData valueForKey:@"answeree_id"]];
}

-(void)settingDoctorProfileImageWithUrlStrimg:(NSString *)profileImageUrlString withAnswereID:(NSString *)answereID{
        NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor"];
        NSURL *imageUrl = [NSURL URLWithString:profileImageUrlString];
        UIImage *localImage;
        localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:answereID];
        if(!localImage){
            [MBProgressHUD showHUDAddedTo:self.doctorProfileImageView animated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                UIImage *tempImage = [UIImage imageWithData:imageData];
                [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:answereID];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.doctorProfileImageView.image = tempImage;
                    [MBProgressHUD hideAllHUDsForView:self.doctorProfileImageView animated:YES];
                }
                               );
            });
        }
        else{
            self.doctorProfileImageView.image = localImage;
        }
        
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
