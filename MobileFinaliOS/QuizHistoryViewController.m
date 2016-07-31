//
//  QuizHistoryViewController.m
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/30.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import "QuizHistoryViewController.h"
#import "Util.h"
#import "QuizDetail.h"

@implementation QuizHistoryViewController{
    NSMutableDictionary *course;
    NSMutableArray *courseQuizs;
    NSString *quizUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Course Quiz";
    
    courseQuizs = [[NSMutableArray alloc] init];
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [courseQuizs removeAllObjects];
    if(course != nil){
        [self fetchCourseQuiz:[course objectForKey:@"courseId"]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [courseQuizs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuizCell" ];
    cell.textLabel.text = [[courseQuizs objectAtIndex:indexPath.row] objectForKey:@"quizName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    quizUrl = [[courseQuizs objectAtIndex:indexPath.row] objectForKey:@"url"];
    [self performSegueWithIdentifier:@"quizDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString: @"quizDetail"]) {
        [(QuizDetail *)[segue destinationViewController] setUrl:quizUrl];
    }
    // Pass the selected object to the new view controller.
    
}


-(void) fetchCourseQuiz:(NSNumber *) courseId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject: [courseId stringValue] forKey:@"courseId"];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"getQuizByCourseId" params:params];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                if(error == nil){
                                                    courseQuizs = [[NSJSONSerialization
                                                                   JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments error:nil] mutableCopy];
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.tableView reloadData];
                                                    });
                                                    NSLog(@"%@", [Util showNSData:data]);
                                                }
                                                
                                                
                                                NSLog(@"%@", [response description]);
                                                
                                            }];
    
    [task resume];

}

- (void) setSelectCourse: (id) selectCourse{
    course = selectCourse;
}

@end
