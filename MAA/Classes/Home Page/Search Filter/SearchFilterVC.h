//
//  SearchFilterVC.h
//  MAA
//
//  Created by Roshith on 15/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFilterVC : UIViewController

{
    IBOutlet UILabel *labelMonday, *labelTuesday, *labelWednesday, *labelThursday, *labelFriday, *labelSaturday, *labelSunday;
    
    __weak IBOutlet UIImageView *sundayImageView;
    __weak IBOutlet UIButton *sundayButton;
    __weak IBOutlet UIImageView *mondayImageView;
    __weak IBOutlet UIButton *mondaybutton;
    __weak IBOutlet UIImageView *tuesdayImageView;
    __weak IBOutlet UIButton *tuedayButton;
    __weak IBOutlet UIImageView *wednesdayImageView;
    __weak IBOutlet UIButton *wednesdayButton;
    __weak IBOutlet UIImageView *thursdayImageView;
    __weak IBOutlet UIButton *thursdayButton;
    __weak IBOutlet UIImageView *fridayImageView;
    __weak IBOutlet UIButton *fridayButton;
    __weak IBOutlet UIImageView *saturdayImageView;
    __weak IBOutlet UIButton *saturdayButton;
    __weak IBOutlet UIButton *maleButton;

    __weak IBOutlet UIButton *femaleButton;
    __weak IBOutlet UIButton *isOnlineButton;
}

@end
