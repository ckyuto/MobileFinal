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

- (void)configureView
{
    NSLog(@"%@", _detailItem);
    
    NSDictionary *entities = _detailItem[@"entities"];
    NSArray *medias = entities[@"media"];
    NSDictionary *ImageUrls = medias[0];
    NSString *imageURL = ImageUrls[@"media_url_https"];
    
    if (imageURL) {
        
        [self dismissModalViewControllerAnimated:YES];
        
        NSURL *url = [[NSURL alloc] initWithString:imageURL ];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        _assetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        NSLog(@"imageURL:%@", imageURL);
        NSLog(@"%@", _assetImage);
        
    }
}


@end
