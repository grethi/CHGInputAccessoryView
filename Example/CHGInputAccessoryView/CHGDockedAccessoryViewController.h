//
//  CHGViewController.h
//  CHGInputAccessoryView
//
//  Created by Christian on 08.01.16.
//  Copyright © 2016 Christian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CHGInputAccessoryView.h"
#import "CHGInputAccessoryViewItemTextField.h"

@interface CHGDockedAccessoryViewController : UIViewController <CHGInputAccessoryViewDelegate>

@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;

@end