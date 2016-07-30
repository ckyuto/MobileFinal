//
//  ViewController.h
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/1.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface ViewController : UIViewController <GIDSignInUIDelegate>

@property BOOL isAuthorized;

@end

