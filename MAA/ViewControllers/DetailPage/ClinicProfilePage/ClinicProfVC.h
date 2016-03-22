//
//  ClinicProfVC.h
//  MAA
//
//  Created by Cocoalabs India on 22/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClinicProfVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *clinicProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *clinicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *clinicDetail;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *consultationLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noOfConsultationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactNumberLabel;
@property (weak, nonatomic) IBOutlet UITableView *doctorsTableView;
@property (nonatomic, strong) NSString *entityId;
@end
