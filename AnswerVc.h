//
//  AnswerVc.h
//  maa.stroyboard
//
//  Created by Cocoalabs India on 04/03/16.
//  Copyright © 2016 Cocoalabs India. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerVc : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswer;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UITextView *txtAnser;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end
