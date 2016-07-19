//
//  ClassDetail.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/19/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassDetail : UIViewController

@property (strong, nonatomic) NSDictionary *detailItem;

- (void)setDetailItem:(NSDictionary*)newDetailItem;


@end
