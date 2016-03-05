//
//  TPKeyboardAvoidingTableView.m
//
//  Created by Michael Tyson on 11/04/2011.
//  Copyright 2011 A Tasty Pixel. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

@interface TPKeyboardAvoidingTableView () <UITextFieldDelegate, UITextViewDelegate> {
    UIEdgeInsets _priorInset;
    BOOL _keyboardVisible;
    CGRect _keyboardRect;
}

@property(nonatomic, retain) NSMutableDictionary *delegateMap;

- (UIView *)findFirstResponderBeneathView:(UIView *)view;
- (UIEdgeInsets)contentInsetForKeyboard;
- (CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space;
- (CGRect)keyboardRect;
@end

@implementation TPKeyboardAvoidingTableView

@synthesize delegateMap = _delegateMap;

#pragma mark - Setup/Teardown

- (NSMutableDictionary *)delegateMap {
    if (!_delegateMap) {
        _delegateMap = [NSMutableDictionary dictionary];
    }
    return _delegateMap;
}

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self setup];
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)withStyle {
    if (!(self = [super initWithFrame:frame style:withStyle])) return nil;
    [self setup];
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_keyboardVisible) {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    if (_keyboardVisible) {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    [super setContentOffset:contentOffset animated:animated];
}


#pragma mark - Responders, events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self findFirstResponderBeneathView:self] resignFirstResponder];
    [super touchesEnded:touches withEvent:event];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardVisible = YES;

    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    if (!firstResponder) {
        // No child view is the first responder - nothing to do here
        return;
    }

    _priorInset = self.contentInset;

    // Shrink view's inset by the keyboard's height, and scroll to show the text field/view being edited
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];

    self.contentInset = [self contentInsetForKeyboard];
    [self setScrollIndicatorInsets:self.contentInset];

    [self setContentOffset:CGPointMake(self.contentOffset.x, [self idealOffsetForView:firstResponder withSpace:[self visibleSpace]])
                  animated:YES];

    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _keyboardRect = CGRectZero;
    _keyboardVisible = NO;

    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    if (!firstResponder) {
        // No child view is the first responder - nothing to do here
        return;
    }

    // Restore dimensions to prior size
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    self.contentInset = _priorInset;
    [self setScrollIndicatorInsets:self.contentInset];
    [UIView commitAnimations];
}

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![self focusNextTextField]) {
        [textField resignFirstResponder];
    }

    id delegateObject = [self originalDelegateOfTextField:textField];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegateObject textFieldShouldReturn:textField];
    }
    return YES;
}

- (id)originalDelegateOfTextField:(UITextField *)textField {
    return [self.delegateMap objectForKey:[self stringWithHashValueOf:textField]];
}

- (NSString *)stringWithHashValueOf:(UIView *)view {
    return [NSString stringWithFormat:@"%lu", (unsigned long)[view hash]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self scrollToActiveTextField];

    id delegateObject = [self originalDelegateOfTextField:textField];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        return [delegateObject textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id delegateObject = [self originalDelegateOfTextField:textField];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegateObject textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id delegateObject = [self originalDelegateOfTextField:textField];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegateObject textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id delegateObject = [self originalDelegateOfTextField:textField];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        return [delegateObject textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    id delegateObject = [self originalDelegateOfTextField:textField];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegateObject textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id delegateObject = [self originalDelegateOfTextField:textField];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegateObject textFieldShouldClear:textField];
    }
    return YES;
}

#pragma mark - - UITextView Delegates

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self scrollToActiveTextField];

    id delegateObject = [self originalDelegateOfTextView:textView];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [delegateObject textViewDidBeginEditing:textView];
    }
}

- (id)originalDelegateOfTextView:(UITextView *)textView {
    return [self.delegateMap objectForKey:[self stringWithHashValueOf:textView]];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    id delegateObject = [self originalDelegateOfTextView:textView];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [delegateObject textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    id delegateObject = [self originalDelegateOfTextView:textView];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [delegateObject textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    id delegateObject = [self originalDelegateOfTextView:textView];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textViewDidEndEditing:)]) {
        return [delegateObject textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    id delegateObject = [self originalDelegateOfTextView:textView];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [delegateObject textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    id delegateObject = [self originalDelegateOfTextView:textView];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textViewDidChange:)]) {
        [delegateObject textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    id delegateObject = [self originalDelegateOfTextView:textView];
    if (delegateObject && [delegateObject respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [delegateObject textViewDidChangeSelection:textView];
    }
}

#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initializeViewsBeneathView:self];
}

#pragma mark - Utilities

- (BOOL)focusNextTextField {
    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    if (!firstResponder) {
        return NO;
    }

    CGFloat minY = CGFLOAT_MAX;
    UIView *view = nil;
    [self findTextFieldAfterTextField:firstResponder beneathView:self minY:&minY foundView:&view];

    if (view) {
        [view becomeFirstResponder];
        return YES;
    }

    return NO;
}

- (void)scrollToActiveTextField {
    if (!_keyboardVisible) return;

    CGPoint idealOffset = CGPointMake(0, [self idealOffsetForView:[self findFirstResponderBeneathView:self] withSpace:[self visibleSpace]]);
    [self setContentOffset:idealOffset animated:YES];
}

#pragma mark - Helpers

- (BOOL)resignFirstResponder {
    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    return [firstResponder resignFirstResponder];
}

- (UIView *)findFirstResponderBeneathView:(UIView *)view {
    // Search recursively for first responder
    for (UIView *childView in view.subviews) {
        if ([childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder]) return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if (result) return result;
    }
    return nil;
}

- (void)findTextFieldAfterTextField:(UIView *)priorTextField beneathView:(UIView *)view minY:(CGFloat *)minY foundView:(UIView **)foundView {
    // Search recursively for text field or text view below priorTextField
    CGFloat priorFieldOffset = CGRectGetMinY([self convertRect:priorTextField.frame fromView:priorTextField.superview]);
    for (UIView *childView in view.subviews) {
        // Avoid hidden fields
        if (childView.hidden) {
            continue;
        }

        if (([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UITextView class]])) {
            // Avoid disabled fields
            if ([childView isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *) childView;
                if (textField.userInteractionEnabled == NO || textField.enabled == NO) {
                    continue;
                }
            }
            if ([childView isKindOfClass:[UITextView class]]) {
                UITextView *textView = (UITextView *) childView;
                if (textView.userInteractionEnabled == NO || textView.editable == NO) {
                    continue;
                }
            }

            CGRect frame = [self convertRect:childView.frame fromView:view];
            if (childView != priorTextField && CGRectGetMinY(frame) >= priorFieldOffset && CGRectGetMinY(frame) < *minY) {
                *minY = CGRectGetMinY(frame);
                *foundView = childView;
            }
        } else {
            [self findTextFieldAfterTextField:priorTextField beneathView:childView minY:minY foundView:foundView];
        }
    }
}

- (void)initializeViewsBeneathView:(UIView *)view {
    for (UIView *childView in view.subviews) {
        if (([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UITextView class]])) {
            [self initializeView:childView];
        } else {
            [self initializeViewsBeneathView:childView];
        }
    }
}

- (UIEdgeInsets)contentInsetForKeyboard {
    UIEdgeInsets newInset = self.contentInset;
    CGRect keyboardRect = [self keyboardRect];
    newInset.bottom = keyboardRect.size.height - ((keyboardRect.origin.y + keyboardRect.size.height) - (self.bounds.origin.y + self.bounds.size.height));
    return newInset;
}

- (CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space {
    // Convert the rect to get the view's distance from the top of the scrollView.
    CGRect rect = [view convertRect:view.bounds toView:self];

    // Set starting offset to that point
    CGFloat offset = rect.origin.y;

    // Center vertically if there's room
    if (view.bounds.size.height < space) {
        offset -= floor((space - view.bounds.size.height) / 2.0);
        //NSLog(@">2");
    }

    // Scroll to the bottom if edge exceeded
    if (offset + space > self.contentSize.height) {
        offset = self.contentSize.height - space;
        //NSLog(@">3");
    }

    if (offset < 0) offset = 0;

    // Adjust with the contentInset if there has been any.
    // This will solve the issues with ios7 and the fix is backward compatible.
    offset -= self.contentInset.top;

    return offset;
}

- (CGRect)keyboardRect {
    CGRect keyboardRect = [self convertRect:_keyboardRect fromView:nil];
    if (keyboardRect.origin.y == 0) {
        CGRect screenBounds = [self convertRect:[UIScreen mainScreen].bounds fromView:nil];
        keyboardRect.origin = CGPointMake(0, screenBounds.size.height - keyboardRect.size.height);
    }
    return keyboardRect;
}

- (void)initializeView:(UIView *)view {
    if (([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]])) {
        if ([(id) view delegate] && [(id) view delegate] != self) {
            [self.delegateMap setObject:[(id) view delegate] forKey:[self stringWithHashValueOf:view]];
        }
        [(id) view setDelegate:self];

        if ([view isKindOfClass:[UITextField class]]) {
            UIView *otherView = nil;
            CGFloat minY = CGFLOAT_MAX;
            [self findTextFieldAfterTextField:view beneathView:self minY:&minY foundView:&otherView];

            if (otherView) {
                ((UITextField *) view).returnKeyType = UIReturnKeyNext;
            } else {
                ((UITextField *) view).returnKeyType = UIReturnKeyDone;
            }
        }
    }
}


//- (void)adjustOffsetToIdealIfNeeded {
//    // Only do this if the keyboard is already visible
//    if (!_keyboardVisible) return;
//
//    CGPoint idealOffset = CGPointMake(0, [self idealOffsetForView:[self findFirstResponderBeneathView:self]
//                                                        withSpace:[self visibleSpace]]);
//    [self setContentOffset:idealOffset animated:YES];
//}

- (CGFloat)visibleSpace {
    CGFloat result = self.bounds.size.height - self.contentInset.top - self.contentInset.bottom;
    return result;
}

@end
