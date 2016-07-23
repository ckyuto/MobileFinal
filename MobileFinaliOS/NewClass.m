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
    NSMutableDictionary* classDict = [NSMutableDictionary new];
    [classDict setObject:self.courseNumber.text forKey:@"courseNumber"];
    [classDict setObject:self.courseName.text forKey:@"courseName"];
    [classDict setObject:self.classDescription.text forKey:@"description"];
    [classDict setObject:[NSNumber numberWithLong:startDateInMs] forKey:@"startDate"];
    [classDict setObject:[NSNumber numberWithLong:endDateInMs] forKey:@"endDate"];
    [classDict setObject:[NSNumber numberWithLong:startTimeInMs] forKey:@"startTime"];
    [classDict setObject:[NSNumber numberWithLong:endTimeInMs] forKey:@"endTime"];
    [classDict setObject:[[Util getUserDict] objectForKey:@"userName"] forKey:@"teacherUserName"];
    
    
    NSMutableURLRequest *request = [Util getBodyRequest:@"createCourse" object: classDict];
    NSLog(@"%@", classDict);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"%@", [response description]);
                                                NSLog(@"%@", @"Create Course success!");
                                                [self clearText];
                                            }];
    [task resume];
}

- (void) clearText{
    self.courseNumber.text = nil;
    self.courseName.text = nil;
    self.classDescription.text = nil;
    self.startDate.text = nil;
    self.endDate.text = nil;
    self.startTime.text = nil;
    self.endTime.text = nil;

}

- (IBAction)cancelClass:(id)sender {
    [self clearText];
}


UIDatePicker *startDatePicker;
UIDatePicker *endDatePicker;

- (IBAction)onTouchStartDate:(id)sender {
    if (self.startDate.inputView == nil)
    {
        startDatePicker = [[UIDatePicker alloc] init];
        startDatePicker.datePickerMode = UIDatePickerModeDate;
        [startDatePicker addTarget:self action:@selector(updateStartDateField:)
                  forControlEvents:UIControlEventValueChanged];
        [self.startDate setInputView:startDatePicker];
        [startDatePicker addTarget:self action:@selector(startDateChanged:)
                  forControlEvents:UIControlEventEditingChanged];
    }
}


- (IBAction)onTouchEndDate:(id)sender {
    if (self.endDate.inputView == nil)
    {
        endDatePicker = [[UIDatePicker alloc] init];
        endDatePicker.datePickerMode = UIDatePickerModeDate;
        [endDatePicker addTarget:self action:@selector(updateEndDateField:)
             forControlEvents:UIControlEventValueChanged];
        [self.endDate setInputView:endDatePicker];
    }
}

- (IBAction)onTouchStartTime:(id)sender {
    if (self.startTime.inputView == nil)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeTime;
        [datePicker addTarget:self action:@selector(updateStartTimeField:)
             forControlEvents:UIControlEventValueChanged];
        [self.startTime setInputView:datePicker];
    }
}

- (IBAction)onTouchEndTime:(id)sender {
    if (self.endTime.inputView == nil)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeTime;
        [datePicker addTarget:self action:@selector(updateEndTimeField:)
             forControlEvents:UIControlEventValueChanged];
        [self.endTime setInputView:datePicker];
    }
}

- (void)startDateChanged:(id)sender
{
    NSDate *minDateFromStart = [NSDate dateWithTimeInterval:1.0 sinceDate:startDatePicker.date];
    endDatePicker.minimumDate = minDateFromStart;
    NSLog(@"%@", minDateFromStart);
}

double startDateInMs;
double endDateInMs;
double startTimeInMs;
double endTimeInMs;

-(void)updateStartTimeField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.startTime.inputView;
    self.startTime.text = [self formatTime:picker.date];
    startTimeInMs = ([picker.date timeIntervalSinceReferenceDate] * 1000);
    [self.startTime resignFirstResponder];
}

-(void)updateEndTimeField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.endTime.inputView;
    self.endTime.text = [self formatTime:picker.date];
    endTimeInMs =  ([picker.date timeIntervalSinceReferenceDate] * 1000);
    [self.endTime resignFirstResponder];
}

-(void)updateEndDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.endDate.inputView;
    self.endDate.text = [self formatDate:picker.date];
    endDateInMs = ([picker.date timeIntervalSinceReferenceDate] * 1000);
    [self.endDate resignFirstResponder];
}

-(void)updateStartDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.startDate.inputView;
    self.startDate.text = [self formatDate:picker.date];
    startDateInMs =([picker.date timeIntervalSinceReferenceDate] * 1000);
    [self.startDate resignFirstResponder];
}


- (NSString *)formatTime:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
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
