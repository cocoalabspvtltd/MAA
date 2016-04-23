//
//  doctorReviewsViewController.m
//  MAA
//
//  Created by Kiran on 27/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#import "student.h"
#import "ReviewTableViewCell.h"
#import "InvoiceFilterViewController.h"
#import "doctorReviewsViewController.h"

@interface doctorReviewsViewController ()<InvoiceFilterVCDelegate>
{
    
        UIViewController *SearchViewController;
    NSMutableArray *reviewsMutableArray;
    NSInteger selectedIndex;
    NSString *formatedDate;
}
@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, assign) BOOL isSearchTextChanged;
@property (nonatomic, strong) NSMutableArray *categoriesMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;

@end

@implementation doctorReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedIndex=-1;
    
    _month = @"";
    _year = @"";
    _tablee.delegate=self;
    _tablee.dataSource=self;
    _searchBar.delegate=self;
    [self intialisation];
    [self addSubViews];
    [self apiCall];
}

-(void)intialisation{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.searchText  =@"";
    self.selectedYear = 0;
    self.selectedMonth = 0;
    self.isSearchTextChanged = NO;
    reviewsMutableArray = [@[]mutableCopy];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)addSubViews{
    [self.view addSubview:self.bottomProgressIndicatorView];
}

-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
}


#pragma mark - My Review Api

-(void)apiCall{
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSString *reviewUrlString = [Baseurl stringByAppendingString:review_url];
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary setValue:tokenString forKey:@"token"];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [searchMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [searchMutableDictionary setValue:@"by" forKey:typekey];
    [searchMutableDictionary setValue:self.searchText forKey:keywordkey];
    [searchMutableDictionary setValue:_month forKey:monthkey];
    [searchMutableDictionary setValue:_year forKey:yearkey];
    NSArray *yearArray = @[@"All",@"2016",@"2015",@"2014",@"2013",@"2012",@"2011",@"2010",@"2009"];
    if(self.selectedYear == 0){
        [searchMutableDictionary setValue:[NSNumber numberWithInt:-1] forKey:@"year"];
    }
    else{
        [searchMutableDictionary setValue:[yearArray objectAtIndex:self.selectedYear] forKey:@"year"];
    }
    if(self.selectedMonth == 0){
        [searchMutableDictionary setValue:[NSNumber numberWithInt:-1] forKey:@"month"];
    }
    else{
        [searchMutableDictionary setValue:[NSNumber numberWithInteger:self.selectedMonth] forKey:@"month"];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:reviewUrlString] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:tokenString];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSArray *reviewsArray = [responseObject valueForKey:@"data"];
        self.offsetValue = self.offsetValue+(int)reviewsArray.count;
        [self.bottomProgressIndicatorView stopAnimating];
        self.offsetValue=self.offsetValue+self.limitValue;
        if(self.isSearchTextChanged){
            [reviewsMutableArray removeAllObjects];
        }
        [reviewsMutableArray addObjectsFromArray:reviewsArray];
        [_tablee reloadData];
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
    }];

}
    
    // Do any additional setup after loading the view.

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.isSearchTextChanged = YES;
    self.searchText  = searchText;
    self.offsetValue = 0;
    [self apiCall];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}
    
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _tablee){
        self.isSearchTextChanged  = NO;
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self apiCall];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return reviewsMutableArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReviews"forIndexPath:indexPath];
    cell.profilImageurlString = [[reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"patient_image"];
    cell.reviewerNameLabel.text =[[reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"patient_name"];
    cell.reviewContentLabel.text = [[reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"review"];
    cell.dateString = [[reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.ratingString = [[reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"rating"];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - Button Actions

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)filterButtonAction:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InvoiceFilterViewController *invoiceFiltertVC = [storyboard instantiateViewControllerWithIdentifier:@"InvoiceFilterViewController"];
    invoiceFiltertVC.invoiceFilterDelegate = self;
    invoiceFiltertVC.yearSelectedIndex = self.selectedYear;
    invoiceFiltertVC.monthSelectedIndex = self.selectedMonth;
    [self presentViewController:invoiceFiltertVC animated:YES completion:nil];
}

#pragma mark - Invoice VC Delegate

-(void)submitButtonActionWithYearIndex:(NSInteger)yearSelectedIndex andMonthSelectedIndex:(NSInteger)monthSelectedIndex{
    self.offsetValue = 0;
    self.isSearchTextChanged = NO;
    [reviewsMutableArray removeAllObjects];
    self.selectedYear = yearSelectedIndex;
    self.selectedMonth = monthSelectedIndex;
    [self apiCall];
}
@end
