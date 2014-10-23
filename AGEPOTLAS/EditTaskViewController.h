//
//  EditTaskViewController.h
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"


@protocol EditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end



@interface EditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) Task *task;
@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *tasklabelone;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveButtonPressed:(UIButton *)sender;

@end
