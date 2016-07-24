//
//  RegisterCourseViewController.m
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/23.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import "RegisterCourseViewController.h"
#import "Util.h"

@implementation RegisterCourseViewController

- (IBAction)btnRegisterClick:(UIButton *)sender {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:[[Util getUserDict] objectForKey:@"userName"] forKey:@"userName"];
    [params setObject:self.tfCourseNumber.text forKey:@"courseNumber"];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"registerCourse" params:params];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSString *result = [Util showNSData:data];
                                                
                                                if([result isEqualToString:@"Success"]){
                                                    NSLog(@"%@", @"Register course success!");
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        
                                                        [Util showAlert:self title:@"Info" message:@"Register success!" callback:@selector(back)];
                                                    });
                                                }else{
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [Util showAlert:self title:@"Error" message:result callback:nil];
                                                        
                                                    });
                                                   
                                                }
                                                
                                            }];
    [task resume];
}

-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
