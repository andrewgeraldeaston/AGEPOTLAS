//
//  ViewController.m
//  AGEPOTLAS
//
//  Created by Andrew Easton on 09/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

-(NSMutableArray *)taskObjects
{
    
    if (!_taskObjects){
        
        _taskObjects = [[NSMutableArray alloc]init];
        
    }
    return _taskObjects;
} // lazy instationation


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self; //table view protocol knows where to send messages to me - tableview source to self
    self.tableView.delegate = self;
    
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY]; // if there is info saved task objects we are goign to be able to access the data
    
    for (NSDictionary *dictionary in tasksAsPropertyLists) {
        Task *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
} // array self.taskObjects that can get all the task objects from NSUserdefaults because we are doing this in ViewDownload  - see helper methods.


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"Prepare for Segue -start ");
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]){
        AddTaskViewController *addTaskViewController = segue.destinationViewController ;
        addTaskViewController.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]]) {
        DetailTaskViewController *detailTaskViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        Task *taskObject = self.taskObjects[path.row];
        detailTaskViewController.task = taskObject;
        detailTaskViewController.delegate = self;
        
        NSLog(@"Prepare for Segue -end ");
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonPressed:(UIButton *)sender {
    
    if (self.tableView.editing == YES) [self.tableView setEditing:NO animated:YES];
    else [self.tableView setEditing:YES animated:YES];
    
}


- (IBAction)addTaskBarButtonPressed:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
    
}


#pragma mark - AddTaskViewController Delegate


- (void)didAddTask:(Task *)task  {
    
    [self.taskObjects addObject:task];
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[ NSUserDefaults standardUserDefaults ] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsApropertyist:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
}

- (void)didCancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - DetailViewControllerDelegate


-(void)updateTask {
    
    [self saveTasks];
    [self.tableView reloadData];
    
}

#pragma mark - helper methods

-(NSDictionary *)taskObjectAsApropertyist:(Task *)taskObject {
    
    NSLog(@"NSDictinary Method");
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESC:taskObject.desc, TASK_DATE : taskObject.date };
    NSLog(@"NSDictinary Method - just before returning dictionary");
    return dictionary;
    
}

-(Task *)taskObjectForDictionary:(NSDictionary *)dictionary {
    NSLog(@" Just entered Task method ");
    Task *taskObject = [[Task alloc] initWithData:dictionary];
    NSLog(@" Just about to return the Task method ");
    return taskObject;
    
} // convert dictionary so we can return a task from thie method


-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate {

    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval) return YES;
    else return NO;

}


-(void)updateCompletionOfTask:(Task *)task forIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.isCompleted == YES) task.isCompleted = NO;
    else task.isCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsApropertyist:task] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
}

-(void)saveTasks {
    
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x= 0; x<[self.taskObjects count]; x++) {
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsApropertyist:self.taskObjects[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    

} // go the video and look for this helper method

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.taskObjects count];
}

// ----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// ----


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    //Configure Cell
    
    Task *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];// convert into a NSDate into a string
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    
    if (task.isCompleted == YES) cell.backgroundColor = [UIColor greenColor];
    else if (isOverDue == YES) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    
    return cell;

}

// -----


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Task *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc]init]; // persist the deletion
        
        for (Task *task in self.taskObjects){
            [newTaskObjectsData addObject:[self taskObjectAsApropertyist:task]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];  //[indexPath] = create an array with the literal syntax.
         
    }
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toDetailTaskViewControllerSegue" sender:indexPath];
    
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Task *taskObject = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    [self saveTasks]; // save and persist the information in this method
}

@end












