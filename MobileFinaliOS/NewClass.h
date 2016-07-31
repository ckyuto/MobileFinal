//
//  NewClass.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/19/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewClass : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *courseName;
@property (weak, nonatomic) IBOutlet UITextField *courseNumber;
@property (weak, nonatomic) IBOutlet UITextField *classDescription;

@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *beaconLink;
@property (weak, nonatomic) IBOutlet UITextField *times;

- (IBAction)saveClass:(id)sender;
- (IBAction)cancelClass:(id)sender;
- (IBAction)onTouchStartDate:(id)sender;
- (IBAction)onTouchEndDate:(id)sender;

- (IBAction)onTouchStartTime:(id)sender;
- (IBAction)onTouchEndTime:(id)sender;

@end
