//
//  SearchFilterVC.h
//  MAA
//
//  Created by Roshith on 15/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFilterVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtType;
@property (weak, nonatomic) IBOutlet UIButton *btnExperience;
- (IBAction)Experience:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnConsultaionFee;
- (IBAction)ConsultationFee:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSun;
@property (weak, nonatomic) IBOutlet UIButton *btnMon;
@property (weak, nonatomic) IBOutlet UIButton *btnTue;
@property (weak, nonatomic) IBOutlet UIButton *btnWed;
@property (weak, nonatomic) IBOutlet UIButton *btnThu;
@property (weak, nonatomic) IBOutlet UIButton *btnFri;
@property (weak, nonatomic) IBOutlet UIButton *btnSat;
@property (weak, nonatomic) IBOutlet UITextField *txtFeeFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtFeeTo;
@property (weak, nonatomic) IBOutlet UITextField *txtAgeFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtAgeTo;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
@property (weak, nonatomic) IBOutlet UITextField *txtExperienceFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtExperienceTo;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
