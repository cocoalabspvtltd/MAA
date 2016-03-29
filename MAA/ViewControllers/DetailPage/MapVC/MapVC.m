//
//  LocationVC.m
//  MAA
//
//  Created by Cocoalabs India on 29/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "MapVC.h"

@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self plottingLocation];
    // Do any additional setup after loading the view.
}

-(void)plottingLocation{
    self.latitude = 13.04016;
    self.longitude = 80.243044;
    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=self.latitude;
    myCoordinate.longitude=self.longitude;
    annotation.coordinate = myCoordinate;
    annotation.title = @"My location";
    [self.locationMapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
