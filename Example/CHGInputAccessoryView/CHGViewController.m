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

#import "CHGViewController.h"

#import "CHGView.h"

@implementation CHGViewController {
    CHGInputAccessoryViewItemTextField *_textFieldItem;
}

- (void)viewDidLoad
{
    self.title = @"On View";
    
    UIButton *show = [[UIButton alloc] init];
    [show setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [show setTitle:@"Show accessoryView!" forState:UIControlStateNormal];
    [show sizeToFit];
    [show addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    show.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:show];
    
    UIButton *showWithKeyboard = [[UIButton alloc] init];
    [showWithKeyboard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showWithKeyboard setTitle:@"Show accessoryView with keyboard!" forState:UIControlStateNormal];
    [showWithKeyboard sizeToFit];
    [showWithKeyboard addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    showWithKeyboard.center = CGPointMake(self.view.center.x, 150);
    showWithKeyboard.tag = 99;
    [self.view addSubview:showWithKeyboard];
    
    UIButton *hide = [[UIButton alloc] init];
    [hide setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hide setTitle:@"Hide accessoryView!" forState:UIControlStateNormal];
    [hide sizeToFit];
    [hide addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    hide.center = CGPointMake(self.view.center.x, 200);
    hide.tag = 98;
    [self.view addSubview:hide];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"On Controller" style:UIBarButtonItemStylePlain target:self action:@selector(didTapButton:)];
    
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
    
    _textFieldItem = [CHGInputAccessoryViewItemTextField item];
    _textFieldItem.textField.delegate = self;
    
    accessoryView.items = @[ trashItem,
                             [CHGInputAccessoryViewItem separatorWithColor:[UIColor lightGrayColor] height:20.f],
                             [CHGInputAccessoryViewItem buttonWithImage:[UIImage imageNamed:@"ic_search"]],
                             _textFieldItem ];
    
    [accessoryView addItem:infoItem animated:NO];
    
    CHGView *view = (CHGView *)self.view;
    view.inputAccessoryView = accessoryView;
}

- (void)didTapButton:(id)button
{
    if ([button isKindOfClass:[UIBarButtonItem class]]) {
        [self performSegueWithIdentifier:@"dockedAccessoryView" sender:self];
        return;
    }
    
    if (((UIButton *)button).tag == 98) {
        [_textFieldItem.textField resignFirstResponder];
        [((CHGView *)self.view) resignFirstResponder];
        return;
    }
    
    [((CHGView *)self.view) becomeFirstResponder];
    
    if (((UIButton *)button).tag == 99) {
        [_textFieldItem.textField becomeFirstResponder];
    }
}

- (void)didTapInfoItem:(CHGInputAccessoryViewItem *)item
{
    NSLog(@"Tapped infoItem...");
    
    CHGInputAccessoryView *accessoryView = (CHGInputAccessoryView *)self.inputAccessoryView;
    
    [accessoryView removeItem:item animated:YES];
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

@end
