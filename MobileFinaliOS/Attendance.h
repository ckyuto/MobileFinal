//
//  Attendance.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/20/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Attendance : UITableViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

- (void)setDetailItem:(id)newDetailItem;

@end
