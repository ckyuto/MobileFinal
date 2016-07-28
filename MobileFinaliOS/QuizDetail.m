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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDetailItem:(NSDictionary*) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    NSLog(@"detail item in detail view: %@", _detailItem);
    NSLog(@"%@", [[self.detailItem valueForKey:@"courseName"] description]);
    if (_detailItem != nil) {
        self.url.text = [[self.detailItem valueForKey:@"quizLink"] description];
        
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
