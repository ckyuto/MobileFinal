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
    NSMutableArray *courseNames;
    NSMutableArray *courseNumbers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    courseNames = [[NSMutableArray alloc] init];
    courseNumbers = [[NSMutableArray alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [courseNames removeAllObjects];
    [courseNumbers removeAllObjects];
    [self fetchCourse];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [courseNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" ];
    cell.textLabel.text = [courseNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [courseNumbers objectAtIndex:indexPath.row];
    return cell;
}


-(void) fetchCourse{
    NSMutableDictionary* userDict = [Util getUserDict];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"getRegisteredCourse" params:userDict];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSArray *courseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                                if(courseData){
                                                    for (NSDictionary *status in courseData){
                                                        [courseNames addObject:[status objectForKey:@"courseName"]];
                                                        [courseNumbers addObject:[status objectForKey:@"courseNumber"]];
                                                    }
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.tableView reloadData];
                                                        
                                                    });
                                                    NSLog(@"%@", @"get registered course success!");
                                                }
                                            }];
    
    [task resume];
}

@end
