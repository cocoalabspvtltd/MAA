//
//  doctorReviewsViewController.m
//  MAA
//
//  Created by Kiran on 27/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "doctorReviewsViewController.h"
#import "student.h"

@interface doctorReviewsViewController ()
{
    
        UIViewController *SearchViewController;
    NSArray * doctorsArray;
    NSMutableArray *doctorsMutableArray;
    NSMutableArray *blu;
    NSInteger selectedIndex;
    NSString *formatedDate;
    NSString *doctor;
}
@property (nonatomic, strong) NSMutableArray *categoriesMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;

@end

@implementation doctorReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedIndex=-1;

    blu = [@[]mutableCopy];
    doctorsMutableArray = [@[]mutableCopy];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;

    self.offsetValue = 0;
    self.limitValue = 10;
    _type=@"for";
    _keyword=@"";
    _month = @"";
    _year = @"";
    _tablee.delegate=self;
    _tablee.dataSource=self;
    _searchBar.delegate=self;
   _token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6ImFkNTY5NDMzMTc2ZDg1N2M2ZjhlODZiYWIzMDU2ODdkYjlkYzY0M2EifQ.PYNadEyYkRDDLX9iMLD1mMZeIn9zZsKcof-ooS06HU8";
    
     doctor = [Baseurl stringByAppendingString:review_url];

    
    [self apiCall];
    
    }


-(void)apiCall{
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [searchMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [searchMutableDictionary setValue:self.type forKey:typekey];
    [searchMutableDictionary setValue:_keyword forKey:keywordkey];
    [searchMutableDictionary setValue:_month forKey:monthkey];
    [searchMutableDictionary setValue:_year forKey:yearkey];
    [searchMutableDictionary setValue:_token forKey:@"token"];
    
    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:doctor] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:_token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        doctorsArray = [responseObject valueForKey:@"data"];
        NSLog(@"%@jgvjmgcjgcjhjcjcgj",doctorsArray[0]);
        //  [doctorsMutableArray addObjectsFromArray:doctorsArray];
        for (NSDictionary *item in doctorsArray) {
            student *q = [[student alloc]init];
            q.patname = item[@"patient_name"];
            q.patReview = item[@"review"];
            q.datee = item[@"date"];
            q.rating = [item[@"rating"]integerValue];
            [blu addObject:q];
            
        }
        
        
        self.offsetValue=self.offsetValue+self.limitValue;
        
        NSLog(@"Response object:%@",responseObject);
        [_tablee reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // [self.bottomProgressIndicatorView stopAnimating];
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

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    if (searchText.length==0) {
//        isFiltered=NO;
//    }
//    else
//    {
//        isFiltered=YES;
//        filteredString = [[NSMutableArray alloc]init];
//        for (NSString *str in totalString) {
//            stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
//            
//            if (stringRange.location!=NSNotFound) {
//                [filteredString addObject:str];
//            }
//        }
//    }
//    [_tablee reloadData];
    
    [self callingSearchDoctorApiWithText:searchText];

}


    
    
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _tablee){
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







-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [blu count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDent = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDent];
    if (cell==nil) {
        [[NSBundle mainBundle]loadNibNamed:@"search" owner:self options:nil];
        cell=_celll;
        
    }
    //    student *s = [[student alloc]init];
    //    s = [bla objectAtIndex:0];
    //
    
    //  _doctor_name.text = ;
    // _doctor_name.text = @"d vdfv";
    NSLog(@"%@",blu);
    student *kk = [[student alloc]init];
    kk = blu[indexPath.row];
    _doctorName = (UILabel*)[cell viewWithTag:10];

    _doctorName.text = kk.patname;
    _reviewContent = (UILabel*)[cell viewWithTag:20];
    _reviewContent.text = kk.patReview;
    
    _selected_date = (UILabel*)[cell viewWithTag:40];
    _selected_date.text = kk.datee;

    
    if (kk.rating ==1) {
        _s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-gray"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-gray"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-gray"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-gray"];
        
    }
    else if (kk.rating==1.5)
    {
        _s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-half"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-gray"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-gray"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-gray"];
    }
    else if (kk.rating==2)
    {
        _s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-blue"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-gray"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-gray"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-gray"];

    }
    else if (kk.rating==2.5)
    {_s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-blue"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-half"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-gray"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-gray"];
        
        
    }
    else if (kk.rating==3)
    {_s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-blue"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-blue"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-gray"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-gray"];
        

        
    }
    else if (kk.rating==3.5)
    {
        _s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-blue"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-blue"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-half"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-gray"];
        

    }
    else if (kk.rating==4)
    { _s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-blue"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-blue"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-blue"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-gray"];

        
    }
    else if (kk.rating==4.5)
    {
        _s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-blue"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-blue"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-blue"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-half"];
        

        
    }
    else if (kk.rating==5)
    {
        _s1 = (UIImageView*)[cell viewWithTag:1];
        _s1.image = [UIImage imageNamed:@"star-blue"];
        _s2 = (UIImageView*)[cell viewWithTag:2];
        _s2.image = [UIImage imageNamed:@"star-blue"];
        _s3 = (UIImageView*)[cell viewWithTag:3];
        _s3.image = [UIImage imageNamed:@"star-blue"];
        _s4 = (UIImageView*)[cell viewWithTag:4];
        _s4.image = [UIImage imageNamed:@"star-blue"];
        _s5 = (UIImageView*)[cell viewWithTag:5];
        _s5.image = [UIImage imageNamed:@"star-blue"];
        

        
    }
    
    
    return cell;
    
    
    
    
    
    
    
    

}







-(void)callingSearchDoctorApiWithText:(NSString *)searchDoctorText{
    blu = [@[]mutableCopy];
    doctorsMutableArray = [@[]mutableCopy];
    
    self.offsetValue = 0;
    self.limitValue = 10;
    _type=@"for";
    _keyword=@"";
    _month = @"";
    _year = @"";
    _tablee.delegate=self;
    _tablee.dataSource=self;
    _searchBar.delegate=self;
    totalString = [[NSMutableArray alloc] initWithObjects:@"shoes",@"formal",@"apple",@"american tourister",@"adidas",@"alarm",@"african snake",@"ball",@"baseball",@"bakardi",@"balarama",@"books",@"cigerets",@"camara",@"cd",@"crayons", nil];
    
    
    _token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6ImFkNTY5NDMzMTc2ZDg1N2M2ZjhlODZiYWIzMDU2ODdkYjlkYzY0M2EifQ.PYNadEyYkRDDLX9iMLD1mMZeIn9zZsKcof-ooS06HU8";
    
    NSString *doctor = [Baseurl stringByAppendingString:review_url];
    
    
    
    
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [searchMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [searchMutableDictionary setValue:self.type forKey:typekey];
    [searchMutableDictionary setValue:searchDoctorText forKey:keywordkey];
    [searchMutableDictionary setValue:_month forKey:monthkey];
    [searchMutableDictionary setValue:_year forKey:yearkey];
    [searchMutableDictionary setValue:_token forKey:@"token"];
    
    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:doctor] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:_token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        doctorsArray = [responseObject valueForKey:@"data"];
        NSLog(@"%@jgvjmgcjgcjhjcjcgj",doctorsArray[0]);
        //  [doctorsMutableArray addObjectsFromArray:doctorsArray];
        for (NSDictionary *item in doctorsArray) {
            student *q = [[student alloc]init];
            q.patname = item[@"patient_name"];
            q.patReview = item[@"review"];

            [blu addObject:q];
            
        }
        
        
        self.offsetValue=self.offsetValue+self.limitValue;
        
        //        [self.bottomProgressIndicatorView stopAnimating];
        //        [doctorsMutableArray addObjectsFromArray:doctorsArray];
        //        NSPredicate *onlineDoctorsPredicate = [NSPredicate predicateWithFormat:@"SELF.is_online == %@",@"1"];
        //        self.onlineDoctorsArray = [self.doctorsMutableArray filteredArrayUsingPredicate:onlineDoctorsPredicate];
        //        [tableViewSearchResults reloadData];
        NSLog(@"Response object:%@",responseObject);
        [_tablee reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // [self.bottomProgressIndicatorView stopAnimating];
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectedIndex ==indexPath.row) {
        return 200;
    }
    else
        return 120;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  selectedIndex = indexPath.row;
    if (selectedIndex==indexPath.row) {
        selectedIndex=-1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (selectedIndex!=-1) {
        NSIndexPath *prev = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prev] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}








//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//    
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//
//{
//    if (isFiltered) {
//        return [filteredString count];
//        
//    }
//    return [totalString count];
//    
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIDent = @"cellIdentifierrrr";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDent];
//    if (cell==nil) {
//        [[NSBundle mainBundle]loadNibNamed:@"search" owner:self options:nil];
//        cell=_celll;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    if (!isFiltered) {
//        
//        _doctorName = (UILabel*)[cell viewWithTag:10];
//        _doctorName.text = totalString[indexPath.row];
//    }
//    else{
//        
//        _doctorName = (UILabel*)[cell viewWithTag:10];
//        _doctorName.text = filteredString[indexPath.row];
//    }
//    return cell;
//    
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"seggruss" sender:nil];
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)picker_action:(id)sender {
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    [dateFormatter setDateFormat:@"mm-dd-yyyy"];
//    
//    formatedDate = [dateFormatter stringFromDate:self.date_picker.date];
//    
//    self.selected_date.text =formatedDate;
    
//
    
    
    
    
    NSDate *dateFromPicker = [_date_picker date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components: unitFlags fromDate: dateFromPicker];
    int year = [components year];
    int month = [components month];
    
    
    self.offsetValue = 0;
    self.limitValue = 10;
    _type=@"for";
    _keyword=@"";
    _tablee.delegate=self;
    _tablee.dataSource=self;
    _searchBar.delegate=self;

//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"dd-mm-yyyy"];
//    NSLog(@"%@",dateFormat);
//    [dateFormat setDateFormat:@"yyyy"];
//    int year = [[dateFormat stringFromDate:[NSDate date]] intValue];
//    [dateFormat setDateFormat:@"MM"];
//    int month = [[dateFormat stringFromDate:[NSDate date]] intValue];
//    NSLog(@"%dyear is ",year);
//    NSLog(@"%dmonth is ",month);
//    NSLog(@"%d",month);
//
    
    _token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6ImFkNTY5NDMzMTc2ZDg1N2M2ZjhlODZiYWIzMDU2ODdkYjlkYzY0M2EifQ.PYNadEyYkRDDLX9iMLD1mMZeIn9zZsKcof-ooS06HU8";
    
    NSString *doctor = [Baseurl stringByAppendingString:review_url];
    
    
  
    
    NSMutableDictionary *searchMutableDictionary = [[NSMutableDictionary alloc] init];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [searchMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [searchMutableDictionary setValue:self.type forKey:typekey];
    [searchMutableDictionary setValue:_keyword forKey:keywordkey];
    [searchMutableDictionary setValue:_token forKey:@"token"];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:month] forKey:monthkey];
    [searchMutableDictionary  setValue:[NSNumber numberWithInt:year] forKey:yearkey];

    NSLog(@"Search Mutable Dictionary:%@",searchMutableDictionary);
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:doctor] withBody:searchMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:_token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        doctorsArray = [responseObject valueForKey:@"data"];
        NSLog(@"%@jgvjmgcjgcjhjcjcgj",month);
        //  [doctorsMutableArray addObjectsFromArray:doctorsArray];
        for (NSDictionary *item in doctorsArray) {
            student *q = [[student alloc]init];
            q.patname = item[@"patient_name"];
            q.patReview = item[@"review"];
            [blu addObject:q];
            
        }
        
        
        self.offsetValue=self.offsetValue+self.limitValue;
        
        //        [self.bottomProgressIndicatorView stopAnimating];
        //        [doctorsMutableArray addObjectsFromArray:doctorsArray];
        //        NSPredicate *onlineDoctorsPredicate = [NSPredicate predicateWithFormat:@"SELF.is_online == %@",@"1"];
        //        self.onlineDoctorsArray = [self.doctorsMutableArray filteredArrayUsingPredicate:onlineDoctorsPredicate];
        //        [tableViewSearchResults reloadData];
        NSLog(@"Response object:%@",responseObject);
        [_tablee reloadData];
    } FailureBlock:^(NSString *errorDescription, id errorResponse) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // [self.bottomProgressIndicatorView stopAnimating];
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
