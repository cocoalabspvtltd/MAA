

#import "CLAlertHandler.h"

#import <UIKit/UIKit.h>

@implementation CLAlertHandler

+ (CLAlertHandler *)standardHandler {
    static CLAlertHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


#pragma mark - UIAlert

- (void)showAlert:(NSString *)alertMessage title:(NSString *)title {
    UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:title message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showAlert:(NSString *)alertMessage title:(NSString *)title delegate:(id)delegate{
    UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:title message:alertMessage delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showAlert:(NSString *)alertMessage alertTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle delegate:(id)delegate {
    UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:title message:alertMessage delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alert show];
}

- (void)showAlert:(NSString *)alertMessage withTag:(int)alertTag alertTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle delegate:(id)delegate {
    UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:title message:alertMessage delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    alert.tag = alertTag;
    [alert show];
}

- (void)showAlert:(NSString *)alertMessage withTag:(int)alertTag title:(NSString *)title delegate:(id)delegate {
    UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:title message:alertMessage delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = alertTag;
    [alert show];
}


@end
