//
//  Doc'sAccntInfo.m
//  MAA
//
//  Created by Cocoalabs India on 01/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "Doc'sAccntInfo.h"
#import <QuartzCore/QuartzCore.h>

@interface Doc_sAccntInfo ()

@end

@implementation Doc_sAccntInfo
NSString *toggle=@"0";

- (void)viewDidLoad {
    [super viewDidLoad];

        _ChildView.hidden=YES;
        _txtNwPwd.placeholder=@"New Password";
        _txtOldPwd.placeholder=@"Old Password";
        _txtRetypPwd.placeholder=@"Retype Password";
    [[_btnChangePwd layer] setBorderWidth:1.0f];
    [[_btnChangePwd layer] setBorderColor:[UIColor blackColor].CGColor];

    // Do any additional setup after loading the view.
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
- (IBAction)ChangePwd:(id)sender
{
    if ([toggle isEqualToString:@"0"])
    {
        _ChildView.hidden=NO;
        toggle=@"2";
        _imgarrow.image=[UIImage imageNamed:@"arrowdown"];
        
        
    }
    else if ([toggle isEqualToString:@"2"])
    {
        _ChildView.hidden=YES;
        toggle=@"0";
        _imgarrow.image=[UIImage imageNamed:@"arrowright"];
        
        
    }
    
}
- (IBAction)Submit:(id)sender {
}


@end
