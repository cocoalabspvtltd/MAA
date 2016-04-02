//
//  LocationVC.h
//  MAA
//
//  Created by Cocoalabs India on 29/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapVC : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, strong) NSString *headingString;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) NSString *locationString;
@property (nonatomic, strong) NSString *locationDetailString;
@end
