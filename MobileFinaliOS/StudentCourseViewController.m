//
//  StudentCourseViewController.m
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/21.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import "StudentCourseViewController.h"
#import "Util.h"
#import "ESSBeaconScanner.h"

@interface StudentCourseViewController() <ESSBeaconScannerDelegate>{
    ESSBeaconScanner *_scanner;
}

@end

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

# pragma beacon

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _scanner = [[ESSBeaconScanner alloc] init];
    _scanner.delegate = self;
    [_scanner startScanning];
    
}

- (void)beaconScanner:(ESSBeaconScanner *)scanner didFindURL:(NSURL *)url {
    NSLog(@"I Saw a URL!: %@", url);
    NSMutableDictionary* userDict = [Util getUserDict];
    NSString *userName = [userDict objectForKey:@"userName"];
    NSString *date = currentESTDate();
    NSString *urlString = url.absoluteString;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:userName forKey:@"userName"];
    [params setObject:date forKey:@"date"];
    [params setObject:urlString forKey:@"beaconUrl"];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"createCheckin" params:params];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSLog(@"%@", [response description]);
                                            }];
    [task resume];
    
    
    
}

NSString *currentESTDate()
{
    NSString *formatterDate = @"dd-MM-yyyy";
    
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:formatterDate];
    NSString* currentDateStamp =[formatter stringFromDate:date];
    NSDate * returnDate = [formatter dateFromString:currentDateStamp];
    
    if( returnDate )
    {
        return currentDateStamp;
    }
    return nil;
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
