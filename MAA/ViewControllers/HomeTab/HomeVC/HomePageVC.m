//
//  HomePageVC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "HomePageVC.h"
#import "DoctorProfileVC.h"
#import "SearchResultsVC.h"
#import <QuartzCore/QuartzCore.h>
#import "HomePageCVC.h"

@interface HomePageVC ()<UIScrollViewDelegate,UICollectionViewDelegate>
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSMutableArray *categoriesMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (readonly) OTConnection *otConnection;
@end

@implementation HomePageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    searchBar.backgroundColor = [UIColor clearColor];
    [self initialisation];
    [self addSubViews];
    [self getCategoriesApiCall];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)initialisation{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.categoriesMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)addSubViews{
    [self.view addSubview:self.bottomProgressIndicatorView];
}
- (void)viewWillAppear:(BOOL)animated
{
}

-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    searchBar.showsCancelButton = NO;
    [self.view endEditing:YES];
}

#pragma mark - Search bar Methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBarMain
{
    searchBar.showsCancelButton = YES;
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,40)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard:)];
    toolBar.items = @[barButtonDone];
    barButtonDone.tintColor=[UIColor blueColor];
    
    //    [searchBar addSubview:toolBar];
    searchBar.inputAccessoryView = toolBar;
}

-(void)dismissKeyboard:(id)sender
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBarMain
{
    searchBar.showsCancelButton = NO;
    
    searchBar.text = @"";
    
    [searchBar resignFirstResponder];
}


#pragma mark - UICollectionView methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categoriesMutableArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCVC *cell=[collectionViewHome dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.cellImageViewIcon.clipsToBounds = YES;
    cell.cellImageViewIcon.layer.cornerRadius = 30.00;
    cell.cellImageViewIcon.layer.masksToBounds = YES;
    cell.cellImageViewIcon.layer.borderColor = [UIColor redColor].CGColor;
    cell.cellImageViewIcon.layer.borderWidth = 1;
    cell.cellLabelTitle.text = [[self.categoriesMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSURL *imageUrl = [NSURL URLWithString:[[self.categoriesMutableArray objectAtIndex:indexPath.row] valueForKey:@"logo_image"]];
    [cell.cellImageViewIcon sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    return cell;
}

#pragma mark - Get Categories api

-(void)getCategoriesApiCall{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *getCategoriesUrlString = [Baseurl stringByAppendingString:GetCategoriesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:@"" forKey:@"keyword"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getCategoriesUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object:%@",responseObject);
        arrayHomePageListing = [responseObject valueForKey:Datakey];
        self.offsetValue=self.offsetValue+self.limitValue;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.bottomProgressIndicatorView stopAnimating];
        [self.categoriesMutableArray addObjectsFromArray:arrayHomePageListing];
        [collectionViewHome reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [self.bottomProgressIndicatorView stopAnimating];
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SearchResultsVC *searchResultVC = (SearchResultsVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchResultsVC"];
        searchResultVC.departmentId = [[self.categoriesMutableArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        searchResultVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchResultVC animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == collectionViewHome){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self getCategoriesApiCall];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
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
