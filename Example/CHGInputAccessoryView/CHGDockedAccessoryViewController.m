//
//  CHGViewController.m
//  CHGInputAccessoryView
//
//  Created by Christian on 08.01.16.
//  Copyright © 2016 Christian. All rights reserved.
//

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
    
    accessoryView.items = @[ trashItem,
                             [CHGInputAccessoryViewItem separatorWithColor:[UIColor lightGrayColor] height:20.f],
                             [CHGInputAccessoryViewItem buttonWithImage:[UIImage imageNamed:@"ic_search"]],
                             [CHGInputAccessoryViewItemTextField item] ];
    
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

@end
