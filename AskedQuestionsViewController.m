//
//  AskedQuestionsViewController.m
//  MAA
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define AskedQuestionsTableViewCell @"askedQuestionsCell"
#import "AskedQuestionsViewController.h"

@interface AskedQuestionsViewController ()<UISearchBarDelegate,UIScrollViewDelegate>
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSArray *questionsArray;
@property (nonatomic, strong) NSMutableArray *questionsMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
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
   // NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor"];
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/QuestionImages"];
    UIImage *localImage;
    NSString *cacheIdentifier = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"que_id"];
    NSString *profileImageUrlString = [[self.questionsMutableArray objectAtIndex:indexPath.row] valueForKey:@"cat_logo"];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

{
    [self performSegueWithIdentifier:@"fwdSegue" sender:nil];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = searchText;
    [self.questionsMutableArray removeAllObjects];
    [self callingGetQuestionsWithText:searchText];
    NSLog(@"Search Text:%@",searchText);
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
        [self.tblquestions reloadData];
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
    if(scrollView == self.tblquestions){
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
