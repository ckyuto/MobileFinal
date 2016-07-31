//
//  StudentDetail.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/31/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "StudentDetail.h"
#import "Util.h"

@interface StudentDetail ()

@end

@implementation StudentDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentDate.text = [Util currentESTDate];
    [self.webView.delegate self];
    [self.webView setScalesPageToFit:YES];
    [self configureView];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDetailItem:(NSDictionary*) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        self.currentDate.text = [Util currentESTDate];
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    NSLog(@"detail item in detail view: %@", _detailItem);
    NSLog(@"%@", [[self.detailItem valueForKey:@"courseName"] description]);
    NSMutableDictionary* userDict = [Util getUserDict];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSNumber* courseId = [self.detailItem valueForKey:@"courseId"];
    NSString *studentUserName = [userDict objectForKey:@"userName"];
    [params setObject:studentUserName forKey:@"studentUserName"];
    [params setObject: [courseId stringValue] forKey:@"courseId"];
    NSMutableURLRequest *request = [Util getFormRequest:@"getAttendantRate" params:params];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSString *result = [Util showNSData:data];
                                                double attendance = [result doubleValue];
                                                NSLog(@"%f",attendance);
                                                double absence = 100 - attendance;
                                                NSLog(@"%f",absence);
                                                NSString *GraphURL = [NSString stringWithFormat:@"https://chart.googleapis.com/chart?cht=p3&chs=450x450&chd=t:%f,%f&chl=Attendance%f|Absence%f&chtt=Attendence Percentage", attendance, absence, attendance,absence];
                                                NSLog(@"%@", GraphURL);
//                                                NSString *GraphURL = @"https://www.google.com";
                                                NSURL *url = [NSURL URLWithString:GraphURL];
                                                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
                                                [self.webView loadRequest:urlRequest];
                                                    
                                                    NSLog(@"%@", [response description]);
                                                }
                                            ];
    [task resume];

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
