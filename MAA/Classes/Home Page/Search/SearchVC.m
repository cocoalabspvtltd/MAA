//
//  SearchVC.m
//  MAA
//
//  Created by Roshith on 11/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "SearchVC.h"
#import "SearchTVC.h"
#import "SearchResultsVC.h"

@interface SearchVC ()

@end

@implementation SearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableViewSearch.estimatedRowHeight = 44.0;
    tableViewSearch.rowHeight = UITableViewAutomaticDimension;
    
    [self loadArrayData];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void) loadArrayData
{
    dictionaryArrayData = [[NSMutableDictionary alloc] init];
    
    dictionaryArrayData[@"Speciality"] = @"Asthma Specialist";
    dictionaryArrayData[@"Tag"] = @"Specialist";
    
    arraySearchListing = [[NSMutableArray alloc]initWithObjects:dictionaryArrayData, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate & Data Source methods.


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTVC *cell = [tableViewSearch dequeueReusableCellWithIdentifier:@"cellIdentifierSearch"forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.labelTitle.text = [[arraySearchListing objectAtIndex:indexPath.row]valueForKey:@"Speciality"];
    cell.labelDescription.text = [[arraySearchListing objectAtIndex:indexPath.row]valueForKey:@"Tag"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultsVC *searchResults = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsController"];
    [self.navigationController pushViewController:searchResults animated:YES];
}


@end
