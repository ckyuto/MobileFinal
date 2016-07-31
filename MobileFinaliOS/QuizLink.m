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
    NSArray *classLists;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return allQuiz.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    driveFiles = [[NSMutableArray alloc] init];
    allQuiz = [[NSMutableArray alloc] init];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    self.quizName.inputView = picker;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [self loadDriveFiles];
    

}

- (NSArray*) fetchAllQuiz{
    // to be implemented by following the example to fetch all links from google side
    NSArray* result;
    return result;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return allQuiz[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.quizName.text = allQuiz[row];
    [self.quizName resignFirstResponder];
}

- (void)loadDriveFiles {
    GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
    query.q = @"mimeType = 'application/vnd.google-apps.form'";
    
    
    [[Util getGoogleDriverService] executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                              GTLDriveFileList *files,
                                                              NSError *error) {
        if (error == nil) {
            
            [driveFiles removeAllObjects];
            NSLog(@"description: %@", files.JSONString);
            [driveFiles addObjectsFromArray:files.files];
            
            for(GTLDriveFile *file in driveFiles){
                [allQuiz addObject:file.name];
                NSLog(@"%@", file.name);
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
                                                    classLists = [[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] mutableCopy];
                                                    
                                                    
                                                    
                                                    
                                                    NSLog(@"%@", [response description]);
                                                    NSLog(@"classLists: %@", classLists);
                                                    
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
}
@end
