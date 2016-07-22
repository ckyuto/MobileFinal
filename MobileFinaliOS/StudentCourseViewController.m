//
//  StudentCourseViewController.m
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/21.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import "StudentCourseViewController.h"
#import "Util.h"

@implementation StudentCourseViewController
{
    NSMutableArray *courseName;
    NSMutableArray *courseNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    courseName = [[NSMutableArray alloc] init];
    courseNumber = [[NSMutableArray alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchCourse];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [courseName count];
}

-(void) fetchCourse{
    NSMutableDictionary* userDict = [Util getUserDict];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"getRegistedCourse" params:userDict];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                
                                                                                        
                                                NSLog(@"%@", [error description]);
                                                NSLog(@"NSDATA %@", [Util showNSData:data]);
                                                NSLog(@"%@", @"get registered course success!");
                                            }];
    
    [task resume];
}

@end
