//
//  TimingsVC.h
//  MAA
//
//  Created by Kiran on 03/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimingsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *timingsTableView;
@property (nonatomic,assign) BOOL isFromClinic;
@property (nonatomic, strong) NSString *doctorNameString;
@property (nonatomic, strong) NSArray *timingsArray;
@end
