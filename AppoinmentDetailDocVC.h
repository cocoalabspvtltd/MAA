//
//  AppoinmentDetailDocVC.h
//  MAA
//
//  Created by Cocoalabs India on 19/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppoinmentDetailDocVC : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfTblAllergy;
@property (weak, nonatomic) IBOutlet UIScrollView *Scroller;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIView *prescriptionView;
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
- (IBAction)Profile:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPrescription;
- (IBAction)Prescription:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnChatHistory;
- (IBAction)ChatHistory:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblDOB;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblBloodGrp;
@property (weak, nonatomic) IBOutlet UILabel *lblPostMealSuger;
@property (weak, nonatomic) IBOutlet UILabel *lblFastngSuger;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblLowBp;
@property (weak, nonatomic) IBOutlet UILabel *lblHighBp;
@property (weak, nonatomic) IBOutlet UILabel *lblHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblNotes;
@property (weak, nonatomic) IBOutlet UITableView *tblAllergies;
- (IBAction)ClickMedickalDocuments:(id)sender;
- (IBAction)clickImages:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
- (IBAction)All:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMine;
- (IBAction)Mine:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOthers;
- (IBAction)Others:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblPrescriptions;
@property (weak, nonatomic) IBOutlet UIImageView *imgFloat;
- (IBAction)FloatAddPrescription:(id)sender;


@end
