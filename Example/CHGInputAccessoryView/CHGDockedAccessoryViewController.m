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

#import "CHGDockedAccessoryViewController.h"

@implementation CHGDockedAccessoryViewController

- (void)viewDidLoad
{
    self.title = @"On Controller";
    
    [self prepareInputAccessoryView];
}

- (void)prepareInputAccessoryView
{
    CHGInputAccessoryView *accessoryView = [CHGInputAccessoryView inputAccessoryView];
    
    accessoryView.inputAccessoryViewDelegate = self;
    
    CHGInputAccessoryViewItem *trashItem = [CHGInputAccessoryViewItem buttonWithImage:[UIImage imageNamed:@"ic_trash"]];
    
    trashItem.actionOnTap = ^(CHGInputAccessoryViewItem *item){
        NSLog(@"Tapped trashItem...");
    };
    
    CHGInputAccessoryViewItem *infoItem = [CHGInputAccessoryViewItem buttonWithImage:[UIImage imageNamed:@"ic_info"]];
    infoItem.target = self;
    infoItem.action = @selector(didTapInfoItem:);
    
    CHGInputAccessoryViewItemTextField *textFieldItem = [CHGInputAccessoryViewItemTextField item];
    textFieldItem.textField.delegate = self;
    
    accessoryView.items = @[ trashItem,
                             [CHGInputAccessoryViewItem separatorWithColor:[UIColor lightGrayColor] height:20.f],
                             [CHGInputAccessoryViewItem buttonWithImage:[UIImage imageNamed:@"ic_search"]],
                             textFieldItem ];
    
    [accessoryView addItem:infoItem animated:NO];
    
    self.inputAccessoryView = accessoryView;
}

- (void)didTapInfoItem:(CHGInputAccessoryViewItem *)item
{
    NSLog(@"Tapped infoItem...");
    
    [((CHGInputAccessoryView *)self.inputAccessoryView) removeItem:item animated:YES];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - CHGInputAccessoryViewDelegate

- (void)didTapItem:(CHGInputAccessoryViewItem *)item
{
    NSLog(@"Tapped item...");
}

- (void)didTapItemAtIndex:(NSUInteger)index
{
    NSLog(@"Tapped item at index %lu...", (unsigned long)index);
}

# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self becomeFirstResponder];
    
    return YES;
}

@end
