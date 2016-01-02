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

@interface SearchVC ()<UISearchBarDelegate>
@property (nonatomic, assign) BOOL isLocationSearch;
@property (nonatomic, strong) NSArray *locationArray;
@property (nonatomic, strong) NSArray *doctorsArray;
@end

@implementation SearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableViewSearch.estimatedRowHeight = 44.0;
    tableViewSearch.rowHeight = UITableViewAutomaticDimension;
    [self initialisation];
    [self loadArrayData];

}

-(void)initialisation{
    self.doctorSearchBar.delegate = self;
    self.locationSerchBar.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void) loadArrayData
{
    //dictionaryArrayData = [[NSMutableDictionary alloc] init];
    
   //dictionaryArrayData[@"Speciality"] = @"Asthma Specialist";
   // dictionaryArrayData[@"Tag"] = @"Specialist";
    
  //  arraySearchListing = [[NSMutableArray alloc]initWithObjects:dictionaryArrayData, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate & Data Source methods.


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isLocationSearch){
        return self.locationArray.count;
    }
    else{
        return self.doctorsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTVC *cell = [tableViewSearch dequeueReusableCellWithIdentifier:@"cellIdentifierSearch"forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.isLocationSearch){
        cell.labelTitle.text = [[self.locationArray objectAtIndex:indexPath.row] valueForKey:@"location"];
        cell.labelDescription.text = @"";
    }
    else{
        cell.labelTitle.text = [[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        cell.labelDescription.text = [[self.doctorsArray objectAtIndex:indexPath.row]valueForKey:@"type"];
    }
   // cell.labelTitle.text = [[arraySearchListing objectAtIndex:indexPath.row]valueForKey:@"Speciality"];
   // cell.labelDescription.text = [[arraySearchListing objectAtIndex:indexPath.row]valueForKey:@"Tag"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.doctorsArray
    if(self.isLocationSearch){
        
    }
    else{
        if([[[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"department"]){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchResultsVC *searchResults = [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsVC"];
            searchResults.departmentId = [[self.doctorsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
            [self.navigationController pushViewController:searchResults animated:YES];
        }
        else{
            
        }
        
    }
}

#pragma mark - Search bar delegates

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchBar == self.doctorSearchBar){
        self.isLocationSearch = NO;
        [self callingSearchDoctorApiWithText:searchText];
        
    }
    else if (searchBar == self.locationSerchBar){
        self.isLocationSearch = YES;
        [self callingSearchLocationApiWithText:searchText];
    }
    NSLog(@"Search text:%@",searchText);
//    if(searchText.length == 0)
//    {
//        _isFiltered = FALSE;
//    }
//    else{
//        self.searchField = [self.searchBar valueForKey:@"_searchField"];
//        self.searchField.textColor = [UIColor blackColor];
//        NSPredicate *resultPredicate=[NSPredicate predicateWithFormat:@"(SELF.searchItem contains[cd] %@)",searchText];
//        self.filteredTableData = [self.searchMutableArray filteredArrayUsingPredicate:resultPredicate];
//        NSLog(@"Predicated array %@", self.filteredTableData);
//        self.isFiltered = YES;
//        
//        
//        if (self.filteredTableData.count == 0) {
//            self.isEmtpy = YES;
//            self.searchField.textColor = [UIColor redColor];
//            [self.searchTableView reloadData];
//        }
//        
//    }
//    
  //  [self.searchTableView reloadData];
}

#pragma mark - Search Bar Api's

-(void)callingSearchDoctorApiWithText:(NSString *)searchDoctorText{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getDoctorListMutableDictionary = [[NSMutableDictionary alloc] init];
    [getDoctorListMutableDictionary setValue:searchDoctorText forKey:@"keyword"];
    [getDoctorListMutableDictionary setValue:accessToken forKey:@"token"];
    NSString *searchDoctorUrlString = [Baseurl stringByAppendingString:GetDoctorListApi];
    
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:searchDoctorUrlString] withBody:getDoctorListMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        self.doctorsArray = [responseObject valueForKey:Datakey];
        [tableViewSearch reloadData];
        NSLog(@"Respoinse object:%@",responseObject);
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSLog(@"Error Description:%@",errorResponse);
    }];
}

-(void)callingSearchLocationApiWithText:(NSString *)searchLocationText{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getLocationListMutableDictionary = [[NSMutableDictionary alloc] init];
    [getLocationListMutableDictionary setValue:searchLocationText forKey:@"keyword"];
    [getLocationListMutableDictionary setValue:accessToken forKey:@"token"];
    NSString *searchDoctorUrlString = [Baseurl stringByAppendingString:SearchDoctorsBasedOnLocationApi];
    
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:searchDoctorUrlString] withBody:getLocationListMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Data:%@",responseObject);
        self.locationArray = [responseObject valueForKey:Datakey];
        [tableViewSearch reloadData];
        NSLog(@"Respoinse object:%@",responseObject);
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:AppName message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
    }];

}

@end
