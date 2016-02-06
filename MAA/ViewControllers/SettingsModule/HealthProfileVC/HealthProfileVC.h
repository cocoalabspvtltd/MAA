//
//  HealthProfileVC.h
//  MAA
//
//  Created by Cocoalabs India on 29/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthProfileVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationlabel;
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *bloodGroupTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *gendertextField;
@property (weak, nonatomic) IBOutlet UITextField *lowbpTextField;
@property (weak, nonatomic) IBOutlet UITextField *highbpTextField;
@property (weak, nonatomic) IBOutlet UITextField *fastingSugartextField;
@property (weak, nonatomic) IBOutlet UITableView *prescriptionsTableView;
@property (weak, nonatomic) IBOutlet UITextField *postMealTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *medicalDocumantsCollectionview;


@end
