//
//  Util.h
//  hw3
//
//  Created by Wei YuYen on 2016/6/7.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "GTLCalendar.h"

@interface Util : NSObject


+ (void) showAlert: (UIViewController *) view title:(NSString *) title message:(NSString *) message;
+ (NSData *)httpBodyForParamsDictionary:(NSDictionary *)paramDictionary;
+ (NSString *)percentEscapeString:(NSString *)string;

@end
