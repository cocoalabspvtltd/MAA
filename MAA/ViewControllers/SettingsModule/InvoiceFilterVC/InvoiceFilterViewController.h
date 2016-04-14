//
//  InvoiceFilterViewController.h
//  MAA
//
//  Created by Cocoalabs India on 14/04/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InvoiceFilterVCDelegate;
@interface InvoiceFilterViewController : UIViewController
@property (nonatomic,assign) NSInteger yearSelectedIndex;
@property (nonatomic, assign) NSInteger monthSelectedIndex;
@property (nonatomic, assign) id <InvoiceFilterVCDelegate>invoiceFilterDelegate;
@end
@protocol InvoiceFilterVCDelegate <NSObject>

-(void)submitButtonActionWithYearIndex:(NSInteger)yearSelectedIndex andMonthSelectedIndex:(NSInteger)monthSelectedIndex;

@end