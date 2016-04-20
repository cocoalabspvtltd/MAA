//
//  InvoiceViewController.m
//  MAA
//
//  Created by Kiran on 20/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "Invoicepopup.h"
#import "InvoiceTableViewCell.h"
#import "InvoiceFilterViewController.h"
#import "InvoiceViewController.h"

@interface InvoiceViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,InvoiceFilterVCDelegate>
@property (nonatomic, assign) int offsetValue;
@property (nonatomic, assign) int limitValue;
@property (nonatomic, strong) NSMutableArray *invoiceMutableArray;
@property (nonatomic, strong) UIActivityIndicatorView *bottomProgressIndicatorView;
@property (nonatomic, strong) Invoicepopup *invoicePopupVew;
@property (nonatomic, strong) UIView *topTransparentView;
@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, assign) BOOL isSearchTextChanged;
@end

@implementation InvoiceViewController

- (void)viewDidLoad {
    self.isSearchTextChanged = NO;
    self.searchText  =@"";
    self.selectedYear = 0;
    self.selectedMonth = 0;
    [super viewDidLoad];
    [self initialisation];
     [self.invoicetableView registerNib:[UINib nibWithNibName:@"invoiceCell" bundle:nil] forCellReuseIdentifier:@"invoiceCell"];
    [self callingGettingInvoiceApi];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
   self.offsetValue = 0;
    self.limitValue = 50;
    self.invoiceMutableArray = [[NSMutableArray alloc] init];
    self.bottomProgressIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.bottomProgressIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addingToptransparentView];
}

-(void)addingToptransparentView{
    self.topTransparentView = [[UIView alloc] init];
    self.topTransparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.topTransparentView.backgroundColor = [UIColor blackColor];
    self.topTransparentView.layer.opacity = 0.5;
    self.topTransparentView.hidden = YES;
    [self.view addSubview:self.topTransparentView];
    [self addingTapGestureToToptransparentView];
}

-(void)addingTapGestureToToptransparentView{
    UITapGestureRecognizer *transparentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTransparentViewTapGestureAction:)];
    self.topTransparentView.userInteractionEnabled = YES;
    transparentTapGesture.numberOfTapsRequired = 1;
    [self.topTransparentView addGestureRecognizer:transparentTapGesture];
}

-(void)topTransparentViewTapGestureAction:(UITapGestureRecognizer *)tapGesture{
    [self.invoicePopupVew removeFromSuperview];
    self.topTransparentView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)filterButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InvoiceFilterViewController *invoiceFiltertVC = [storyboard instantiateViewControllerWithIdentifier:@"InvoiceFilterViewController"];
    invoiceFiltertVC.invoiceFilterDelegate = self;
    invoiceFiltertVC.yearSelectedIndex = self.selectedYear;
    invoiceFiltertVC.monthSelectedIndex = self.selectedMonth;
    [self presentViewController:invoiceFiltertVC animated:YES completion:nil];
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - search bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.isSearchTextChanged = YES;
    self.searchText  = searchText;
    self.offsetValue = 0;
    [self callingGettingInvoiceApi];
}

#pragma mark - Table View Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.invoiceMutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"invoiceCell"];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"invoiceCell" owner:self options:nil];
        cell = (InvoiceTableViewCell *)[nib objectAtIndex:0];
    }
    cell.doctorNameLabel.text = [[self.invoiceMutableArray objectAtIndex:indexPath.row] valueForKey:@"treator_name"];
    [cell.invoiceImageView sd_setImageWithURL:[[self.invoiceMutableArray objectAtIndex:indexPath.row] valueForKey:@"treator_image"] placeholderImage:[UIImage imageNamed:PlaceholderImageForDocumentLoading]];
    cell.amountLabel.text = [[self.invoiceMutableArray objectAtIndex:indexPath.row] valueForKey:@"amount"];
    cell.dateLabel.text = [[self.invoiceMutableArray objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.timeLabel.text = [[self.invoiceMutableArray objectAtIndex:indexPath.row] valueForKey:@"time"];
    return cell;
}

#pragma mark - Table view Deleagate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.topTransparentView.hidden = NO;
    self.invoicePopupVew = [[[NSBundle mainBundle]
                             loadNibNamed:@"InvoicePopup"
                             owner:self options:nil]
                            firstObject];
    CGFloat xMargin = 10,yMargin = 80;
    self.invoicePopupVew.frame = CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2*xMargin, self.view.frame.size.height - 2*yMargin);
    [self populatingInvoiceDetailsInInVoiceviewWithDetails:[self.invoiceMutableArray objectAtIndex:indexPath.row]];
    [self.view addSubview:self.invoicePopupVew];
}

-(void)populatingInvoiceDetailsInInVoiceviewWithDetails:(id)invoiceDetails{
    self.invoicePopupVew.invoiceDetails = invoiceDetails;
}

-(void)callingGettingInvoiceApi{
    if(self.offsetValue == 0){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSString *accesstokenString = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSMutableDictionary *invoiceMutableDictionary = [[NSMutableDictionary alloc] init];
    [invoiceMutableDictionary setValue:accesstokenString forKey:@"token"];
    [invoiceMutableDictionary setValue:@"to" forKey:@"type"];
    NSArray *yearArray = @[@"All",@"2016",@"2015",@"2014",@"2013",@"2012",@"2011",@"2010",@"2009"];
    if(self.selectedYear == 0){
        [invoiceMutableDictionary setValue:[NSNumber numberWithInt:-1] forKey:@"year"];
    }
    else{
        [invoiceMutableDictionary setValue:[yearArray objectAtIndex:self.selectedYear] forKey:@"year"];
    }
    if(self.selectedMonth == 0){
        [invoiceMutableDictionary setValue:[NSNumber numberWithInt:-1] forKey:@"month"];
    }
    else{
        [invoiceMutableDictionary setValue:[NSNumber numberWithInteger:self.selectedMonth] forKey:@"month"];
    }
    [invoiceMutableDictionary setValue:self.searchText forKey:@"keyword"];
    [invoiceMutableDictionary setValue:[NSNumber numberWithInt:self.limitValue] forKey:LimitKey];
    [invoiceMutableDictionary setValue:[NSNumber numberWithInt:self.offsetValue] forKey:Offsetkey];
    NSString *invoiceUrlString = [Baseurl stringByAppendingString:GettingInvoiceurl];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:invoiceUrlString] withBody:invoiceMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:accesstokenString];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSArray *invoiceArray = [responseObject valueForKey:Datakey];
        self.offsetValue = self.offsetValue+(int)invoiceArray.count;
        [self.bottomProgressIndicatorView stopAnimating];
        if(self.isSearchTextChanged){
            [self.invoiceMutableArray removeAllObjects];
        }
        [self.invoiceMutableArray addObjectsFromArray:invoiceArray];
        [self.invoicetableView reloadData];
        NSLog(@"Response object:%@",responseObject);
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.invoicetableView){
        self.isSearchTextChanged  = NO;
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self callingGettingInvoiceApi];
            [self.bottomProgressIndicatorView startAnimating];
        }
        else{
            [self.bottomProgressIndicatorView stopAnimating];
        }
    }
}

#pragma mark - Invoice VC Delegate

-(void)submitButtonActionWithYearIndex:(NSInteger)yearSelectedIndex andMonthSelectedIndex:(NSInteger)monthSelectedIndex{
    self.offsetValue = 0;
    self.isSearchTextChanged = NO;
    [self.invoiceMutableArray removeAllObjects];
    self.selectedYear = yearSelectedIndex;
    self.selectedMonth = monthSelectedIndex;
    [self callingGettingInvoiceApi];
}

@end
