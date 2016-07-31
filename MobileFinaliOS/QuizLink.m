//
//  QuizLink.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/25/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "QuizLink.h"
#import "GTLDrive.h"
#import "Util.h"
#import "QEUtilities.h"


@interface QuizLink ()

@end

@implementation QuizLink{
    NSMutableArray *allQuiz;
    NSMutableArray *allCourse;
    NSMutableArray *driveFiles;
    NSMutableDictionary *courseNameIdDict;
    NSMutableDictionary *quizNameUrlDict;
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag == 1){
        return allCourse.count;
    }else{
        return allQuiz.count;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    driveFiles = [[NSMutableArray alloc] init];
    allQuiz = [[NSMutableArray alloc] init];
    allCourse = [[NSMutableArray alloc] init];
    courseNameIdDict = [[NSMutableDictionary alloc] init];
    quizNameUrlDict = [[NSMutableDictionary alloc] init];
    
    UIPickerView *coursePicker = [[UIPickerView alloc] init];
    coursePicker.tag = 1;
    coursePicker.dataSource = self;
    coursePicker.delegate = self;
    self.courseNumber.inputView = coursePicker;
    
    
    UIPickerView *quizPicker = [[UIPickerView alloc] init];
    quizPicker.tag = 2;
    quizPicker.dataSource = self;
    quizPicker.delegate = self;
    self.quizName.inputView = quizPicker;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [allQuiz removeAllObjects];
    [allCourse removeAllObjects];
    [driveFiles removeAllObjects];
    [courseNameIdDict removeAllObjects];
    [quizNameUrlDict removeAllObjects];
    
    [self loadDriveFiles];
    [self fetchClassObject];
    

}


- (NSArray*) fetchAllQuiz{
    // to be implemented by following the example to fetch all links from google side
    NSArray* result;
    return result;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView.tag == 1){
        return allCourse[row];
    }else{
        return allQuiz[row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView.tag == 1){
        self.courseNumber.text = allCourse[row];
        [self.courseNumber resignFirstResponder];
    }else{
        self.quizName.text = allQuiz[row];
        [self.quizName resignFirstResponder];
    }
}

- (void)loadDriveFiles {
    GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
    query.q = @"mimeType = 'application/vnd.google-apps.form'";
    
    
    [[Util getGoogleDriverService] executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                              GTLDriveFileList *files,
                                                              NSError *error) {
        if (error == nil) {
            
            [driveFiles removeAllObjects];
            [driveFiles addObjectsFromArray:files.files];
            
            for(GTLDriveFile *file in driveFiles){
                NSString *url = [NSString stringWithFormat: @"https://docs.google.com/forms/d/%@/edit#responses", [[file JSONValueForKey:@"id"] description]];
                [allQuiz addObject:file.name];
                [quizNameUrlDict setObject: url forKey:file.name];
            }
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
}


- (void) fetchClassObject{
    NSMutableDictionary* userDict = [Util getUserDict];
    NSString *teacherUserName = [userDict objectForKey:@"userName"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:teacherUserName forKey:@"teacherUserName"];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"getCourseByTeacherUserName" params:params];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (data.length > 0 && error == nil){
                                                    NSArray *classLists = [[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] mutableCopy];
                                                    
                                                    for(NSDictionary* course in classLists){
                                                        NSString* courseNumber = [course objectForKey:@"courseNumber"];
                                                        [allCourse addObject: courseNumber];
                                                        [courseNameIdDict setObject: [course objectForKey:@"courseId"] forKey:courseNumber];
                                                    }
                                                }
                                            }];
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

- (IBAction)saveToDatabase:(id)sender {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[courseNameIdDict objectForKey:self.courseNumber.text] forKey:@"courseId"];
    [params setObject:self.quizName.text forKey:@"quizName"];
    [params setObject:self.lbUrl.text forKey:@"url"];
    
    NSMutableURLRequest *request = [Util getBodyRequest:@"createCourseQuiz" object:params];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                if(error == nil){
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [Util showAlert:self title:@"" message:@"Send quiz success" callback:@selector(clearValue)];
                                                    });
                                                    NSLog(@"create course quiz link success");
                                                }
                                                
                                                
                                                NSLog(@"%@", [response description]);
                                            
                                            }];
    
    [task resume];
    
}


- (IBAction)onChangeQuizName:(UITextField *)sender {
    if(sender.text != nil){
        self.lbUrl.text = [quizNameUrlDict objectForKey:sender.text];
    }else{
        self.lbUrl.text = @"";
    }
}

-(void) clearValue{
    self.courseNumber.text = @"";
    self.quizName.text = @"";
    self.lbUrl.text = @"";
}

@end
