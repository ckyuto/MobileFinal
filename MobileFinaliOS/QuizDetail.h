//
//  QuizDetail.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/27/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizDetail : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *url;
@property (weak, nonatomic) IBOutlet UITextView *quizSummary;

@property (strong, nonatomic) id detailItem;

- (void)setDetailItem:(id)newDetailItem;

@end
