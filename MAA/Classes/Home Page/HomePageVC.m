//
//  HomePageVC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "HomePageVC.h"
#import <QuartzCore/QuartzCore.h>
#import "HomePageCVC.h"
#import "SearchResultsVC.h"

@interface HomePageVC ()

@end

@implementation HomePageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrayHomePageListing = [[NSArray alloc]initWithObjects:@"Audiologist", @"Alergist", @"Cardiologist", @"Dentist", @"Endocrinologist", @"Gynecologist", @"Neonatologist", @"Neurologist", @"Pediatrician", @"Physiologist", @"Plastic Surgeon", @"Surgeon", @"Endocrinologist", @"Alergist", @"Cardiologist", @"Dentist", @"Endocrinologist", @"Gynecologist", @"Neonatologist", @"Neurologist", nil];
    
    arrayHomePageListingImages = [[NSArray alloc]initWithObjects:@"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController setTitle:@"Top Specialities"];
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:234.0f green:63.0f blue:64.0f alpha:1];
//    
//    self.tabBarController.tabBar.hidden = NO;
//    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self loadTabBar];
}

- (void)loadTabBar
{
//    UITabBar *tabBar = self.tabBar;
//    
//    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
//    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
//    
//    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"search-icon"] withFinishedUnselectedImage:[UIImage imageNamed:@"search-icon"]];
//    
//    
//    [item0 setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"tag-icon"] withFinishedUnselectedImage:[UIImage imageNamed:@"tag-icon"]];
//    [item1 setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"add-icon"] withFinishedUnselectedImage:[UIImage imageNamed:@"add-icon"]];
//    [item2 setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"profile-icon"] withFinishedUnselectedImage:[UIImage imageNamed:@"profile-icon"]];
//    [item3 setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    
//    self.selectedIndex=1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - UICollectionView methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayHomePageListing.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCVC *cell=[collectionViewHome dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.cellImageViewIcon.clipsToBounds = YES;
    cell.cellImageViewIcon.layer.cornerRadius = 30.00;
    cell.cellImageViewIcon.layer.masksToBounds = YES;
    
    [cell.cellImageViewIcon setImage:[UIImage imageNamed:[arrayHomePageListingImages objectAtIndex:indexPath.row]]];
    
    cell.cellLabelTitle.text = [NSString stringWithFormat:@"%@", [arrayHomePageListing objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultsVC *seachResults = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchController"];
    [self.navigationController pushViewController:seachResults animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
