//
//  Util.h
//  hw3
//
//  Created by Wei YuYen on 2016/6/7.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"


@interface Util : NSObject


+ (void) showAlert: (UIViewController *) view title:(NSString *) title message:(NSString *) message  callback:(SEL)callback;
+ (NSData *)httpBodyForParamsDictionary:(NSDictionary *)paramDictionary;
+ (NSString *)percentEscapeString:(NSString *)string;
+ (NSMutableDictionary*) getUserDict;
+(void) setUserDict:(NSMutableDictionary*) userDict;
+ (NSData*) getJsonFromDictionary: (NSDictionary*) dict;

+(NSMutableURLRequest*) getFormRequest: (NSString*) urlMapping params: (NSDictionary*) params;
+(NSMutableURLRequest*) getBodyRequest: (NSString*) urlMapping object: (NSDictionary*) object;

+(NSString *) showNSData: (NSData *) data;

+(void) setAuthForDriverService: (GTMOAuth2Authentication *)auth;
+(GTLServiceDrive *) getGoogleDriverService;

@end
