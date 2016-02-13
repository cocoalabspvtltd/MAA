//
//  NotesPopUp.m
//  MAA
//
//  Created by Cocoalabs India on 13/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "NotesPopUp.h"

@implementation NotesPopUp

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setNotesString:(NSString *)notesString{
    self.noteDescriptionLabel.text = notesString;
}

@end
