//
//  SearchFilterVC.m
//  MAA
//
//  Created by Roshith on 15/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "SearchFilterVC.h"

@interface SearchFilterVC ()

@end

@implementation SearchFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setLabelSize];
}

- (void)setLabelSize
{
    [labelSunday sizeToFit];
    [labelMonday sizeToFit];
    [labelTuesday sizeToFit];
    [labelWednesday sizeToFit];
    [labelThursday sizeToFit];
    [labelFriday sizeToFit];
    [labelSaturday sizeToFit];
}



@end
