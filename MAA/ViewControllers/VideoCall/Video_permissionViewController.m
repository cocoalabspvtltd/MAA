//
//  Video_permissionViewController.m
//  MAA
//
//  Created by Kiran on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "Video_permissionViewController.h"
#import "newTableViewController.h"
#import "thirdViewController.h"
#import "ViewController.h"

@interface Video_permissionViewController ()
{
    int i;
}

@end

@implementation Video_permissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 0;
    _docImage.clipsToBounds = YES;
    _docImage.layer.cornerRadius = _docImage.frame.size.width/2;
    _name.text=_namee;

            [_docImage sd_setImageWithURL:_imagee placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    

    NSLog(@"%@",_appID);
    [_app_dur setText:[NSString stringWithFormat:@"Appointment duration: %@ Minutes",_duration]];

    
    

    // Do any additional setup after loading the view.
}
-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
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

- (IBAction)check:(id)sender {
    if (i == 0) {
 UIImage *buttonImage = [UIImage imageNamed:@"check_light_gray.png"];
        [_check setBackgroundImage:buttonImage forState:UIControlStateNormal];
        i = 1;
        [_start_appnt setAlpha:1];
        [_start_appnt setUserInteractionEnabled:YES];

    }
    else if (i==1)
    {
        UIImage *buttonImage = [UIImage imageNamed:@"check_dark_gray.png"];

        [_check setBackgroundImage:buttonImage forState:UIControlStateNormal];
        i = 0;
        [_start_appnt setAlpha:0.2];
        [_start_appnt setUserInteractionEnabled:NO];
    }
}

- (IBAction)start:(id)sender {
    if (i == 1) {
        //        [self performSegueWithIdentifier:@"ring" sender:nil];
        if ([_type isEqual:@"Direct Appointment"]) {
            
        }
        if ([_type isEqual:@"Text Chat"]) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            newTableViewController *chatVC = (newTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"chatNew"];
            chatVC.appID=[NSString stringWithFormat:@"%@",_appID];
            [self.navigationController pushViewController:chatVC animated:YES];
            
            
        }
        else if ([_type isEqual:@"Audio Chat"]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            thirdViewController *audioVC = (thirdViewController *)[storyboard instantiateViewControllerWithIdentifier:@"audio"];
            audioVC.appID=[NSString stringWithFormat:@"%@",_appID];
            [self.navigationController pushViewController:audioVC animated:YES];
            
        }
        else if ([_type isEqual:@"Video Chat"]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *videoViewController = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"video"];
            videoViewController.appID=[NSString stringWithFormat:@"%@",_appID];
            [self.navigationController pushViewController:videoViewController animated:YES];
        }
        
    }
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
