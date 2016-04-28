//
//  DoctorAboutVC.h
//  MAA
//
//  Created by Cocoalabs India on 30/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorAboutVC : UIViewController
@property (nonatomic, assign) BOOL isFromClinic;

@property (weak, nonatomic) IBOutlet UILabel *doctorNameHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UITableView *specializationTableView;

@property (weak, nonatomic) IBOutlet UIButton *specializationViewMoreButton;
@property (weak, nonatomic) IBOutlet UITableView *servicesTableView;
@property (weak, nonatomic) IBOutlet UIButton *servicesViewMoreButton;
@property (weak, nonatomic) IBOutlet UITableView *memberShipTableView;

@property (weak, nonatomic) IBOutlet UIButton *memberShipViewMoreButton;
@property (weak, nonatomic) IBOutlet UITableView *awardsTableView;

@property (weak, nonatomic) IBOutlet UIButton *awardsviewMoreButton;
@property (weak, nonatomic) IBOutlet UITableView *experienceTableView;
@property (weak, nonatomic) IBOutlet UIButton *experienceViewMoreButton;
@property (weak, nonatomic) IBOutlet UITableView *educationTableView;
@property (weak, nonatomic) IBOutlet UIButton *educationViewMoreButton;
@property (weak, nonatomic) IBOutlet UITableView *registrationTableView;
@property (weak, nonatomic) IBOutlet UIButton *registrationViewMoreButton;

@property (nonatomic, strong) NSString *clinicNameString;
@property (nonatomic, strong) NSString *doctorNameString;
@property (nonatomic, strong) NSArray *specializationArray;
@property (nonatomic, strong) NSArray *servicesArray;
@property (nonatomic, strong) NSArray *membershipsArray;
@property (nonatomic, strong) NSArray *awardsArray;
@property (nonatomic, strong) NSArray *experienceArray;
@property (nonatomic, strong) NSArray *educationArray;
@property (nonatomic, strong) NSArray *registrationArray;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeightConstarint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *specializationHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *servicesHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *membershipHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *awardsHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *experienceHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *educationHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *registrationHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *specializationLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicesLabel;
@property (weak, nonatomic) IBOutlet UILabel *memebershipLabel;
@property (weak, nonatomic) IBOutlet UILabel *awardsLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrationLabel;

@end
