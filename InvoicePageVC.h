//
//  InvoicePageVC.h
//  MAA
//
//  Created by Cocoalabs India on 06/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoicePageVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnMonth;
- (IBAction)ClickMonth:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnYear;
- (IBAction)ClickYear:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblMonth;
@property (weak, nonatomic) IBOutlet UITableView *tblYear;
@property (weak, nonatomic) IBOutlet UITableView *tblInvoices;

@end
