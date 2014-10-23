//
//  EditTaskViewController.m
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.tasklabelone.text = self.task.title;
    self.textView.text = self.task.description;
    self.datePicker.date = self.task.date;
    
    self.textView.delegate =self;
    self.tasklabelone.delegate = self;
    
    
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


- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    [self updateTask];
    [self.delegate didUpdateTask];
    
    
     //  READ THIS IMPORTANT  ------
    
     //  task object is held in the heap and we referenc from mutiple places and in fact in the editTaskViewController wehn we say self.task we are referencing the same task object as ViewController.m as specially inside the self.tasks Objects array it also pointing to the same task object so if we update that specifically task objects properties viewController.m its also have these properties updates
    
     // Dont need pass object back just alert 
    
    // ------------------------------
}


- (void)updateTask {
    
    self.task.desc = self.textView.text;
    self.task.title = self.tasklabelone.text;
    self.task.date = self.datePicker.date;
    
}

#pragma mark  - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField* ) textfield {
    
    [self.textView resignFirstResponder];
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
