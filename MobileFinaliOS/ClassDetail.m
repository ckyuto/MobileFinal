//
//  ClassDetail.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/19/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "ClassDetail.h"

@interface ClassDetail ()

@end

@implementation ClassDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setDetailItem:(NSDictionary*) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (IBAction)checkAttendance:(id)sender {
    [self performSegueWithIdentifier:@"attendance" sender:nil];
}


- (void)configureView
{
    NSLog(@"detail item in detail view: %@", _detailItem);
    NSLog(@"%@", [[self.detailItem valueForKey:@"courseName"] description]);
    if (_detailItem != nil) {
        self.courseName.text = [[self.detailItem valueForKey:@"courseName"] description];
        self.courseDesc.text = [[self.detailItem valueForKey:@"description"] description];

    }
    
    
}


@end
