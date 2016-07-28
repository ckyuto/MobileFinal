//
//  QuizLink.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/25/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "QuizLink.h"

@interface QuizLink ()

@end

@implementation QuizLink{
    NSArray *allQuiz;
    NSArray *allCourse;
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
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    self.quizLink.inputView = picker;
    allQuiz = [self fetchAllQuiz];
    
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
    self.quizLink.text = allQuiz[row];
    [self.quizLink resignFirstResponder];
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

- (IBAction)saveToDatabase:(id)sender {
}
@end
