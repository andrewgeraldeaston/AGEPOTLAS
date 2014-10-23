//
//  DetailTaskViewController.m
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;
    NSLog(@"view did load detailtaskviewcontroller");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:   @"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dateLabel.text = stringFromDate;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([segue.destinationViewController isKindOfClass:[ EditTaskViewController class]]) {
        EditTaskViewController *editTaskViewController = segue.destinationViewController ;
        editTaskViewController.task  = self.task;
        editTaskViewController.delegate =self;
        
    }
    
} // transition to editTaskViewContoller (test by running program)


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didUpdateTask {
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.desc;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dateLabel.text = stringFromDate;
    
    //PUSH SEGUE *********** because we are in navigation stack
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTask];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:nil];
    
}

@end
