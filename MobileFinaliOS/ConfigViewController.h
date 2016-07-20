//
//  ConfigViewController.h
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/20.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tfName;
@property (strong, nonatomic) IBOutlet UITextField *tfAndrewId;
@property (strong, nonatomic) IBOutlet UITextField *tfRole;
- (IBAction)nextBtnClick:(id)sender;

@end
