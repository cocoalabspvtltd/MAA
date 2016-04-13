//
//  TakeAppointmentVC.h
//  MAA
//
//  Created by Cocoalabs India on 09/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeAppointmentVC : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *timeCollectionview;
@property (weak, nonatomic) IBOutlet UIButton *btnBookNow;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@property (weak, nonatomic) IBOutlet UICollectionView *datecollectionView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong) NSString *entityIDString;
@property (nonatomic, strong) NSString *headingString;
@property (nonatomic, assign) BOOL isfromClinic;
@property (nonatomic, strong) NSString *profileImageUrlString;
@property (nonatomic, strong) id locationDetails;
@property (weak, nonatomic) IBOutlet UIView *noResultsView;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@end
