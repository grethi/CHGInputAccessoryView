//
//  CHGInputAccessoryViewItemTextField.m
//  Pods
//
//  Created by Christian on 08.01.16.
//
//

#import "CHGInputAccessoryViewItemTextField.h"

@implementation CHGInputAccessoryViewItemTextField

@synthesize textField = _textField;

+ (CHGInputAccessoryViewItemTextField *)item
{
    return [[CHGInputAccessoryViewItemTextField alloc] initWithCustomView:[[UITextField alloc] init]];
}

- (id)initWithCustomView:(UIView *)customView
{
    NSAssert([customView isKindOfClass:[UITextField class]], @"customView must be of class UITextField.");
    
    self = [super initWithCustomView:customView];
    
    if (self) {
        self.flexibleSize = YES;
        
        _textField = (UITextField *)customView;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

@end
