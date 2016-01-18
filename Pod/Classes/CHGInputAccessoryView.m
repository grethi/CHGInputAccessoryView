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

#import "CHGInputAccessoryViewItemTextField.h"
#import "CHGInputAccessoryViewItemTextView.h"

@implementation CHGInputAccessoryView {
    UIProgressView *_progressView;
    CGFloat _itemMargin;
}

+ (id)inputAccessoryView
{
    return [[CHGInputAccessoryView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth([UIScreen mainScreen].bounds), 44.f)];
}

+ (id)inputAccessoryViewWithHeight:(CGFloat)height
{
    return [[CHGInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), height)];
}

+ (id)inputAccessoryViewTextFieldWithButtonTitle:(NSString *)title textFieldDelegate:(id<UITextFieldDelegate>)delegate
{
    CHGInputAccessoryView *accessoryView = [CHGInputAccessoryView inputAccessoryView];
    
    CHGInputAccessoryViewItemTextField *textFieldItem = [CHGInputAccessoryViewItemTextField item];
    textFieldItem.textField.delegate = delegate;
    
    [accessoryView setItems:@[ textFieldItem,
                               [CHGInputAccessoryViewItem buttonWithTitle:title] ]];
    
    return accessoryView;
}

+ (id)inputAccessoryViewTextViewWithButtonTitle:(NSString *)title textViewDelegate:(id<UITextViewDelegate>)delegate
{
    CHGInputAccessoryView *accessoryView = [CHGInputAccessoryView inputAccessoryViewWithHeight:46.f];
    
    CHGInputAccessoryViewItemTextView *textViewItem = [CHGInputAccessoryViewItemTextView item];
    textViewItem.textView.delegate = delegate;
    
    [accessoryView setItems:@[ textViewItem,
                               [CHGInputAccessoryViewItem buttonWithTitle:title] ]];
    
    return accessoryView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth);
        
        self.defaultHeight = CGRectGetHeight(frame);
        self.maxHeight = 150.f;
        
        _itemMargin = 8.f;
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
        _progressView.progressViewStyle = UIProgressViewStyleBar;
        [self addSubview:_progressView];
    }
    
    return _progressView;
}

- (BOOL)isVisible
{
    return self.superview ? YES : NO;
}

- (CHGInputAccessoryViewItem *)itemAtIndex:(NSUInteger)index
{
    return (CHGInputAccessoryViewItem *)[self.items objectAtIndex:index];
}

- (void)setItems:(NSArray<CHGInputAccessoryViewItem *> *)items
{
    [self setItems:items animated:NO];
}

- (void)setItems:(NSArray<CHGInputAccessoryViewItem *> *)items animated:(BOOL)animated
{
    for (CHGInputAccessoryViewItem *item in items) {
        if (!item.target) {
            item.target = self;
            item.action = @selector(didTapItem:);
        }
    }
    
    [super setItems:items animated:animated];
}

- (void)addItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated
{
    [self addItem:item atIndex:self.items.count animated:animated];
}

- (void)addItem:(CHGInputAccessoryViewItem *)item atIndex:(NSUInteger)index animated:(BOOL)animated
{
    NSMutableArray *items = [self.items mutableCopy];
    [items insertObject:item atIndex:index];
    
    NSArray *newItems = [NSArray arrayWithArray:items];
    
    [self setItems:newItems animated:animated];
}

- (void)removeItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated
{
    [self removeItemAtIndex:[self.items indexOfObject:item] animated:animated];
}

- (void)removeItemAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    NSMutableArray *items = [self.items mutableCopy];
    [items removeObjectAtIndex:index];
    
    NSArray *newItems = [NSArray arrayWithArray:items];
    
    [self setItems:newItems animated:animated];
}

- (void)enableItem:(CHGInputAccessoryViewItem *)item
{
    [item setEnabled:YES];
}

- (void)enableItemAtIndex:(NSUInteger)index
{
    CHGInputAccessoryViewItem *item = (CHGInputAccessoryViewItem *)[self.items objectAtIndex:index];
    [self enableItem:item];
}

- (void)disableItem:(CHGInputAccessoryViewItem *)item
{
    [item setEnabled:NO];
}

- (void)disableItemAtIndex:(NSUInteger)index
{
    CHGInputAccessoryViewItem *item = (CHGInputAccessoryViewItem *)[self.items objectAtIndex:index];
    [self disableItem:item];
}

- (void)updateHeight
{
    CGFloat newHeight = [self maxItemHeight] + 2 * _itemMargin;
    
    if (newHeight > CGRectGetHeight(self.frame)) {
        if (newHeight > self.maxHeight) newHeight = self.maxHeight;
        [self resizeToHeight:newHeight];
        return;
    }
    
    if (newHeight < CGRectGetHeight(self.frame)) {
        if (newHeight < self.defaultHeight) newHeight = self.defaultHeight;
        [self resizeToHeight:newHeight];
        return;
    }
}

- (void)resizeToHeight:(CGFloat)height
{
    for (NSLayoutConstraint *constraint in [self constraints]) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = height;
            [self layoutSubviews];
            break;
        }
    }
}

- (void)layoutSubviews
{
    NSMutableArray *flexibleSizeItems = [[NSMutableArray alloc] init];
    CGFloat itemWidth = 0.f;
    CGFloat itemMargin = _itemMargin * 2;
    for (UIBarButtonItem *item in self.items) {
        if ([item isKindOfClass:[CHGInputAccessoryViewItem class]]) {
            if (((CHGInputAccessoryViewItem *)item).flexibleSize) {
                [flexibleSizeItems addObject:item];
            } else {
                UIView *itemView = [item valueForKey:@"view"];
                itemWidth += CGRectGetWidth(itemView.frame) + itemMargin;
            }
        }
    }
    
    if (flexibleSizeItems.count > 0) {
        CGFloat flexItemWidth = (CGRectGetWidth(self.frame) - itemWidth) / flexibleSizeItems.count - itemMargin;
        
        for (CHGInputAccessoryViewItem *item in flexibleSizeItems) {
            CGRect frame = item.customView.frame;
            frame.size.width = flexItemWidth;
            item.customView.frame = frame;
            
            [item resizeToHeight:(CGRectGetHeight(self.bounds) - 2 * _itemMargin)];
        }
    }
    
    [super layoutSubviews];
}

#pragma mark - pivate

- (CGFloat)maxItemHeight
{
    CGFloat height = 0.f;
    
    for (CHGInputAccessoryViewItem *item in self.items) {
        if (item.preferredHeight > height) height = item.preferredHeight;
    }
    
    return height;
}

- (void)didTapItem:(CHGInputAccessoryViewItem *)item
{
    if (item.actionOnTap) {
        item.actionOnTap(item);
    }
    
    if ([self.inputAccessoryViewDelegate respondsToSelector:@selector(didTapItem:)]) {
        [self.inputAccessoryViewDelegate didTapItem:item];
    }
    
    if ([self.inputAccessoryViewDelegate respondsToSelector:@selector(didTapItemAtIndex:)]) {
        
        NSUInteger index = [self.items indexOfObject:item];
        [self.inputAccessoryViewDelegate didTapItemAtIndex:index];
    }
}

@end