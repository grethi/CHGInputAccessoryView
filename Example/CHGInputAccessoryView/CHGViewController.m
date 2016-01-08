//
//  CHGViewController.m
//  CHGInputAccessoryView
//
//  Created by Christian on 01/04/2016.
//  Copyright (c) 2016 Christian. All rights reserved.
//

#import "CHGViewController.h"

@interface CHGViewController ()

@end

@implementation CHGViewController {
    UILabel *_label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CHGInputAccessoryView *accessoryView = [CHGInputAccessoryView inputAccesoryViewWithHeigth:35.f];
    
    accessoryView.delegate = self;
    accessoryView.textField.placeholder = @"Enter your text...";
    
    accessoryView.leftButton = [[UIButton alloc] init];
    [accessoryView.leftButton setImage:[UIImage imageNamed:@"ic_trash"] forState:UIControlStateNormal];
    [accessoryView.leftButton addTarget:self action:@selector(didTapAccessoryViewLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    ((CHGView *)self.view).inputAccessoryView = accessoryView;
    
    self.inputAccessoryView = accessoryView;
    
    [self initButton];
    [self initLabel];
}

- (void)initButton
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"Tap me!" forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
    
    button.center = CGPointMake(self.view.center.x, 50);
    
    [self.view addSubview:button];
}

- (void)initLabel
{
    _label = [[UILabel alloc] init];
    [_label setTextColor:[UIColor blackColor]];
    
    [self.view addSubview:_label];
}

- (void)updateLabelWithText:(NSString *)text
{
    [_label setText:text];
    [_label sizeToFit];
    _label.center = CGPointMake(self.view.center.x, 100);
}

#pragma mark - Actions

- (BOOL)canBecomeFirstResponder {
    return true;
}

- (void)didTapAccessoryViewLeftButton:(UIButton *)button
{
    [_label setText:@""];
}

- (void)didTapButton
{
    CHGInputAccessoryView *accessoryView = (CHGInputAccessoryView *)self.view.inputAccessoryView;
    if (!accessoryView.isVisible) {
        [self.view becomeFirstResponder];
    } else {
        [accessoryView.leftButton setImage:[UIImage imageNamed:@"ic_info"] forState:UIControlStateNormal];
    }
    
    [self.view becomeFirstResponder];
}

#pragma mark - CHGInputAccessoryViewDelegate

- (BOOL)willCancelWithText:(NSString *)text
{
    [self updateLabelWithText:text];
    return YES;
}

- (BOOL)willReturnWithText:(NSString *)text
{
    [self updateLabelWithText:text];
    return YES;
}

- (BOOL)willChangeText:(NSString *)text replaceText:(NSString *)replaceText charactersInRange:(NSRange)range
{
    NSString *newText = [text stringByReplacingCharactersInRange:range withString:replaceText];
    
    CHGInputAccessoryView *accessoryView = (CHGInputAccessoryView *)self.view.inputAccessoryView;
    if ([newText isEqualToString:@""]) {
        [accessoryView.rightButton setTitle:@"Cancel" forState:UIControlStateNormal];
    } else {
        [accessoryView.rightButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    
    [self updateLabelWithText:newText];
    
    return YES;
}

@end
