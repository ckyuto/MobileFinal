//
//  AbsenceList.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/31/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "AbsenceList.h"
#import "Util.h"

@interface AbsenceList ()

@end

@implementation AbsenceList{
    NSArray *absentLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.absentList.dataSource = self;
    absentLists = [[NSArray alloc] init];
    // Do any additional setup after loading the view.
    [self configureView];
    [self fetchAbsentList];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchAbsentList];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // You code here to update the view.
    [self fetchAbsentList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchAbsentList{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSNumber* courseId = [self.detailItem valueForKey:@"courseId"];
    NSString *date = [Util currentESTDate];
    [params setObject: [courseId stringValue] forKey:@"courseId"];
    [params setObject: date forKey:@"date"];
    NSMutableURLRequest *request = [Util getFormRequest:@"getStudentNotAttend" params:params];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (data.length > 0 && error == nil){
                                                    absentLists = [[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] mutableCopy];
                                                    if (absentLists){
                                                        if (absentLists.count != 0){
                                                            NSLog(@"%@", absentLists);
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self.absentList reloadData];
                                                            });
                                                        }
                                                    }
                                                    
                                                    NSLog(@"%@", [response description]);
                                                }
                                            }];
    [task resume];


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [absentLists count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:@"absent"];
    //Configure the cell...
    NSString* absent = absentLists[[indexPath row]];
    cell.textLabel.text = absent;
    
    return cell;
}

- (void) setItem:(NSDictionary*) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    NSLog(@"detail item in detail view: %@", _detailItem);
    NSLog(@"%@", [[self.detailItem valueForKey:@"courseName"] description]);
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSNumber* courseId = [self.detailItem valueForKey:@"courseId"];
    NSString *date = [Util currentESTDate];
    [params setObject: [courseId stringValue] forKey:@"courseId"];
    [params setObject: date forKey:@"date"];
    NSMutableURLRequest *request = [Util getFormRequest:@"getAttendantRateByTeacher" params:params];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSString *result = [Util showNSData:data];
                                                self.rate.text = result;
                                                double attendance = [result doubleValue];
                                                NSLog(@"%f",attendance);
                                                
                                                NSLog(@"%@", [response description]);
                                            }
                                  ];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
