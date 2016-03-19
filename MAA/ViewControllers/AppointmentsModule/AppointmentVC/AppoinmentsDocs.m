//
//  Appoinments.m
//  maa.stroyboard
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoalabs India. All rights reserved.
//

#define AppointmentTableViewCellIdentifier @"appointmentCell"

#import "FilterVC.h"
#import "AppoinmentsDocs.h"
#import "AppoinmentDetailVC.h"
#import "AppointmentTableViewCell.h"

@interface AppoinmentsDocs ()<UIPickerViewDelegate,UIPickerViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,FilterVCDelegate,UIGestureRecognizerDelegate,AppointmentDetailDelegate>
{
    NSArray *DDL;
    UILabel *name;

}
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSString *searchTextString;
@property (nonatomic, strong) NSArray *appointmentDoctorsArray;
@property (nonatomic, assign) BOOL isSearchtextChanged;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, strong) NSMutableArray *appointmentDoctorsMutableArray;
@property (nonatomic, strong) NSString *fromDateString;
@property (nonatomic, strong) NSString *toDateString;
@property (nonatomic, strong) NSString *appointmenttypeString;
@property (nonatomic, strong) NSString *appointmentStatusString;

@end
NSString *flag=0;

@implementation AppoinmentsDocs

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tblAppoinments.dataSource=self;
    _tblAppoinments.delegate=self;
    [self initialisation];
    [self addSubViews];
    [self addingTapGesture];
    DDL=@[@"Any",@"Audio Call",@"Video Call",@"Direct Appoinment",@"Chat"];
    
    [self.tblAppoinments registerNib:[UINib nibWithNibName:@"ViewAppoin" bundle:nil] forCellReuseIdentifier:AppointmentTableViewCellIdentifier];
    // Do any additional setup after loading the view.
}


-(void)addingTapGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapaction:)];
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
}

-(void)singleTapaction:(UITapGestureRecognizer *)tapGesture{
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.tblAppoinments]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}

-(void)initialisation{
    self.searchTextString = @"";
    self.fromDateString  =@"";
    self.toDateString  =@"";
    self.appointmenttypeString = @"0";
    self.appointmentStatusString = @"0";
    [self initialisingApiParameters];
    self.searchBar.delegate = self;
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.appointmentDoctorsMutableArray = [[NSMutableArray alloc] init];
   // [self  addingGesturerecognizerToView];
}

-(void)addingGesturerecognizerToView{
    UITapGestureRecognizer *tapgetureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    tapgetureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapgetureRecognizer];
}

-(void)tapGestureAction:(UITapGestureRecognizer *)tapgesture{
    [self.view endEditing:YES];
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if(tabBarController.selectedIndex == 2){
        [self initialisingApiParameters];
    }
}

-(void)initialisingApiParameters{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.isSearchtextChanged = NO;
    [self.appointmentDoctorsMutableArray removeAllObjects];
    [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:self.searchTextString andAppointmentType:self.appointmenttypeString andStatus:self.appointmentStatusString andFromDate:self.fromDateString andToDateString:self.toDateString];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView==_tblAppoinments)
    {
        return  self.appointmentDoctorsMutableArray.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblAppoinments){
        AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AppointmentTableViewCellIdentifier forIndexPath:indexPath];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ViewAppoin" owner:self options:nil];
            cell = (AppointmentTableViewCell *)[nib objectAtIndex:0];
        }
        cell.doctorNameLabel.text = [[[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"doctor_details"] valueForKey:@"name"];
        cell.feeLabel.text = [[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"consult_fee"];
        cell.rightprofileImageurlString = [[[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"doctor_details"] valueForKey:@"logo_image"];
        cell.timeStampString = [[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"timestamp"];
        cell.typeString = [[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"type"];
        cell.statusString = [[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"status"];
        return cell;
    }
    else
    {
        static NSString *TableIdentifier=@"TableItem";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
        }
        
        return cell;
    }
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblAppoinments){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
        
        AppoinmentDetailVC *appointmentDetailVC = (AppoinmentDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"AppoinmentDetailVC"];
        appointmentDetailVC.hidesBottomBarWhenPushed = YES;
        appointmentDetailVC.selectedIndex = indexPath.row;
        appointmentDetailVC.appointmentIdString = [[self.appointmentDoctorsMutableArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        appointmentDetailVC.appointmentDetailDelegate = self;
        [self.navigationController pushViewController:appointmentDetailVC animated:YES];
    }
    
    
}

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.isSearchtextChanged  = YES;
    [self.appointmentDoctorsMutableArray removeAllObjects];
    self.offsetValue = 0;
    self.searchTextString = searchText;
    [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:self.searchTextString andAppointmentType:self.appointmenttypeString andStatus:self.appointmentStatusString andFromDate:self.fromDateString andToDateString:self.toDateString];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)Filter:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FilterVC *appointmentFilterVC = [storyboard instantiateViewControllerWithIdentifier:@"AppointmentFilterVC"];
    appointmentFilterVC.filterVCDelegate = self;
    appointmentFilterVC.isFromAppointment = YES;
    [self presentViewController:appointmentFilterVC animated:YES completion:nil];
}

#pragma mark - Calling Search Doctor Names Api


-(void)getSearchDoctorNamesForAppointmentesApiCallWithSearchText:(NSString *)keywordText andAppointmentType:(NSString *)appointmentType andStatus:(NSString *)status andFromDate:(NSString *)fromDateString andToDateString:(NSString *)toDateString{
    self.searchTextString = keywordText;
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSLog(@"Access Token:%@",accessToken);
    NSString *getDoctorsAppointmentsUrlString = [Baseurl stringByAppendingString:GetUserAppointmentesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary setValue:appointmentType forKey:@"type"];
    [getSubcategoriesMutableDictionary  setValue:keywordText forKey:@"keyword"];
    [getSubcategoriesMutableDictionary setValue:status forKey:@"status"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [getSubcategoriesMutableDictionary setValue:fromDateString forKey:@"date1"];
    [getSubcategoriesMutableDictionary setValue:toDateString forKey:@"date2"];
    NSLog(@"Get Sub categories mutable Dictionary:%@",getSubcategoriesMutableDictionary);
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getDoctorsAppointmentsUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        if(self.isSearchtextChanged){
            [self.appointmentDoctorsMutableArray removeAllObjects];
        }
        self.appointmentDoctorsArray = [responseObject valueForKey:Datakey];
        self.offsetValue=self.offsetValue+self.limitValue;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.bottomProgressIndicatorView stopAnimating];
        [self.appointmentDoctorsMutableArray addObjectsFromArray:self.appointmentDoctorsArray];
        if(self.appointmentDoctorsMutableArray.count == 0){
            self.tblAppoinments.hidden = YES;
            self.noAppointmentsLabel.hidden = NO;
            self.noAppintmentsImageView.hidden  = NO;
        }
        else{
            self.tblAppoinments.hidden = NO;
            self.noAppointmentsLabel.hidden = YES;
            self.noAppintmentsImageView.hidden  = YES;
        }
        [self.tblAppoinments reloadData];
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

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.tblAppoinments){
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            self.isSearchtextChanged = NO;
            [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:self.searchTextString andAppointmentType:self.appointmenttypeString andStatus:self.appointmentStatusString andFromDate:self.fromDateString andToDateString:self.toDateString];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}

#pragma mark - Filter Delegate

-(void)submitButtonActionForAppointmentWithFromDate:(NSString *)fromDateString andToDateString:(NSString *)toDateString andAppointmenttype:(NSString *)appintmentType andStatus:(NSString *)statusString{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.isSearchtextChanged = NO;
    [self.appointmentDoctorsMutableArray removeAllObjects];
    self.fromDateString = fromDateString;
    self.toDateString = toDateString;
    self.appointmenttypeString = appintmentType;
    self.appointmentStatusString = statusString;
   [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:self.searchTextString andAppointmentType:appintmentType andStatus:statusString andFromDate:fromDateString andToDateString:toDateString];
}

#pragma mark - Appointment Detail Delegate
-(void)appointmentCencelledDelagateWithSelectedIndex:(NSInteger)selectedIndex{
    AppointmentTableViewCell *apointmentsCell = (AppointmentTableViewCell *)[self.tblAppoinments cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    apointmentsCell.leftStatusImageView.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1];
}


@end
