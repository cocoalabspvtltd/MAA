//
//  CountriesVC.m
//  MAA
//
//  Created by Cocoalabs India on 03/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#define CellIdentifier @"cellIdentifier"
#import "CountriesVC.h"

@interface CountriesVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, assign) int limit;
@property (nonatomic, assign) int offset;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSMutableArray *locationsMutableArray;
@property (nonatomic, assign) BOOL isSearchTextChanged;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@end

@implementation CountriesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.limit = 10;
    self.offset = 0;
    self.searchText = @"";
    self.isSearchTextChanged = NO;
    self.locationsMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self callingGetLocationssApi];
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

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = searchText;
    self.offset = 0;
    self.isSearchTextChanged = YES;
    [self callingGetLocationssApi];
}

#pragma mark - Get Locations Api

-(void)callingGetLocationssApi{
    NSString *getLocationsApiUrlString = [Baseurl stringByAppendingString:GetLocationsUrl];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getLocationsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getLocationsMutableDictionary setValue:accessToken forKey:@"token"];
//    [getLocationsMutableDictionary setValue:[NSNumber numberWithInt:self.limit] forKey:@"limit"];
//    [getLocationsMutableDictionary setValue:[NSNumber numberWithInt:self.offset] forKey:@"offset"];
    [getLocationsMutableDictionary setValue:self.searchText forKey:@"keyword"];
    [getLocationsMutableDictionary setValue:self.searchType forKey:@"type"];
    [getLocationsMutableDictionary setValue:self.parentLoationID forKey:@"parent_location_id"];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getLocationsApiUrlString] withBody:getLocationsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [self.bottomProgressIndicatorView stopAnimating];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(self.isSearchTextChanged){
            [self.locationsMutableArray removeAllObjects];
        }
        NSArray *locationsArray = [responseObject valueForKey:Datakey];
        [self.locationsMutableArray addObjectsFromArray:locationsArray];
        [self.locationsTableView reloadData];
        if(!(locationsArray.count<self.limit)){
            self.offset = self.offset + self.limit;
        }
        NSLog(@"Response :%@",responseObject);
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.bottomProgressIndicatorView stopAnimating];
        NSString *errorMessage;
        if([errorDescription isEqualToString:NoNetworkErrorName]){
            errorMessage = NoNetworkmessage;
        }
        else{
            errorMessage = ConnectiontoServerFailedMessage;
        }
        UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:AppName message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erroralert show];
        NSLog(@"Error :%@",errorResponse);
    }];
}

#pragma mark - Table View Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.locationsMutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [[self.locationsMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

#pragma mark - Table View Delegaye

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
    if(self.countriesDelegate &&[self.countriesDelegate respondsToSelector:@selector(selectedLocationWithDetails:)]){
        [self.countriesDelegate selectedLocationWithDetails:[self.locationsMutableArray objectAtIndex:indexPath.row]];
    }
}
#pragma mark - Scroll View Delegate

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if(scrollView == self.locationsTableView){
//        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
//        if (endScrolling >= scrollView.contentSize.height)
//        {
//            [self callingGetLocationssApi];
//            [self.bottomProgressIndicatorView startAnimating];
//        }
//        else{
//            [self.bottomProgressIndicatorView stopAnimating];
//        }
//    }
//}
@end
