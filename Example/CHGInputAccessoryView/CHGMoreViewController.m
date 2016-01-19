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

#import "CHGMoreViewController.h"

#import "CHGInputAccessoryViewItemTextField.h"
#import "CHGInputAccessoryViewItemSwitch.h"

@implementation CHGMoreViewController {
    CHGInputAccessoryView *_accessoryView;
    NSTimer *_progressTimer;
}

- (void)viewDidLoad
{
    self.title = @"More Items";
    
    [self prepareInputAccessoryView];
}

- (void)prepareInputAccessoryView
{
    _accessoryView = [CHGInputAccessoryView inputAccessoryView];
    
    [_accessoryView setItems:@[ [CHGInputAccessoryViewItemTextField item],
                                [CHGInputAccessoryViewItemSwitch item] ]];
    
    _accessoryView.inputAccessoryViewDelegate = self;
    
    self.inputAccessoryView = _accessoryView;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)incrementProgress
{
    CGFloat newValue = _accessoryView.progressView.progress + 0.05f;
    _accessoryView.progressView.progress = newValue;
}

#pragma mark - CHGInputAccessoryViewDelegate

- (void)didTapItem:(CHGInputAccessoryViewItem *)item
{
    NSLog(@"Tapped item...");
    
    if ([item isKindOfClass:[CHGInputAccessoryViewItemSwitch class]]) {
        CHGInputAccessoryViewItemSwitch *switchItem = (CHGInputAccessoryViewItemSwitch *)item;
        
        if (switchItem.switchView.on) {
            _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(incrementProgress) userInfo:nil repeats:YES];
        } else {
            [_progressTimer invalidate];
            _accessoryView.progressView.progress = 0.f;
        }
    }
}

- (void)didTapItemAtIndex:(NSUInteger)index
{
    NSLog(@"Tapped item at index %lu...", (unsigned long)index);
}

@end
