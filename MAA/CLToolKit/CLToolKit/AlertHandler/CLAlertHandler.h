/
#import <Foundation/Foundation.h>

@interface CLAlertHandler : NSObject

- (void)showAlert:(NSString *)alertMessage title:(NSString *)title;
- (void)showAlert:(NSString *)alertMessage title:(NSString *)title delegate:(id)delegate;
- (void)showAlert:(NSString *)alertMessage alertTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle delegate:(id)delegate;
- (void)showAlert:(NSString *)alertMessage withTag:(int)alertTag alertTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle delegate:(id)delegate;
- (void)showAlert:(NSString *)alertMessage withTag:(int)alertTag title:(NSString *)title delegate:(id)delegate;

@end
