//
//  DetailTaskViewController.h
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "EditTaskViewController.h" // in the .h because we are going to use a delegate


@protocol DetailTaskViewContollerDelegate <NSObject>

-(void)updateTask;

@end



@interface DetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>

@property (strong, nonatomic) Task *task; // allow to create a property of task. WHY - when i create the instance of detailviewcontroller prepareforsegue PASS in the object the user has selected (pass to detailveiwcontroller so i can display this information

@property  (weak, nonatomic) id <DetailTaskViewContollerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;


@end
