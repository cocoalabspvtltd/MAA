//
//  DoctorServicesHV.h
//  MAA
//
//  Created by kiran on 26/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DoctorServicesDelegate;
@interface DoctorServicesHV : UITableViewHeaderFooterView
@property (strong, nonatomic) IBOutlet UIButton *doctorServicesHVButton;
@property (nonatomic, assign) id<DoctorServicesDelegate>doctorServicesDelegate;
@end
@protocol  DoctorServicesDelegate <NSObject>

-(void)headerButtonClickWithTag:(NSUInteger)headerTag;

@end