//
//  ViewController.h
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/1.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *myTimer;

@property BOOL isAuthorized;

@end

