//
//  NewClass.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/19/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "NewClass.h"
#import "Util.h"

@interface NewClass ()

@end

@implementation NewClass

@synthesize courseName;
@synthesize description;
@synthesize courseNumber;
@synthesize startDate;
@synthesize endDate;
@synthesize startTime;
@synthesize endTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Save and cancel operations

- (IBAction)saveClass:(id)sender {
    NSMutableDictionary* classDict;
    [classDict setObject:self.courseNumber.text forKey:@"courseNumber"];
    [classDict setObject:self.courseName.text forKey:@"courseName"];
    [classDict setObject:self.classDescription.text forKey:@"description"];
    [classDict setObject:self.startDate forKey:@"startDate"];
    [classDict setObject:self.endDate forKey:@"endDate"];
    [classDict setObject:self.startTime forKey:@"startTime"];
    [classDict setObject:self.endTime forKey:@"endTime"];
    
    NSMutableURLRequest *request = [Util getBodyRequest:@"createCourse" object: classDict method:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"%@", [response description]);
                                                NSLog(@"%@", @"Create Course success!");
                                                
                                                
                                            }];

    
    
    [task resume];
}

- (IBAction)cancelClass:(id)sender {
}

- (IBAction)onTouchStartDate:(id)sender {
    if (self.startDate.inputView == nil)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(updateStartDateField:)
             forControlEvents:UIControlEventValueChanged];
        [self.startDate setInputView:datePicker];
    }
}

- (IBAction)onTouchEndDate:(id)sender {
    if (self.endDate.inputView == nil)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(updateEndDateField:)
             forControlEvents:UIControlEventValueChanged];
        [self.endDate setInputView:datePicker];
    }
}

-(void)updateEndDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.endDate.inputView;
    self.endDate.text = [self formatDate:picker.date];
}

-(void)updateStartDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.startDate.inputView;
    self.startDate.text = [self formatDate:picker.date];
}

- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

@end
