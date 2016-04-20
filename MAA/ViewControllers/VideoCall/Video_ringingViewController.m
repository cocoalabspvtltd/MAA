//
//  Video_ringingViewController.m
//  MAA
//
//  Created by Kiran on 23/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "Video_ringingViewController.h"

@interface Video_ringingViewController ()
{
    AVAudioPlayer* player;
}

@end

@implementation Video_ringingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _docImage.clipsToBounds = YES;
    [self setRoundedView:_docImage toDiameter:50.0];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Short Notification" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
     player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [player setNumberOfLoops:-1];
    [player play];
    


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

- (IBAction)accept:(id)sender {
    [player stop];
}

- (IBAction)reject:(id)sender {
    [player stop];

}
@end
