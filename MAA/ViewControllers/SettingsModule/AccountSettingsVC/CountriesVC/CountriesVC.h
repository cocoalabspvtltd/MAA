//
//  CountriesVC.h
//  MAA
//
//  Created by Cocoalabs India on 03/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountriesVCDelegate;
@interface CountriesVC : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *locationsTableView;
@property (nonatomic, strong) NSString *searchType;
@property (nonatomic, strong) NSString *parentLoationID;
@property (nonatomic, assign) id<CountriesVCDelegate>countriesDelegate;
@end
@protocol CountriesVCDelegate <NSObject>

-(void)selectedLocationWithDetails:(id)locationDetails;

@end