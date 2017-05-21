// Copyright (c) 2017 Christian Greth <greth.christian@googlemail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CHGInputAccessoryViewItemTextField.h"

@implementation CHGInputAccessoryViewItemTextField

@synthesize textField = _textField;

+ (CHGInputAccessoryViewItemTextField *)item
{
    return [[CHGInputAccessoryViewItemTextField alloc] initWithCustomView:[[UITextField alloc] init]];
}

+ (CHGInputAccessoryViewItemTextField *)itemWithDelegate:(id<UITextFieldDelegate>)delegate
{
    CHGInputAccessoryViewItemTextField *item = [[CHGInputAccessoryViewItemTextField alloc] initWithCustomView:[[UITextField alloc] init]];
    item.textField.delegate = delegate;
    
    return item;
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

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [_textField setEnabled:enabled];
}

- (BOOL)isEnabled
{
    return _textField.isEnabled;
}

@end
