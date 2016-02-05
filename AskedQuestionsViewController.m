//
//  AskedQuestionsViewController.m
//  MAA
//
//  Created by Cocoalabs India on 02/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "AskedQuestionsViewController.h"

@interface AskedQuestionsViewController ()

@end

@implementation AskedQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.floatimage.layer.cornerRadius = self.floatimage.frame.size.width / 2;
    self.floatimage.clipsToBounds = YES;
    
    
    // Do any additional setup after loading the view.
}
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    if ([aScrollView isEqual:self.tblquestions])
    {
        self.floatbutton.transform = CGAffineTransformMakeTranslation(0, aScrollView.contentOffset.x);
        self.floatimage.transform= CGAffineTransformMakeTranslation(0, aScrollView.contentOffset.x);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdent = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        [[NSBundle mainBundle]loadNibNamed:@"View" owner:self options:nil];
        cell =_celll;
    }
    self.ImgAskdPerson.layer.cornerRadius = self.ImgAskdPerson.frame.size.width / 2;
    self.ImgAskdPerson.clipsToBounds = YES;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

{
    [self performSegueWithIdentifier:@"fwdSegue" sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
