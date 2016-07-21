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

@interface Util : NSObject

+ (void) showAlert: (UIViewController *) view title:(NSString *) title message:(NSString *) message;
+ (NSData *)httpBodyForParamsDictionary:(NSDictionary *)paramDictionary;
+ (NSString *)percentEscapeString:(NSString *)string;
+ (NSMutableDictionary*) getUserDict;
+(void) setUserDict:(NSMutableDictionary*) userDict;
+ (NSData*) getJsonFromDictionary: (NSDictionary*) dict;

+(NSMutableURLRequest*) getFormRequest: (NSString*) urlMapping params: (NSDictionary*) params method: (NSString*) method;
+(NSMutableURLRequest*) getBodyRequest: (NSString*) urlMapping object: (NSDictionary*) object method: (NSString*) method;

+(NSString *) showNSData: (NSData *) data;
@end
