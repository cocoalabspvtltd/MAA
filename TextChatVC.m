//
//  TextChatVC.m
//  MAA
//
//  Created by Cocoalabs India on 08/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "TextChatVC.h"
#import <QuartzCore/QuartzCore.h>

@interface TextChatVC ()<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *DummyMessage;
    int i;
}

@end

@implementation TextChatVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tblChat.estimatedRowHeight = 49 ;
    self.tblChat.rowHeight = UITableViewAutomaticDimension;
    
    _tblChat.delegate=self;
    _tblChat.dataSource=self;
    DummyMessage = [[NSMutableArray alloc]initWithObjects:@"In a storyboard-based application, you will often want to do a little preparation before navigation", nil];
    
    self.txtMessage.layer.borderWidth = .5f;
    self.txtMessage.layer.cornerRadius=5;
    self.txtMessage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [DummyMessage count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDent = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDent];
   
//    if (cell==nil)
//    {
//        [[NSBundle mainBundle]loadNibNamed:@"chatSender" owner:self options:nil];
//        
//        cell=_CellSender;
//        
//    }
     if(cell==nil)
    {
        [[NSBundle mainBundle]loadNibNamed:@"chatReciever" owner:self options:nil];
        
        cell=_CellReciever;
    }
    _lblReciever = (UILabel*)[cell viewWithTag:10];
    _lblReciever.text=[DummyMessage objectAtIndex:indexPath.row];

    return cell;
}    

- (void)didReceiveMemoryWarning
{
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

- (IBAction)Send:(id)sender
{
//    _lblSender.textAlignment = NSTextAlignmentRight;
    [DummyMessage addObject:_txtMessage.text];
    i = 1;

    [_tblChat reloadData];
}
@end
