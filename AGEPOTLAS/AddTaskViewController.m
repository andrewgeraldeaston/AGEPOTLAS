//
//  AddTaskViewController.m
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView.delegate = self;
    self.textField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(Task *)returnNewTaskObject
{
    Task *taskObject =[[Task alloc] init];
    taskObject.title = self.textField.text;
    taskObject.desc = self.textView.text;
    taskObject.date = self.datePicker.date;
    taskObject.isCompleted = NO;
    
    return taskObject;

}

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    
    NSLog(@"Am i getting here ");
    [self.delegate didAddTask:[self returnNewTaskObject]];
     
}


- (IBAction)cancelButtonPressed:(UIButton *)sender { //Press this and segue back.
     // NSLog(@"Did i get here");
    [self.delegate didCancel];
     // NSLog(@"After self delegate");
    
}

#pragma mark  - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField* ) textfield {

    [self.textField resignFirstResponder];
    return YES;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
     
        [self.textView resignFirstResponder];
        return NO;
        
        
    }
    return YES;
}
@end
