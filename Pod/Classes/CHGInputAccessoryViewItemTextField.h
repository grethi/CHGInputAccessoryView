//
//  CHGInputAccessoryViewItemTextField.h
//  Pods
//
//  Created by Christian on 08.01.16.
//
//

#import <UIKit/UIKit.h>

#import "CHGInputAccessoryViewItem.h"

@interface CHGInputAccessoryViewItemTextField : CHGInputAccessoryViewItem

@property (nonatomic, readonly, retain) UITextField *textField;

+ (CHGInputAccessoryViewItemTextField *)item;

@end
