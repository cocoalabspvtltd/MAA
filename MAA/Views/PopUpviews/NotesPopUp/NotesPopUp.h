//
//  NotesPopUp.h
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesPopUp : UIView
@property (weak, nonatomic) IBOutlet UILabel *noteDescriptionLabel;
@property (nonatomic, strong) NSString *notesString;
@end
