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

#import "CHGInputAccessoryView.h"
#import "CHGInputAccessoryViewItemSwitch.h"

@implementation CHGInputAccessoryViewItemSwitch

@synthesize switchView = _switchView;

+ (CHGInputAccessoryViewItemSwitch *)item
{
    return [[CHGInputAccessoryViewItemSwitch alloc] initWithCustomView:[[UISwitch alloc] init]];
}

- (id)initWithCustomView:(UIView *)customView
{
    NSAssert([customView isKindOfClass:[UISwitch class]], @"customView must be of class UISwitch.");
    
    self = [super initWithCustomView:customView];
    
    if (self) {
        
        _switchView = (UISwitch *)customView;
        [_switchView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void)valueChanged:(UISwitch *)switchView
{
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:self afterDelay:0.f];
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [_switchView setEnabled:enabled];
}

- (BOOL)isEnabled
{
    return _switchView.isEnabled;
}

@end
