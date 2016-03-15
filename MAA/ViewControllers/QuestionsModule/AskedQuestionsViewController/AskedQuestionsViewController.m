//
//  AskedQuestionsViewController.m
//  MAA
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define AskedQuestionsTableViewCell @"askedQuestionsCell"

#import "FilterVC.h"
#import "QuestionsSDetailVC.h"
#import "AskedQuestionsViewController.h"

@interface AskedQuestionsViewController ()<UISearchBarDelegate,UIScrollViewDelegate,FilterVCDelegate>
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSArray *questionsArray;
@property (nonatomic, strong) NSMutableArray *questionsMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, assign) BOOL isTextSearchValueChanged;
@property (nonatomic, strong) NSString *selectedfromDateString;
@property (nonatomic, strong) NSString *selectedToDateString;
@property (nonatomic, strong) NSString *selectedSubCategoryIdString;
@property (nonatomic, strong) NSString *selectedQuestiontype;
@end

@implementation AskedQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self addSubViews];
    self.floatimage.layer.cornerRadius = self.floatimage.frame.size.width / 2;
    self.floatimage.clipsToBounds = YES;
    [self.tblquestions registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:AskedQuestionsTableViewCell];
    // Do any additional setup after loading the view.
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if(tabBarController.selectedIndex == 3){
       [self initialisingApiParameters];
    }
}

-(void)initialisation{
    self.searchText = @"";
    self.selectedfromDateString = @"";
    self.selectedToDateString = @"";
    self.selectedSubCategoryIdString = @"";
    self.selectedQuestiontype = @"0";
    [self initialisingApiParameters];
    self.questionsMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    //[self addingGesturerecognizerToView];
}

-(void)addingGesturerecognizerToView{
    UITapGestureRecognizer *tapgetureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    tapgetureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapgetureRecognizer];
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tapgesture{
    [self.view endEditing:YES];
}

-(void)initialisingApiParameters{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.isTextSearchValueChanged = NO;
    [self.questionsMutableArray removeAllObjects];
    [self callingGetQuestionsWithText:self.searchText andFromDate:self.selectedfromDateString andToString:self.selectedToDateString andFilterId:self.selectedQuestiontype andSelectedCategoryIdString:self.selectedSubCategoryIdString];
}

-(void)addSubViews{
    [self.view addSubview:self.bottomProgressIndicatorView];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    if ([aScrollView isEqual:self.tblquestions])
    {
        self.floatbutton.transform = CGAffineTransformMakeTranslation(0, aScrollView.contentOffset.x);
        self.floatimage.transform= CGAffineTransformMakeTranslation(0, aScrollView.contentOffset.x);
    }
}

-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.questionsMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    AskedQuestionsTVC *cell = [tableView dequeueReusableCellWithIdentifier:AskedQuestionsTableViewCell forIndexPath:indexPath];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        cell = (AskedQuestionsTVC *)[nib objectAtIndex:0];
    }
    
    if(!([[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"title"]  == [NSNull null])){
        cell.questionLabel.text = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    }
    if(!([[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"description"]  == [NSNull null]) ){
        cell.descriptionLabel.text = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    }
    if(!([[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"question_timestamp"]  == [NSNull null]) ){
        cell.dateLabel.text = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"question_timestamp"];
    }
    NSString *imageViewUrlString = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"cat_logo"];
    [cell.profileImageView sd_setImageWithURL:[NSURL URLWithString:imageViewUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QuestionsSDetailVC *questiosDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"QuestionsSDetailVC"];
    questiosDetailVC.questionId = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"que_id"];
    [self.navigationController pushViewController:questiosDetailVC animated:YES];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = searchText;
    self.offsetValue = 0;
    self.isTextSearchValueChanged = YES;
    [self.questionsMutableArray removeAllObjects];
    [self callingGetQuestionsWithText:searchText andFromDate:self.selectedfromDateString andToString:self.selectedToDateString andFilterId:self.selectedQuestiontype andSelectedCategoryIdString:self.selectedSubCategoryIdString];
}

#pragma mark - Search Bar Api's

-(void)callingGetQuestionsWithText:(NSString *)getQuestionsText andFromDate:(NSString *)fromDateString andToString:(NSString *)toDateString andFilterId:(NSString *)filterIdString andSelectedCategoryIdString:(NSString *)categoryIdString{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getQuestionsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getQuestionsMutableDictionary setValue:getQuestionsText forKey:@"keyword"];
     [getQuestionsMutableDictionary setValue:categoryIdString forKey:@"cat_id"];
    [getQuestionsMutableDictionary setValue:accessToken forKey:@"token"];
    [getQuestionsMutableDictionary setValue:filterIdString forKey:@"filter"];
    [getQuestionsMutableDictionary setValue:fromDateString forKey:@"date1"];
    [getQuestionsMutableDictionary setValue:toDateString forKey:@"date2"];
    [getQuestionsMutableDictionary setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getQuestionsMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    NSLog(@"getQuestionsMutableString:%@",getQuestionsMutableDictionary);
    NSString *getQuestionsUrlString = [Baseurl stringByAppendingString:GetQuestionsApiUrl];
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getQuestionsUrlString] withBody:getQuestionsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response object:%@",responseObject);
        if(self.isTextSearchValueChanged){
            [self.questionsMutableArray removeAllObjects];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.questionsArray = [responseObject valueForKey:Datakey];
        [self.questionsMutableArray addObjectsFromArray:self.questionsArray];
        self.offsetValue=self.offsetValue+self.limitValue;
        [self.tblquestions reloadData];
        [self.bottomProgressIndicatorView stopAnimating];
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

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.tblquestions){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            self.isTextSearchValueChanged = NO;
            [self callingGetQuestionsWithText:self.searchText andFromDate:self.selectedfromDateString andToString:self.selectedToDateString andFilterId:self.selectedQuestiontype andSelectedCategoryIdString:self.selectedSubCategoryIdString];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}
- (IBAction)filterButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FilterVC *questionsFilterVC = [storyboard instantiateViewControllerWithIdentifier:@"FilterVC"];
    questionsFilterVC.filterVCDelegate = self;
    questionsFilterVC.isFromAppointment = NO;
    [self presentViewController:questionsFilterVC animated:YES completion:nil];
}

-(void)submitButtonActionWithQuestionCategoryid:(NSString *)questionsCategoryId FromDate:(NSString *)fromDate andToDate:(NSString *)toDate andType:(NSString *)type{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.isTextSearchValueChanged = NO;
    [self.questionsMutableArray removeAllObjects];
    self.selectedSubCategoryIdString = questionsCategoryId;
    self.selectedfromDateString  = fromDate;
    self.selectedToDateString = toDate;
    self.selectedQuestiontype = type;
    [self callingGetQuestionsWithText:self.searchText andFromDate:fromDate andToString:toDate andFilterId:type andSelectedCategoryIdString:questionsCategoryId];
    
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
