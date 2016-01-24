//
//  QuestionsPageVC.m
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import "QuestionsTVC.h"
#import "QuestionsPageVC.h"

@interface QuestionsPageVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSArray *questionsArray;
@property (nonatomic, strong) NSMutableArray *questionsMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@end

@implementation QuestionsPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    self.searchbar.delegate = self;
    [self addSubViews];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.searchText = @"";
    self.questionsMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)addSubViews{
    [self.view addSubview:self.bottomProgressIndicatorView];
}

-(void)viewWillLayoutSubviews{
    self.bottomProgressIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 5, self.view.frame.size.height - 20, 10, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search bar delegates

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchText = searchText;
    [self.questionsMutableArray removeAllObjects];
    [self callingGetQuestionsWithText:searchText];
}

#pragma mark - Table View Datasources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.self.questionsMutableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"questionsCell"forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"answeree_name"];
    cell.questionLabel.text = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    if(!([[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"answer"]  == [NSNull null]) ){
        cell.answerLabel.text = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"answer"];
    }
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor"];
    UIImage *localImage;
    NSString *cacheIdentifier = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"answeree_id"];
    NSString *profileImageUrlString = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"answeree_image"];
    localImage = [[ImageCache sharedCache] imageFromFolder:folderPath WithIdentifier:cacheIdentifier];
    if(!localImage){
        [MBProgressHUD showHUDAddedTo:cell.profileImageView animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrlString]];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:cacheIdentifier];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.profileImageView.image = tempImage;
                [MBProgressHUD hideAllHUDsForView:cell.profileImageView animated:YES];
            }
                           );
        });
    }
    else{
        cell.profileImageView.image = localImage;
    }

    
    return cell;
}
#pragma mark - Search Bar Api's

-(void)callingGetQuestionsWithText:(NSString *)getQuestionsText{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *getQuestionsMutableDictionary = [[NSMutableDictionary alloc] init];
    [getQuestionsMutableDictionary setValue:getQuestionsText forKey:@"keyword"];
    [getQuestionsMutableDictionary setValue:accessToken forKey:@"token"];
    [getQuestionsMutableDictionary setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getQuestionsMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    NSString *getQuestionsUrlString = [Baseurl stringByAppendingString:GetQuestionsApiUrl];
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getQuestionsUrlString] withBody:getQuestionsMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accessToken];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.questionsArray = [responseObject valueForKey:Datakey];
        [self.questionsMutableArray addObjectsFromArray:self.questionsArray];
        self.offsetValue=self.offsetValue+self.limitValue;
        [self.questionsTableView reloadData];
        [self.bottomProgressIndicatorView stopAnimating];
        NSLog(@"Response Object:%@",responseObject);
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
    if(scrollView == self.questionsTableView){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self callingGetQuestionsWithText:self.searchText];
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
