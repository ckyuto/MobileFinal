//
//  QuizDetail.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/27/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "QuizDetail.h"

@interface QuizDetail ()

@end

@implementation QuizDetail


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"url: %@", self.url);
    if(self.url != nil){
        NSURL *url = [NSURL URLWithString:self.url];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
    }
}


@end
