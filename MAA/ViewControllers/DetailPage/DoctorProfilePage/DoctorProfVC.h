//
//  DoctorProfVC.h
//  MAA
//
//  Created by Cocoalabs India on 22/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorProfVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UILabel *namLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLineLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *experienceLbael;
@property (weak, nonatomic) IBOutlet UIButton *btnDirection;
@property (strong, nonatomic) IBOutlet UILabel *consultationFeeLabel;
@property (strong, nonatomic) IBOutlet UILabel *noOfConsultationsLabel;
@property (strong, nonatomic) IBOutlet UILabel *reviewLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;
@property (weak, nonatomic) IBOutlet UIButton *reviewAllInfoButton;
@property (weak, nonatomic) IBOutlet UILabel *cliniclocationLabel;

@property (nonatomic, strong) NSString *entityId;
@end
