//
//  Invoicepopup.m
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "Invoicepopup.h"

@implementation Invoicepopup

-(void)awakeFromNib{
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setInvoiceDetails:(id)invoiceDetails{
    if(!([invoiceDetails valueForKey:@"invoice_no"] == [NSNull null])){
        self.invoiceNoLabel.text = [invoiceDetails valueForKey:@"invoice_no"];
    }
    else{
        self.invoiceNoLabel.text = @"";
    }
    if(!([invoiceDetails valueForKey:@"date"] == [NSNull null])){
        self.dateLabel.text = [invoiceDetails valueForKey:@"date"];
    }
    else{
        self.dateLabel.text = @"";
    }
    if(!([invoiceDetails valueForKey:@"time"] == [NSNull null])){
        self.selectedTimeLabel.text = [invoiceDetails valueForKey:@"time"];
    }
    else{
        self.selectedTimeLabel.text = @"";
    }
    if(!([invoiceDetails valueForKey:@"amount"] == [NSNull null])){
        self.feeLabel.text =  [invoiceDetails valueForKey:@"amount"];
    }
    else{
        self.feeLabel.text = @"";
    }
    if(!([invoiceDetails valueForKey:@"location"] == [NSNull null])){
        self.locationLabel.text = [invoiceDetails valueForKey:@"location"];
    }
    else{
        self.locationLabel.text = @"";
    }
    if(!([invoiceDetails valueForKey:@"status"] == [NSNull null])){
        self.statusLabel.text = [invoiceDetails valueForKey:@"status"];
    }
    else{
        self.statusLabel.text = @"";
    }
    if(!([invoiceDetails valueForKey:@"type"] == [NSNull null])){
        NSString *typeString = [invoiceDetails valueForKey:@"type"];
        if([typeString isEqualToString:@"1"]){
            self.typeOfappointmentLabel.text = @"Direct Appointment";
        }
        else if ([typeString isEqualToString:@"2"]){
            self.typeOfappointmentLabel.text = @"Text Chat";
        }
        else if ([typeString isEqualToString:@"3"]){
            self.typeOfappointmentLabel.text = @"Audio Call";
        }
        else if ([typeString isEqualToString:@"4"]){
            self.typeOfappointmentLabel.text = @"Video Call";
        }
    }
    else{
        self.typeOfappointmentLabel.text = @"";
    }
}
@end
