//
//  FilterVC.h
//  MAA
//
//  Created by Cocoalabs India on 10/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FilterVCDelegate;
@interface FilterVC : UIViewController
@property (nonatomic, assign) BOOL isFromAppointment;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtTo;
@property (weak, nonatomic) IBOutlet UITextField *txtTypOfAppoinment;
@property (weak, nonatomic) IBOutlet UITextField *Status;
- (IBAction)Submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ChildView;
- (IBAction)Close:(id)sender;
- (IBAction)SelectCategory:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtQuestionType;
@property (nonatomic, assign) id<FilterVCDelegate>filterVCDelegate;
@end
@protocol FilterVCDelegate <NSObject>
-(void)submitButtonActionWithQuestionCategoryid:(NSString *)questionsCategoryId FromDate:(NSString *)fromDate andToDate:(NSString *)toDate andType:(NSString *)type;
-(void)submitButtonActionForAppointmentWithFromDate:(NSString *)fromDateString andToDateString:(NSString *)toDateString andAppointmenttype:(NSString *)appintmentType andStatus:(NSString *)statusString;
@end