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
    [self addingLocationLabelText];
    // Do any additional setup after loading the view.
}

-(void)addingLocationLabelText{
    [self.locationLabel sizeToFit];
    NSString *myString = [NSString stringWithFormat:@"%@\n%@",self.locationString,self.locationDetailString];
    //Create mutable string from original one
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
    
    //Fing range of the string you want to change colour
    //If you need to change colour in more that one place just repeat it
    NSRange range = [myString rangeOfString:self.locationString];
    [attString addAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                NSFontAttributeName, [UIFont fontWithName:@"Times New Roman" size:25],
                NSForegroundColorAttributeName, [UIColor blueColor],
                nil] range:range];
    
    //Add it to the label - notice its not text property but it's attributeText
    self.locationLabel.attributedText = attString;
}

-(void)plottingLocation{
    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=self.latitude;
    myCoordinate.longitude=self.longitude;
    annotation.coordinate = myCoordinate;
    annotation.title = self.locationString;
    annotation.subtitle = self.locationDetailString;
    [self.locationMapView addAnnotation:annotation];
    
    CLLocationDistance distance = 1000;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(myCoordinate,
                                                                   distance,
                                                                   distance);
    MKCoordinateRegion adjusted_region = [self.locationMapView regionThatFits:region];
    [self.locationMapView setRegion:adjusted_region animated:YES];
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
