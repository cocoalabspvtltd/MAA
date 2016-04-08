//
//  TimingsVC.m
//  MAA
//
//  Created by Kiran on 03/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#define CellStartTag 200
#define TimingsTableViewCellIdentifier @"timingsCell"

#import "MapVC.h"
#import "TimingsVC.h"
#import "TimingsTableViewCell.h"

@interface TimingsVC ()<UITableViewDataSource,UITableViewDelegate,timingTabLeViewCellDelegate>
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;

@end

@implementation TimingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    NSLog(@"Entity Details:%@",self.timingsArray);
    // Do any additional setup after loading the view.
}

-(void)initialisation{
     [self.timingsTableView registerNib:[UINib nibWithNibName:@"timingsCell" bundle:nil] forCellReuseIdentifier:TimingsTableViewCellIdentifier];
    if(self.isFromClinic){
        
    }
    else{
        self.headingLabel.text = [NSString stringWithFormat:@"Dr.%@",self.doctorNameString];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view Data Sources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Timings Array:%@",self.timingsArray);
    return self.timingsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TimingsTableViewCellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"timingsCell" owner:self options:nil];
        cell = (TimingsTableViewCell *)[nib objectAtIndex:0];
    }
    cell.clinicNameLabel.text = [[self.timingsArray objectAtIndex:indexPath.row] valueForKey:@"clinic_name"];
    cell.locationLabel.text = [[[self.timingsArray objectAtIndex:indexPath.row] valueForKey:@"location"] valueForKey:@"address"];
    cell.phoneNumberLabel.text = [[self.timingsArray objectAtIndex:indexPath.row] valueForKey:@"phone"];
    cell.consultationFeeLabel.text = [NSString stringWithFormat:@"Rs %@ consultation fee",[[self.timingsArray objectAtIndex:indexPath.row] valueForKey:@"fee"]];
    cell.timingsArray =  [[self.timingsArray objectAtIndex:indexPath.row] valueForKey:@"timings"];
    cell.timingCellDelegate = self;
    cell.tag = CellStartTag+indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

#pragma mark - Timings Cell Delegate

-(void)directionButtonActionWithTag:(NSInteger)cellTag{
    NSLog(@"Tag:%ld",(long)cellTag);
    id clinicDetais = [self.timingsArray objectAtIndex:(cellTag - CellStartTag)];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapVC *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"MapVC"];
    mapVC.headingString = [clinicDetais valueForKey:@"clinic_name"];
    mapVC.locationString = [clinicDetais valueForKey:@"clinic_name"];
    mapVC.locationDetailString = [[clinicDetais valueForKey:@"location"] valueForKey:@"address"];
    mapVC.latitude = [[[clinicDetais valueForKey:@"location"] valueForKey:@"lat"] floatValue];
    mapVC.longitude = [[[clinicDetais valueForKey:@"location"] valueForKey:@"lng"] floatValue];;
    mapVC.latitude = 10.015861;
    mapVC.longitude = 76.341867;
    [self.navigationController pushViewController:mapVC animated:YES];
}

@end
