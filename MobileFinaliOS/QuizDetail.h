//
//  QuizDetail.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/27/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizDetail : UIViewController
@property (weak, nonatomic) NSString *url;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end
