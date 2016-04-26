//
//  doctorReviewsViewController.m
//  MAA
//
//  Created by Kiran on 27/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//
#import "student.h"
#import "SubmitReviewView.h"
#import "ReviewTableViewCell.h"
#import "InvoiceFilterViewController.h"
#import "doctorReviewsViewController.h"

@interface doctorReviewsViewController ()<InvoiceFilterVCDelegate,SubmitReviewDelegate>
{
    
        UIViewController *SearchViewController;
    NSMutableArray *reviewsMutableArray;
    NSString *formatedDate;
}
@property (nonatomic, strong) UIView *gradientView;
@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, assign) BOOL isSearchTextChanged;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) SubmitReviewView *submitReviewView;
@property (nonatomic, strong) NSMutableArray *categoriesMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;

@end

@implementation doctorReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex=-1;
    
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
    self.gradientView = [[UIView alloc] init];
    self.gradientView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.gradientView.hidden = YES;
}

-(void)addSubViews{
    [self.view addSubview:self.gradientView];
    [self.view addSubview:self.bottomProgressIndicatorView];
}

-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
    self.gradientView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
        NSLog(@"Response Object:%@",responseObject);
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
    CGFloat ratingFloat = [[[reviewsMutableArray objectAtIndex:indexPath.row] valueForKey:@"rating"] floatValue];
    cell.ratingString = [NSString stringWithFormat:@"%0.1f",ratingFloat];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            //insert your editAction here
                                            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Do you want to edit ?" preferredStyle:UIAlertControllerStyleActionSheet];
                                            
                                            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                            
                                                // Cancel button tappped.
                                                [self dismissViewControllerAnimated:YES completion:^{
                                                }];
                                            }]];
                                            
                                            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                                                [actionSheet dismissViewControllerAnimated:YES completion:nil];
                                                self.selectedIndex = indexPath.row;
                                                [self addingReviewView];
                                                // Distructive button tapped.
                                                //            [self dismissViewControllerAnimated:YES completion:^{
                                                //            }];
                                            }]];
                                            
                                            UIPopoverPresentationController *popPresenter = [actionSheet
                                                                                             popoverPresentationController];
                                            popPresenter.sourceView = self.view;
                                            CGRect frameRect = self.view.frame;
                                            frameRect.origin.y = self.view.frame.size.height/2 - 50;
                                            frameRect.size.height = 100;
                                            popPresenter.sourceRect = frameRect;
                                            popPresenter.permittedArrowDirections = 0;
                                            
                                            // Present action sheet.
                                            [self presentViewController:actionSheet animated:YES completion:nil];
                                            
                                        }];
    editAction.backgroundColor = [UIColor lightGrayColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        //insert your deleteAction here
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Do you want to Delete ?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            self.selectedIndex = indexPath.row;
            [self callingDeleteReviewApi];
            // Distructive button tapped.
            //            [self dismissViewControllerAnimated:YES completion:^{
            //            }];
        }]];
        UIPopoverPresentationController *popPresenter = [actionSheet
                                                         popoverPresentationController];
        popPresenter.sourceView = self.view;
        CGRect frameRect = self.view.frame;
        frameRect.origin.y = self.view.frame.size.height/2 - 50;
        frameRect.size.height = 100;
        popPresenter.sourceRect = frameRect;
        popPresenter.permittedArrowDirections = 0;
        
        // Present action sheet.
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
    return @[deleteAction,editAction];
}

#pragma mark - Adding Review view

-(void)addingReviewView{
    [self addingGradientView];
    self.submitReviewView = [[[NSBundle mainBundle]loadNibNamed:@"submitReviewView" owner:self options:nil]
                             firstObject];
    self.submitReviewView.submitReviewDelegate = self;
    NSLog(@"Selected Index:%ld",(long)self.selectedIndex);
    self.submitReviewView.reviewContent = [[reviewsMutableArray objectAtIndex:self.selectedIndex] valueForKey:@"review"];
    self.submitReviewView.ratingString = [[reviewsMutableArray objectAtIndex:self.selectedIndex] valueForKey:@"rating"];
    self.submitReviewView.isFromReviewEdit = YES;
    CGFloat xMargin = 20,yMargin = 50;
    self.submitReviewView.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
    [self.view addSubview:self.submitReviewView];
}

-(void)addingGradientView{
    self.gradientView.hidden = NO;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gradientViewGestureAction:)];
    self.gradientView.userInteractionEnabled = YES;
    [self.gradientView addGestureRecognizer:tapGestureRecognizer];
}

-(void)gradientViewGestureAction:(UITapGestureRecognizer *)tapGesture{
    self.gradientView.hidden = YES;
    [self.submitReviewView removeFromSuperview];
}

#pragma mark - Submit Review Delegate

-(void)submitButtonActionWithReviewContent:(NSString *)reviewContent andRating:(float)reting{
    [self callingSubmitReviewPaiWithReviewContent:reviewContent andRating:reting];
    
}

#pragma mark - Submit Review Api

-(void)callingSubmitReviewPaiWithReviewContent:(NSString *)reviewContent andRating:(float)rating{
    NSString *submitReviewUrlString = [Baseurl stringByAppendingString:Submit_review_url];
    NSString *accessTokenString  = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *submitReviewMutableDictionary = [[NSMutableDictionary alloc] init];
    [submitReviewMutableDictionary setValue:accessTokenString forKey:@"token"];
    [submitReviewMutableDictionary setValue:reviewContent forKey:@"review"];
    NSNumber *reviewRating = [NSNumber numberWithFloat:rating];
    [submitReviewMutableDictionary setValue:reviewRating forKey:@"rating"];
    [submitReviewMutableDictionary setValue:[[reviewsMutableArray objectAtIndex:self.selectedIndex] valueForKey:@"id"] forKey:@"id"];
    [submitReviewMutableDictionary setValue:[[reviewsMutableArray objectAtIndex:self.selectedIndex] valueForKey:@"treator_id"] forKey:@"entity_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"Submit Review Details:%@",submitReviewMutableDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:submitReviewUrlString] withBody:submitReviewMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessTokenString];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.gradientView.hidden = YES;
        [self.submitReviewView removeFromSuperview];
        self.offsetValue = 0;
        [reviewsMutableArray removeAllObjects];
        [self apiCall];
        [self callingAlertViewControllerWithString:@"Your review changed sucessfully."];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

#pragma mark - Calling  Delete Review Api

-(void)callingDeleteReviewApi{
    NSString *deleteReviewUrlString = [Baseurl stringByAppendingString:Delete_review_url];
    NSString *accessTokenString  = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *deleteReviewMutableDictionary = [[NSMutableDictionary alloc] init];
    [deleteReviewMutableDictionary setValue:accessTokenString forKey:@"token"];
    [deleteReviewMutableDictionary setValue:[[reviewsMutableArray objectAtIndex:self.selectedIndex] valueForKey:@"id"] forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:deleteReviewUrlString] withBody:deleteReviewMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessTokenString];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self alertViewControllerForDelete];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

#pragma mark - Adding Alert Controller

-(void)callingAlertViewControllerWithString:(NSString *)alertMessage{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:alertMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)alertViewControllerForDelete{
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:AppName
                               message:@"Your review deleted successfully"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   [reviewsMutableArray removeObjectAtIndex:self.selectedIndex];
                                                   [self.tablee reloadData];
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                   
                                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
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
