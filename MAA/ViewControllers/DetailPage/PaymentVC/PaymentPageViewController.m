//
//  ViewController.m
//  PaymentGateway
//
//  Created by Suraj on 22/07/15.
//  Copyright (c) 2015 Suraj. All rights reserved.
//

#import "PaymentPageViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "PaymentStatusViewController.h"

@interface PaymentPageViewController () <UIWebViewDelegate, UIAlertViewDelegate> {
    UIActivityIndicatorView *activityIndicatorView;
    NSString *strMIHPayID;
}

@property (nonatomic, strong) UIWebView *webviewPaymentPage;

@end

@implementation PaymentPageViewController


/*
 
 payUmoney Contact Details:
 Address:
 5th Floor, Pearl Towers Plot 51, Sector 32 Gurgaon, 122002
 
 Phone:
 0124-6624956,
 0124-6624970
 
 Email:
 techsupport@payumoney.com
 
 
 //// Process to Signup & generate Merchant ID, Key & Salt ////
 
 
 ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// //////
 
 
 Test Environment:
 
 Recently, payUmoney has done some modifications in test environment due to which test key-JBZaLc and salt-GQs7yium will not work anymore.
 
 In order to test the gateway using a test key and salt, kindly follow these steps:
 
 1 - Go on http://test.payumoney.com/
 2 - Sign up as a merchant - use any of your valid email ids - kindly do not use a random email id.
 3 - Use a valid Mobile Number and for Phone/Landline No use your valid mobile number with a preceeding 0. (e.g. Mobile No: 9762159571 so the Landline No: 09762159571)
 4 - Complete the "Business Details"  - you may use PAN no. ABCDE1234F and DOB - 01/04/1990
 5 - Complete "Bank Account Details" (You may use IFSC- ALLA0212632)
 6 - Please leave the bank verification part.
 7 - Go to below mentioned location to get the Test Merchant Id :
 Seller Dashboard -> Settings -> My account -> Profile Settings
 
 Once you provide your test merchant id, payUmoney will approve it so that you can find your test key and salt at :
 Seller Dashboard -> Settings -> My account -> Merchant Key - Salt
 
 
 ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// //////
 
 
 Production Environment:
 
 kindly register to https://www.payumoney.com/ and follow above steps with all your Genuine Bank details, contact numbers & adresses.
 Please note that the Key and Salt for Production server are different from the one we get from Test server.
 
 */




/*
 Test Environment:
 
 Card Name:   any name
 Card Number: 5123456789012346
 CVV:         123
 Expiry:      May 2017
 
 */



// You can use below Merchant Key & Salt generated by me for Testing/Demo purpose
// But try to generate yours by following all the steps so you get an idea to how it works

#define Merchant_Key @"C9qqP0Lf"
#define Salt @"PqkIrvEABS"
//#define Base_URL @"https://test.payu.in"
#define Base_URL @"https://secure.payu.in"
#define Success_URL @"https://mobiletest.payumoney.com/mobileapp/payumoney/success.php"
#define Failure_URL @"http://www.bing.com/"

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:YES];
    [self setTitle:@"Make A Payment"];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self setTitle:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customisation];
    [self addSubviews];
    [self initPayment];
}

-(void)initialisation{
    self.webviewPaymentPage = [[UIWebView alloc] init];
    self.webviewPaymentPage.delegate = self;
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    [activityIndicatorView setColor:[UIColor blackColor]];
}

-(void)customisation{
  self.view.backgroundColor = [UIColor whiteColor];
}

-(void)addSubviews{
    [self.view addSubview:self.webviewPaymentPage];
    [self.view addSubview:activityIndicatorView];
}

-(void)viewWillLayoutSubviews{
    activityIndicatorView.center = self.view.center;
    self.webviewPaymentPage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initPayment {
    int i = arc4random() % 9999999999;
    NSString *strHash = [self createSHA512:[NSString stringWithFormat:@"%d%@",i,[NSDate date]]];// Generatehash512(rnd.ToString() + DateTime.Now);
    NSString *txnid1 = [strHash substringToIndex:20];
    strMIHPayID = txnid1;
    
    NSString *key = Merchant_Key;
    NSString *amount = self.amountString;
    NSString *productInfo = self.productInfoString;
    NSString *firstname = self.payeeNameString;
    NSString *email = [NSString stringWithFormat:@"%@",self.payeeEmailidString]; // Generated a fake mail id for testing
    NSString *phone = [NSString stringWithFormat:@"%@",self.payeePhoneString];
    NSString *serviceprovider = @"payu_paisa";
    
    NSString *hashValue = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|||||||||||%@",key,txnid1,amount,productInfo,firstname,email,Salt];
    NSString *hash = [self createSHA512:hashValue];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:txnid1,key,amount,productInfo,firstname,email,phone,Success_URL,Failure_URL,hash,serviceprovider
                                                                    , nil] forKeys:[NSArray arrayWithObjects:@"txnid",@"key",@"amount",@"productinfo",@"firstname",@"email",@"phone",@"surl",@"furl",@"hash",@"service_provider", nil]];
    NSLog(@"Parameters:%@",parameters);
    __block NSString *post = @"";
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([post isEqualToString:@""]) {
            post = [NSString stringWithFormat:@"%@=%@",key,obj];
        } else {
            post = [NSString stringWithFormat:@"%@&%@=%@",post,key,obj];
        }
    }];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/_payment",Base_URL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    
    [_webviewPaymentPage loadRequest:request];
    [activityIndicatorView startAnimating];
}

-(NSString *)createSHA512:(NSString *)string {
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

#pragma UIWebView - Delegate Methods
-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"WebView started loading");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicatorView stopAnimating];
    
    if (webView.isLoading) {
        return;
    }
    
    NSURL *requestURL = [[_webviewPaymentPage request] URL];
    NSLog(@"WebView finished loading with requestURL: %@",requestURL);
    
    NSString *getStringFromUrl = [NSString stringWithFormat:@"%@",requestURL];
    
    if ([self containsString:getStringFromUrl :Success_URL]) {
        [self performSelector:@selector(delayedDidFinish:) withObject:getStringFromUrl afterDelay:0.0];
    } else if ([self containsString:getStringFromUrl :Failure_URL]) {
        // FAILURE ALERT
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry !!!" message:@"Your transaction failed. Please try again!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alert.tag = 1;
        [alert show];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activityIndicatorView stopAnimating];
    NSURL *requestURL = [[_webviewPaymentPage request] URL];
    NSLog(@"WebView failed loading with requestURL: %@ with error: %@ & error code: %ld",requestURL, [error localizedDescription], (long)[error code]);
    if (error.code == -1009 || error.code == -1003 || error.code == -1001) { //error.code == -999
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops !!!" message:@"Please check your internet connection!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alert.tag = 1;
        [alert show];
    }
}

- (void)delayedDidFinish:(NSString *)getStringFromUrl {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *mutDictTransactionDetails = [[NSMutableDictionary alloc] init];
        [mutDictTransactionDetails setObject:strMIHPayID forKey:@"Transaction_ID"];
        [mutDictTransactionDetails setObject:@"Success" forKey:@"Transaction_Status"];
        [mutDictTransactionDetails setObject:self.payeeNameString forKey:@"Payee_Name"];
        [mutDictTransactionDetails setObject:self.productInfoString forKey:@"Product_Info"];
        [mutDictTransactionDetails setObject:self.amountString forKey:@"Paid_Amount"];
        
        [self navigateToPaymentStatusScreen:mutDictTransactionDetails];
    });
}

#pragma UIAlertView - Delegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1 && buttonIndex == 0) {
        // Navigate to Payment Status Screen
        NSMutableDictionary *mutDictTransactionDetails = [[NSMutableDictionary alloc] init];
        [mutDictTransactionDetails setObject:self.payeeNameString forKey:@"Payee_Name"];
        [mutDictTransactionDetails setObject:self.productInfoString forKey:@"Product_Info"];
        [mutDictTransactionDetails setObject:self.amountString forKey:@"Paid_Amount"];
        [mutDictTransactionDetails setObject:strMIHPayID forKey:@"Transaction_ID"];
        [mutDictTransactionDetails setObject:@"Failed" forKey:@"Transaction_Status"];
        [self navigateToPaymentStatusScreen:mutDictTransactionDetails];
    }
}

- (BOOL)containsString: (NSString *)string : (NSString*)substring {
    return [string rangeOfString:substring].location != NSNotFound;
}

- (void)navigateToPaymentStatusScreen: (NSMutableDictionary *)mutDictTransactionDetails {
    NSLog(@"Finished");
    [self addingAlertControllerForPaymentSuccess];
   // dispatch_async(dispatch_get_main_queue(), ^{
//        PaymentStatusViewController *paymentStatusViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PaymentStatusScreenID"];
//        paymentStatusViewController.mutDictTransactionDetails = mutDictTransactionDetails;
//        [self.navigationController pushViewController:paymentStatusViewController animated:YES];
  //  });
}

-(void)addingAlertControllerForPaymentSuccess{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:AppName message:@"Payment Successful" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:okaction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
