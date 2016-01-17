// Copyright (c) 2016 Christian Greth <greth.christian@googlemail.com>
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

#import "CHGInputAccessoryViewItemTextView.h"

@implementation CHGInputAccessoryViewItemTextView {
    NSLayoutConstraint *_heightConstraint;
}

@synthesize textView = _textView;

+ (CHGInputAccessoryViewItemTextView *)item
{
    return [[CHGInputAccessoryViewItemTextView alloc] initWithCustomView:[[UITextView alloc] init]];
}

+ (CHGInputAccessoryViewItemTextView *)itemWithDelegate:(id<UITextViewDelegate>)delegate
{
    CHGInputAccessoryViewItemTextView *item = [[CHGInputAccessoryViewItemTextView alloc] initWithCustomView:[[UITextView alloc] init]];
    item.textView.delegate = delegate;
    
    return item;
}

- (id)initWithCustomView:(UIView *)customView
{
    NSAssert([customView isKindOfClass:[UITextView class]], @"customView must be of class UITextView.");
    
    self = [super initWithCustomView:customView];
    
    if (self) {
        self.flexibleSize = YES;
        
        _textView = (UITextView *)customView;
        
        // textView setting
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        _textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        // textView styling
        _textView.layer.borderColor = [[UIColor grayColor] CGColor];
        _textView.layer.borderWidth = 0.5f;
        _textView.layer.cornerRadius = 5.f;
        _textView.clipsToBounds = YES;
        
        // textView sizing
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeChanged) name:UITextViewTextDidChangeNotification object:_textView];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_textView];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [_textView setEditable:enabled];
}

- (BOOL)isEnabled
{
    return _textView.isEditable;
}

- (void)contentSizeChanged
{
    CHGInputAccessoryView *accessoryView = (CHGInputAccessoryView *)[self.customView superview];
    
    [accessoryView updateHeight];
}

- (CGFloat)preferredHeight
{
    return _textView.contentSize.height;
}

- (void)resizeToHeight:(CGFloat)height
{
    [super resizeToHeight:height];
    
    if (height >= _textView.contentSize.height) {
        [_textView scrollRangeToVisible:NSMakeRange(0, 0)];
        return;
    }
    
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length - 1, 1)];
}

@end
