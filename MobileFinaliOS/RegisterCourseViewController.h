//
//  RegisterCourseViewController.h
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/23.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterCourseViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *tfCourseNumber;

- (IBAction)btnRegisterClick:(UIButton *)sender;


@end
