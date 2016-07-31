//
//  StudentDetail.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/31/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentDetail : UIViewController

@property (strong, nonatomic) id detailItem;
- (void)setDetailItem:(id)newDetailItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *currentDate;

@end
