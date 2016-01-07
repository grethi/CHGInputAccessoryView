//
//  CHGView.m
//  Pods
//
//  Created by Christian on 05.01.16.
//
//

#import "CHGView.h"

@implementation CHGView

- (BOOL)canBecomeFirstResponder {
    return true;
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    [self.inputAccessoryView resignFirstResponder];
    return true;
}

- (BOOL)becomeFirstResponder
{
    //[super becomeFirstResponder];
    //[self.inputAccessoryView becomeFirstResponder];
    return true;
}

@end
