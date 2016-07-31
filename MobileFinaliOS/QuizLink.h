//
//  QuizLink.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/25/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizLink : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)saveToDatabase:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *quizName;

@property (weak, nonatomic) IBOutlet UITextField *courseNumber;

@property (strong, nonatomic) IBOutlet UILabel *lbUrl;

- (IBAction)onChangeQuizName:(UITextField *)sender;

@end
