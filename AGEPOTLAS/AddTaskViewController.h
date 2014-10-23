//
//  AddTaskViewController.h
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"


@protocol AddTaskViewControllerDelegate <NSObject>;

- (void)didCancel;
- (void)didAddTask:(Task *)task;

@end


@interface AddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>;

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate; 

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;


@end
