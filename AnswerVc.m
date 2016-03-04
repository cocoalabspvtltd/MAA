//
//  AnswerVc.m
//  maa.stroyboard
//
//  Created by Cocoalabs India on 04/03/16.
//  Copyright © 2016 Cocoalabs India. All rights reserved.
//

#import "AnswerVc.h"

@interface AnswerVc ()

@end

@implementation AnswerVc

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _lblAnswer.hidden=YES;
    _btnEdit.hidden=YES;
    _btnDelete.hidden=YES;
    
    
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
- (IBAction)Edit:(id)sender
{
    
    _lblAnswer.hidden=YES;
    _btnEdit.hidden=YES;
    _btnDelete.hidden=YES;
    
    _txtAnser.hidden=NO;
    _btnSubmit.hidden=NO;
    
}
- (IBAction)Submit:(id)sender
{
    
    
    
    _lblAnswer.hidden=NO;
    _btnEdit.hidden=NO;
    _btnDelete.hidden=NO;
    
    _txtAnser.hidden=YES;
    _btnSubmit.hidden=YES;

}

@end
