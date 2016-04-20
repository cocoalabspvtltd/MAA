//
//  CategoriesList.m
//  MAA
//
//  Created by Cocoalabs India on 05/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "CategoriesList.h"
#import "CategoryCell.h"

@interface CategoriesList ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *categoriesArray;
@end

@implementation CategoriesList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCategoriesApiCall];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoriesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [self.tblCategories dequeueReusableCellWithIdentifier:@"categoryReusableCell" forIndexPath:indexPath];
    cell.lblcatName.text = [[self.categoriesArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSString *imageUrlString = [[self.categoriesArray objectAtIndex:indexPath.row] valueForKey:@"logo_image"];
    [cell.categoryImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:PlaceholderImageForDocumentLoading]];
    return cell;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.categoryDelegate && [self.categoryDelegate respondsToSelector:@selector(tableViewSelectedActionWithCategoryDetails:)]){
        [self.categoryDelegate tableViewSelectedActionWithCategoryDetails:[self.categoriesArray objectAtIndex:indexPath.row]];
    }
    if(self.isFromFilter){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
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
- (IBAction)back:(id)sender
{
    if(self.isFromFilter){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Get Categories api

-(void)getCategoriesApiCall{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:ACCESS_TOKEN];
    NSString *getCategoriesUrlString = [Baseurl stringByAppendingString:GetCategoriesUrl];
    NSMutableDictionary *getSubcategoriesMutableDictionary = [[NSMutableDictionary alloc] init];
    [getSubcategoriesMutableDictionary  setValue:accessToken forKey:@"token"];
    [getSubcategoriesMutableDictionary  setValue:@"" forKey:@"keyword"];
    [getSubcategoriesMutableDictionary  setValue:[NSNumber numberWithInt:0] forKey:Offsetkey];
    [getSubcategoriesMutableDictionary setValue:[NSNumber numberWithInt:100] forKey:LimitKey];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:getCategoriesUrlString] withBody:getSubcategoriesMutableDictionary withMethodType:HTTPMethodPOST withAccessToken:[NSString stringWithFormat:@"Bearer %@",accessToken]];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
        self.categoriesArray = [responseObject valueForKey:Datakey];
         NSLog(@"Response Object:%@",self.categoriesArray);
        [self.tblCategories reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
@end
