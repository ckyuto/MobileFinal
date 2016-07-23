//
//  Util.m
//  hw3
//
//  Created by Wei YuYen on 2016/6/7.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import "Util.h"
#import <sys/utsname.h>

@implementation Util

static NSMutableDictionary* globalUserDict;
static NSString *const REST_BASE_URL = @"http://50.19.186.200:8080/mobilefinalbackend/rest/";

+ (void) showAlert: (UIViewController *) view title:(NSString *) title message:(NSString *) message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [view presentViewController:alert animated:YES completion:nil];

}

+ (NSData *)httpBodyForParamsDictionary:(NSMutableDictionary *)paramDictionary
{
    NSMutableArray *parameterArray = [NSMutableArray array];
    
    [paramDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSString *param = [NSString stringWithFormat:@"%@=%@", key, [self percentEscapeString:obj]];
        [parameterArray addObject:param];
    }];
    
    NSString *string = [parameterArray componentsJoinedByString:@"&"];
    
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}


+ (NSString *)percentEscapeString:(NSString *)string
{
    NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)string,
                                                                                 (CFStringRef)@" ",
                                                                                 (CFStringRef)@":/?@!$&'()*+,;=",
                                                                                 kCFStringEncodingUTF8));
    return [result stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}


+ (NSMutableDictionary*) getUserDict{
    return globalUserDict;
}

+(void) setUserDict:(NSMutableDictionary*) userDict{
    globalUserDict = userDict;
}

+ (NSData*) getJsonFromDictionary: (NSDictionary*) dict{
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:dict
                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                             error:&error];
}

+(NSMutableURLRequest*) getFormRequest: (NSString*) urlMapping params: (NSDictionary*) params{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSURL *url = [NSURL URLWithString: [REST_BASE_URL stringByAppendingString:urlMapping]];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self httpBodyForParamsDictionary:params]];
    
     NSLog(@"request params: %@", [self getJsonFromDictionary:params]);
    
    return request;
}

+(NSMutableURLRequest*) getBodyRequest: (NSString*) urlMapping object: (NSDictionary*) object{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSURL *url = [NSURL URLWithString: [REST_BASE_URL stringByAppendingString:urlMapping]];
    
    [request setURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self getJsonFromDictionary:object]];
    
    NSLog(@"request params: %@", [self getJsonFromDictionary:object]);
    
    return request;
}

+(NSString *) showNSData: (NSData *) data{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
