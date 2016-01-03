//
//  HospitalProfile.h
//  MAA
//
//  Created by kiran on 02/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalProfile : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *experienceLabel;
@property (nonatomic, strong) NSString *entityId;
@property (strong, nonatomic) IBOutlet UILabel *clinicNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taglineLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *consultationFeeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *satisfiedpeopleLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *firstTabSeparatorView;
@property (strong, nonatomic) IBOutlet UIImageView *secondTabSeparatorView;
@property (strong, nonatomic) IBOutlet UIImageView *thirdTabSeparatorView;
@property (strong, nonatomic) IBOutlet UIImageView *firstTabImageView;
@property (strong, nonatomic) IBOutlet UIImageView *thirdTabImageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondTabOmageView;
@end
