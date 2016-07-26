//
//  ClassDetail.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/19/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassDetail : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseDesc;

@property (strong, nonatomic) id detailItem;

// @property (strong, nonatomic) NSDictionary *detailItem;
//- (void)setDetailItem:(NSDictionary*)newDetailItem;

- (void)setDetailItem:(id)newDetailItem;

- (IBAction)checkAttendance:(id)sender;


@end
