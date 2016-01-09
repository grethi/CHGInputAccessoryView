//
//  CHGInputAccessoryViewItem.m
//  Pods
//
//  Created by Christian on 08.01.16.
//
//

#import "CHGInputAccessoryViewItem.h"

@implementation CHGInputAccessoryViewItem

+ (id)fixedSpace:(CGFloat)width
{
    CHGInputAccessoryViewItem *fixedSpace = [[CHGInputAccessoryViewItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    
    return fixedSpace;
}

+ (id)flexibleSpace
{
    CHGInputAccessoryViewItem *flexibleSpace = [[CHGInputAccessoryViewItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    return flexibleSpace;
}

+ (CHGInputAccessoryViewItem *)buttonWithImage:(UIImage *)image
{
    CHGInputAccessoryViewItem *button = [[CHGInputAccessoryViewItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    
    return button;
}

+ (CHGInputAccessoryViewItem *)separatorWithColor:(UIColor *)color height:(CGFloat)height
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.f, height)];
    view.backgroundColor = color;
    
    CHGInputAccessoryViewItem *separator = [[CHGInputAccessoryViewItem alloc] initWithCustomView:view];
    
    return separator;
}

- (BOOL)becomeFirstRsponder
{
    return NO;
}

@end
