//
//  AppointmentPageVC.h
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentPageVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *appointmentTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
