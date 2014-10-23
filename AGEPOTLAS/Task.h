//
//  Task.h
//  AGEPOTLAS
//
//  Created by Andrew Easton on 13/10/2014.
//  Copyright (c) 2014 IOS7Course-age. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *desc;
@property(strong,nonatomic) NSDate *date;
@property(nonatomic) BOOL *isCompleted;  //not using strong means a primative

-(id)initWithData:(NSDictionary *)data;

@end
