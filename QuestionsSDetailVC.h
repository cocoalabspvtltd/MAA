//
//  QuestionsSDetailVC.h
//  MAA
//
//  Created by kiran on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsSDetailVC : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *questionDetailLabe;
@property (strong, nonatomic) IBOutlet UIImageView *doctorProfileImageView;
@property (strong, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *doctorSpecialityLabel;
@property (strong, nonatomic) IBOutlet UILabel *answerDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *answerLabe;

@end
