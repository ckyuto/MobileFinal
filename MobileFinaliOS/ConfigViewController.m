//
//  ConfigViewController.m
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/20.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import "ConfigViewController.h"
#import "Util.h"

@implementation ConfigViewController
{
    NSArray *roleData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    self.tfRole.inputView = picker;
    roleData = @[@"STUDENT",@"TEACHER"];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return roleData.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return roleData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.tfRole.text = roleData[row];
    [self.tfRole resignFirstResponder];
}

- (IBAction)nextBtnClick:(id)sender {
    NSMutableDictionary* userDict = [Util getUserDict];
    [userDict setObject:self.tfName.text forKey:@"name"];
    [userDict setObject:self.tfAndrewId.text forKey:@"andrewId"];
    [userDict setObject:self.tfRole.text forKey:@"role"];
   
    NSMutableURLRequest *request = [Util getBodyRequest:@"updateUser" object:userDict method:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                //NSLog([error description]);
                                                NSLog(@"%@", [response description]);
                                                NSLog(@"%@", @"Update User info success!");
                                            }];
    
    [task resume];
}

@end
