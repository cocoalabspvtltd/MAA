//
//  SearchFilterVC.h
//  MAA
//
//  Created by Roshith on 15/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchFilterVCDelegate;

@interface SearchFilterVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtType;
@property (weak, nonatomic) IBOutlet UITextField *txtCategory;
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
//@property (weak, nonatomic) IBOutlet UITextField *txtExperienceTo;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UITextField *txtExperienceTo;
@property (nonatomic, assign) id <SearchFilterVCDelegate>searchFilterDelagate;
@property (nonatomic, strong) id selectedDepartmentDetails;

@property (nonatomic, strong) id selectedType;
@property (nonatomic, strong) id selectedCategory;
@property  (nonatomic, assign) BOOL sortBasedOnFee;
@property  (nonatomic, assign) BOOL sortBasedOnExperience;
@property (nonatomic, strong) NSMutableArray *selectedAvailabltyDateArray;
@property (nonatomic, strong) id selectedGender;

@property (nonatomic, strong) NSMutableArray *selectedFeeMutableArray;
@property (nonatomic, strong) NSMutableArray *selectedAgeMutableArray;


@end

@protocol SearchFilterVCDelegate <NSObject>

-(void)submitButtonActionWithType:(id)filterType andWhetherSortbyExperience:(BOOL)isSortByExperience andwhetherSortByConsultationFee:(BOOL)whetherConsultFee andAvailabilityArra:(NSMutableArray *)availabilityArray andCategory:(id)categoryDetails andFeeDetails:(NSArray *)feeDetail andAgeDetail:(NSArray *)ageDetail andGenderDetail:(id)genderDetails andExperienceDetail:(NSArray *)experienceDetail;

@end