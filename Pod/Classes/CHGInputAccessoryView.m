//
//  CHGInputAccessoryView.m
//  Pods
//
//  Created by Christian on 08.01.16.
//
//

#import "CHGInputAccessoryView.h"

@implementation CHGInputAccessoryView

+ (id)inputAccessoryView
{
    return [[CHGInputAccessoryView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth([UIScreen mainScreen].bounds), 44.f)];
}

+ (id)inputAccessoryViewWithHeight:(CGFloat)height
{
    return [[CHGInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), height)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth);
        
    }
    
    return self;
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
