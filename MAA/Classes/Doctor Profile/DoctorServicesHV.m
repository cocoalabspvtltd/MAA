//
//  DoctorServicesHV.m
//  MAA
//
//  Created by kiran on 26/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorServicesHV.h"

@implementation DoctorServicesHV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)headerViewButonAction:(UIButton *)sender {
    if(self.doctorServicesDelegate && [self.doctorServicesDelegate respondsToSelector:@selector(headerButtonClickWithTag:)]){
        [self.doctorServicesDelegate headerButtonClickWithTag:self.tag];
    }
}

@end
