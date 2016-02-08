//
//  Appoinments.m
//  maa.stroyboard
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoalabs India. All rights reserved.
//

#define AppointmentTableViewCellIdentifier @"appointmentCell"
#import "AppoinmentsDocs.h"
#import "AppointmentTableViewCell.h"

@interface Appoinments ()<UIPickerViewDelegate,UIPickerViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>
{
    NSArray *DDL;
    UILabel *name;

}
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSString *searchTextString;
@property (nonatomic, strong) NSArray *appointmentDoctorsArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, strong) NSMutableArray *appointmentDoctorsMutableArray;

@end
NSString *flag=0;

@implementation Appoinments

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ChildView.hidden=YES;
    self.FromDate.hidden=YES;
    self.Todate.hidden=YES;
    self.btnSelectD.hidden=YES;
    self.tblDropList.hidden=YES;
    _tblAppoinments.dataSource=self;
    _tblAppoinments.delegate=self;
    [self initialisation];
    [self addSubViews];
    
    DDL=@[@"Any",@"Audio Call",@"Video Call",@"Direct Appoinment",@"Chat"];
    
    [self.tblAppoinments registerNib:[UINib nibWithNibName:@"ViewAppoin" bundle:nil] forCellReuseIdentifier:AppointmentTableViewCellIdentifier];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.offsetValue = 0;
    self.limitValue = 10;
    self.searchBar.delegate = self;
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.appointmentDoctorsMutableArray = [[NSMutableArray alloc] init];
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
    if (tableView==_tblDropList)
    {
        return DDL.count;

    }
    else if (tableView==_tblAppoinments)
    {
        return  4;
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
        return cell;
    }
    else{
        static NSString *TableIdentifier=@"TableItem";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
        }
        if (tableView==_tblDropList)
        {
            
            
            cell.textLabel.text=[DDL objectAtIndex:indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:(11.0)];
            
        }
        return cell;
    }
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *x = DDL[indexPath.row];
    [_btnDropDown setTitle:x forState:UIControlStateNormal];
    
}

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.appointmentDoctorsMutableArray removeAllObjects];
    self.offsetValue = 0;
    [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:searchText];
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
    if (self.ChildView.hidden==YES)
    {
        self.ChildView.hidden=NO;
        
        
        
    }
    else
    {
        self.ChildView.hidden=YES;
        //[self adjustHeightOfTableview];
    }
   // [self adjustHeightOfTableview];
}
- (IBAction)To:(id)sender
{
    if (self.Todate.hidden==YES)
    {
        self.Todate.hidden=NO;
        self.btnSelectD.hidden=NO;
        self.FromDate.hidden=YES;
    }
    else
    {
        self.Todate.hidden=YES;
        self.btnSelectD.hidden=YES;
        self.FromDate.hidden=YES;
        
    }
}

- (IBAction)From:(id)sender
{
    if (self.FromDate.hidden==YES)
    {
        self.FromDate.hidden=NO;
        self.btnSelectD.hidden=NO;
        self.Todate.hidden=YES;
        
    }
    else
    {
        self.FromDate.hidden=YES;
        self.btnSelectD.hidden=YES;
        self.Todate.hidden=YES;
       
    }
}

- (IBAction)SelectDate:(id)sender
{
    
}
- (IBAction)DropDown:(id)sender
{
    if (_tblDropList.hidden==YES) {
        _tblDropList.hidden=NO;
    }
    else
        _tblDropList.hidden=YES;
}

#pragma mark - Calling Search Doctor Names Api


-(void)getSearchDoctorNamesForAppointmentesApiCallWithSearchText:(NSString *)keywordText{
    self.searchTextString = keywordText;
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSLog(@"Access Token:%@",accessToken);
    NSString *getDoctorsAppointmentsUrlString = [Baseurl stringByAppendingString:GetDoctorsAppointmentesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:keywordText forKey:@"keyword"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    NSLog(@"Get Sub categories mutable Dictionary:%@",getSubcategoriesMutableDictionary);
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getDoctorsAppointmentsUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        NSLog(@"Response Object;%@",responseObject);
        self.appointmentDoctorsArray = [responseObject valueForKey:Datakey];
        self.offsetValue=self.offsetValue+self.limitValue;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.bottomProgressIndicatorView stopAnimating];
        [self.appointmentDoctorsMutableArray addObjectsFromArray:self.appointmentDoctorsArray];
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
            [self getSearchDoctorNamesForAppointmentesApiCallWithSearchText:self.searchTextString];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}

@end
