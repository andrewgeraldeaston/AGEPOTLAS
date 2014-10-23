//
//  ViewController.h
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"

#define TASK_TITLE @"tasktitle"
#define TASK_DESC @"taskdesc"
#define TASK_DATE @"taskdate"
#define TASK_COMPLETION @"taskcompletion"
#define TASK_OBJECTS_KEY @"taskobjectskey"


@interface ViewController : UIViewController <AddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate,DetailTaskViewContollerDelegate>

@property (strong,nonatomic) NSMutableArray *taskObjects;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBarButtonPressed:(UIButton *)sender;

- (IBAction)addTaskBarButtonPressed:(UIButton *)sender;

@end

