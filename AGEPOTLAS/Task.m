//
//  Task.m
//  AGEPOTLAS
//
//  Created by Andrew Easton on 13/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//


//custom initiatlizers with VALUES is of great benefit


#import "Task.h"
#import "ViewController.h"


@implementation Task


-(id)initWithData:(NSDictionary *)data {
    
    self = [super init];
    
    if (self)
    {
        
        self.title = data[TASK_TITLE];
        self.desc= data[TASK_DESC];
        self.date= data[TASK_DATE];
        self.isCompleted = [data [ TASK_COMPLETION] boolValue];
        
    }
    
    return self;
    
}


-(id)init{
    
    self =[self initWithData:nil];
    return self;
    
}

@end
