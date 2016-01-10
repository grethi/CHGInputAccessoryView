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

@implementation CHGInputAccessoryView

+ (id)inputAccessoryView
{
    return [[CHGInputAccessoryView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth([UIScreen mainScreen].bounds), 44.f)];
}

+ (id)inputAccessoryViewWithHeight:(CGFloat)height
{
    return [[CHGInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), height)];
}

+ (id)inputAccessoryViewTextFieldWithButtonTitle:(NSString *)title textFieldDelegate:(id)delegate
{
    CHGInputAccessoryView *accessoryView = [CHGInputAccessoryView inputAccessoryView];
    
    CHGInputAccessoryViewItemTextField *textFieldItem = [CHGInputAccessoryViewItemTextField item];
    textFieldItem.textField.delegate = delegate;
    
    [accessoryView setItems:@[ textFieldItem,
                               [CHGInputAccessoryViewItem buttonWithTitle:title] ]];
    
    return accessoryView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth);
    }
    
    return self;
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

- (void)layoutSubviews
{
    NSMutableArray *flexibleWidthItems = [[NSMutableArray alloc] init];
    CGFloat itemWidth = 0.f;
    CGFloat itemMargin = 16.f;
    for (UIBarButtonItem *item in self.items) {
        if ([item isKindOfClass:[CHGInputAccessoryViewItem class]]) {
            if (((CHGInputAccessoryViewItem *)item).flexibleSize) {
                [flexibleWidthItems addObject:item];
            } else {
                UIView *itemView = [item valueForKey:@"view"];
                itemWidth += CGRectGetWidth(itemView.bounds) + itemMargin;
            }
        }
    }
    
    if (flexibleWidthItems.count > 0) {
        CGFloat flexItemWidth = (CGRectGetWidth(self.bounds) - itemWidth) / flexibleWidthItems.count - itemMargin;
        
        for (CHGInputAccessoryViewItem *item in flexibleWidthItems) {
            item.customView.frame = CGRectMake(0, 0, flexItemWidth, CGRectGetHeight(self.bounds) - itemMargin);
        }
    }
    
    [super layoutSubviews];
}

@end
