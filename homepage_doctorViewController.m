//
//  homepage_doctorViewController.m
//  MAA
//
//  Created by Kiran on 23/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "homepage_doctorViewController.h"
#import "student.h"
#import "CLToolKit/ImageCache.h"
@interface homepage_doctorViewController ()
{
    NSString *url ;
    NSString *cacheIdentifier;
    NSString *cacheIdentifier2;

    NSArray *arr;
    NSArray *statisticsArray;
    NSMutableDictionary *dict;
    NSInteger count;
    NSDictionary *d2;
    NSMutableArray *mutname;
    NSDictionary *extra;
    NSMutableArray *mutimage;
    NSArray *latestarr;
    NSMutableArray *bla;
    NSMutableArray *blu;
    NSMutableArray *cblu;

    NSMutableArray *ogphm;
    NSMutableArray *arr1;
    NSInteger check;
    NSArray *cached;
}


@end

@implementation homepage_doctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        count = 2;
    // Do any additional setup after loading the view.
    mutimage = [[NSMutableArray alloc]init];
    bla = [@[]mutableCopy];
    blu = [@[]mutableCopy];
    cblu = [@[]mutableCopy];

  //  ogphm = [@[]mutableCopy];

    mutname = [[NSMutableArray alloc]init];
   // dict = [[NSMutableDictionary alloc]init];
    arr1 = [[NSMutableArray alloc]initWithObjects:@"Consulatation",@"Fee",@"Review",@"Questions", nil];


    url = @"http://freemaart.com/dev/my_maa/api/get_dash_info ";
   _token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6ImFkNTY5NDMzMTc2ZDg1N2M2ZjhlODZiYWIzMDU2ODdkYjlkYzY0M2EifQ.PYNadEyYkRDDLX9iMLD1mMZeIn9zZsKcof-ooS06HU8";
    
    
    NSMutableDictionary *doctor_Dash = [[NSMutableDictionary alloc] init];
    [doctor_Dash setValue:_token forKey:@"token"];
    [doctor_Dash setValue:[NSNumber numberWithInt:3] forKey:@"appointments_count"];
    NSString *doctor = [Baseurl stringByAppendingString:doctor_url];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:doctor] withBody:doctor_Dash withMethodType:HTTPMethodPOST withAccessToken:_token];
    [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
      //  NSLog(@"REsponse Object:%@",responseObject);
        
        dict = [responseObject valueForKey:@"data"];
        arr = [dict valueForKey:@"appointments"];
        cached = [dict valueForKey:@"statistics"];
        check = [[dict valueForKey:@"is_online"]integerValue];
        NSLog(@"QAZAQAAZAAQQAZZAAQAZZAAQAZZAAZZZZ         :   %li",(long)check);
        
        if (check == 1) {
            [_toggler setOn:YES animated:YES];
            _status_label.text = @"Available";
            
            
        }
        else if (check == 0)
        {
            _status_label.text = @"Busy";
            
            [_toggler setOn:NO animated:YES];
        }

        
        
        statisticsArray = [dict valueForKey:@"statistics"];
        for (NSDictionary *item in cached) {
            student *m = [[student alloc]init];
            m.downcacheid = item[@"key"];
            [cblu addObject:m];
        }
        for (NSDictionary *item in arr) {
            
            
            student *std = [[student alloc]init];
            //   NSLog(@"patient_detailsdcjvhqebw jceqhbvjeqlhv ljeqhverv : %@",item[@"patient_details"]);
            NSDictionary *foo =item[@"patient_details"];
            std.name = foo[@"name"];
            std.imagee = foo[@"image"];
            std.cacheid = foo[@"id"];

            [bla addObject:std];
            student *FROO = [[student alloc]init];
            FROO = bla[0];
            NSLog(@"%@QQQQQQQQQQQQQQQQ",FROO.name);
            //   NSLog(@"patient_detailsdcjvhqebw jceqhbvjeqlhv ljeqhverv : %@",item[@"patient_details"]);
            //            std.answer = [item[@"answer"]integerValue];
            //            std.choices = item[@"choices"];
            //            [_marr addObject:std];
        }
        
        
        for (NSDictionary *item in statisticsArray) {
            
            
            student *stdt = [[student alloc]init];
            //   NSLog(@"patient_detailsdcjvhqebw jceqhbvjeqlhv ljeqhverv : %@",item[@"patient_details"]);
          //  NSDictionary *foo =item[@"patient_details"];
            stdt.value_consulation = item[@"value"];
//            std.value_feecollected = item[@"fee_collected"];
//            std.value_questions = item[@"questions"];
//            std.value_review = item[@"reviews"];

            stdt.imagee_consulation = item[@"bg_image"];
            [blu addObject:stdt];
            student *FROOo = [[student alloc]init];
            FROOo = blu[0];
            NSLog(@"%@QQQQQQQQQQQQQQQQ",FROOo.value_consulation);
            //   NSLog(@"patient_detailsdcjvhqebw jceqhbvjeqlhv ljeqhverv : %@",item[@"patient_details"]);
            //            std.answer = [item[@"answer"]integerValue];
            //            std.choices = item[@"choices"];
            //            [_marr addObject:std];
        }

        
        
        
        
        
        NSLog(@"%@QWERTYYYYYYYYY",[[bla objectAtIndex:0] valueForKey:@"name"]);
        
        [_tablee reloadData];
        [_collviewwwww reloadData];
        

//        for(NSString *item in responseObject) {
//            NSLog(@"is onlne %@",[responseObject valueForKey:item]);
//
//        }
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
    
    
    ogphm = [NSMutableArray arrayWithArray:bla];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bla count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDent = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDent];
    if (cell==nil) {
        [[NSBundle mainBundle]loadNibNamed:@"doctor_dash_xib" owner:self options:nil];
        cell=_celll;
        
    }
//    student *s = [[student alloc]init];
//    s = [bla objectAtIndex:0];
//    
    
  //  _doctor_name.text = ;
// _doctor_name.text = @"d vdfv";
    
    student *kk = [[student alloc]init];
    kk = bla[indexPath.row];
    _doctor_name = (UILabel*)[cell viewWithTag:2];

   _doctor_name.text = [[bla objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  NSURL*  imageUrl = [NSURL URLWithString:(NSString*)kk.imagee];
    cacheIdentifier = kk.cacheid;
NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor"];
//NSURL *imageUrl = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/en/4/4e/Tis_The_Season_To_Be_Fearless_Cover.jpg"];
UIImage *localImage;
    if(!localImage)
    {
    [MBProgressHUD showHUDAddedTo:_doctor_pic animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *tempImage = [UIImage imageWithData:imageData];
        [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:cacheIdentifier];
        dispatch_async(dispatch_get_main_queue(), ^{
            _doctor_pic.image = tempImage;
          //  [tableView reloadData];
            [MBProgressHUD hideAllHUDsForView:_doctor_pic animated:YES];
        }
                       );
    });



    }
    else{
       // [tableView reloadData];
        _doctor_pic.image = localImage;
    }















    
    
    
       _doctor_pic = (UIImageView*)[cell viewWithTag:1];
   // _doctor_pic.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",kk.imagee]];
//_doctor_pic= [UIImage imag]
    NSLog(@"%@",kk.imagee);
//    _doctor_pic = (UIImageView*)[cell viewWithTag:1];
//    _doctor_pic.image = [UIImage imageNamed:[[bla objectAtIndex:indexPath.row] valueForKey:@"image"]];

   // _doctor_name.text =s.name ;
        return cell;
    
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [blu count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDent = @"cellid";
    UICollectionViewCell *cellll = [collectionView dequeueReusableCellWithReuseIdentifier:cellIDent forIndexPath:indexPath];
    student *sss = [[student alloc]init];
    sss = blu[indexPath.row];
    student *obj2 = [[student alloc]init];
    obj2 = cblu[indexPath.row];


    _xiblabel = (UILabel*)[cellll viewWithTag:30];
    _xiblabel.text = sss.value_consulation;
    _downimage = (UIImageView*)[cellll viewWithTag:40];

    UILabel * labeltag = [cellll viewWithTag:50];
    labeltag.text = arr1[indexPath.row];
    NSURL*  imageUrll = [NSURL URLWithString:(NSString*)sss.imagee_consulation];
    cacheIdentifier2 = obj2.downcacheid;
    NSString *folderPath = [NSString stringWithFormat:@"Maa/Photos/Doctor"];
    //NSURL *imageUrl = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/en/4/4e/Tis_The_Season_To_Be_Fearless_Cover.jpg"];
    UIImage *localImagee;
    if(!localImagee)
    {

    [MBProgressHUD showHUDAddedTo:_downimage animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrll];
        UIImage *tempImage = [UIImage imageWithData:imageData];

          [[ImageCache sharedCache]addImage:tempImage toFolder:folderPath toCacheWithIdentifier:cacheIdentifier2];
        dispatch_async(dispatch_get_main_queue(), ^{
            _downimage.image = tempImage;
           // [collectionView reloadData];
            [MBProgressHUD hideAllHUDsForView:_downimage animated:YES];
        }
                       );
    });
    
    }
    
    else{
        _downimage.image = localImagee;
       // [collectionView reloadData];
    }
    
    
    return cellll;
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

- (IBAction)toggler:(id)sender {
    
   if([sender isOn]){
       _status_label.text = @"Available";
       
       
       
       url = @" http://freemaart.com/dev/my_maa/api/set_doc_status";
       _token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6IjBmZjJmNWE3ODE1MmRhNjE5ZDBiMjA5NjAyNmI5ZDc3YjJlY2YxN2QifQ.5JChdInBwyMw3CHSdzDLTzbC-yCuc4EmfmKqHLSjcPc";
       
       
       NSMutableDictionary *doctor_Dashh = [[NSMutableDictionary alloc] init];
       [doctor_Dashh setValue:_token forKey:@"token"];
       [doctor_Dashh setValue:@"online" forKey:@"status"];
       NSString *doctor = [Baseurl stringByAppendingString:doc_status_url];
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:doctor] withBody:doctor_Dashh withMethodType:HTTPMethodPOST withAccessToken:_token];
       [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
           //  NSLog(@"REsponse Object:%@",responseObject);
           
           NSLog(@"SUCCESS");
  
           
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
    else
    {
        _status_label.text = @"Busy";
        
        
        
        
        url = @" http://freemaart.com/dev/my_maa/api/set_doc_status";
        _token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6IjBmZjJmNWE3ODE1MmRhNjE5ZDBiMjA5NjAyNmI5ZDc3YjJlY2YxN2QifQ.5JChdInBwyMw3CHSdzDLTzbC-yCuc4EmfmKqHLSjcPc";
        
        
        NSMutableDictionary *doctor_Dashh = [[NSMutableDictionary alloc] init];
        [doctor_Dashh setValue:_token forKey:@"token"];
        [doctor_Dashh setValue:@"offline" forKey:@"status"];
        NSString *doctor = [Baseurl stringByAppendingString:doc_status_url];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[NetworkHandler sharedHandler] requestWithRequestUrl:[NSURL URLWithString:doctor] withBody:doctor_Dashh withMethodType:HTTPMethodPOST withAccessToken:_token];
        [[NetworkHandler sharedHandler] startServieRequestWithSucessBlockSuccessBlock:^(id responseObject) {
            //  NSLog(@"REsponse Object:%@",responseObject);
            
            NSLog(@"SUCCESS");
            
            
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
    
}
@end
