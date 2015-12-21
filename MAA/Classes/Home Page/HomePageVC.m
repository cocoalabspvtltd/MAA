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

@interface HomePageVC ()<UIScrollViewDelegate>
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, strong) NSMutableArray *categoriesMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
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
    arrayHomePageListing = [[NSArray alloc]initWithObjects:@"Audiologist", @"Alergist", @"Cardiologist", @"Dentist", @"Endocrinologist", @"Gynecologist", @"Neonatologist", @"Neurologist", @"Pediatrician", @"Physiologist", @"Plastic Surgeon", @"Surgeon", @"Endocrinologist", @"Alergist", @"Cardiologist", @"Dentist", @"Endocrinologist", @"Gynecologist", @"Neonatologist", @"Neurologist", nil];
    
    arrayHomePageListingImages = [[NSArray alloc]initWithObjects:@"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", @"5", @"4", nil];
}

-(void)initialisation{
    self.offsetValue = 0;
    self.categoriesMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)addSubViews{
    [self.view addSubview:self.bottomProgressIndicatorView];
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
    NSLog(@"Coount:%lu",(unsigned long)self.categoriesMutableArray.count);
    return self.categoriesMutableArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCVC *cell=[collectionViewHome dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.cellImageViewIcon.clipsToBounds = YES;
    cell.cellImageViewIcon.layer.cornerRadius = 30.00;
    cell.cellImageViewIcon.layer.masksToBounds = YES;
    
    //[cell.cellImageViewIcon setImage:[UIImage imageNamed:[arrayHomePageListingImages objectAtIndex:indexPath.row]]];
    NSLog(@"Text:%@",[[self.categoriesMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"]);
    cell.cellLabelTitle.text = [[self.categoriesMutableArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    
    return cell;
}

#pragma mark - Get Categories api

-(void)getCategoriesApiCall{
    NSString *getCategoriesUrlString = [Baseurl stringByAppendingString:GetCategoriesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:@"" forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:@"" forKey:@"keyword"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:@"offset"];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:LimitValue] forKey:@"limit"];
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getCategoriesUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:nil];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        arrayHomePageListing = [responseObject valueForKey:Datakey];
        self.offsetValue++;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.categoriesMutableArray addObjectsFromArray:arrayHomePageListing];
        [collectionViewHome reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorMessage;
        self.offsetValue--;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == collectionViewHome){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
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
