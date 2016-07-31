//
//  AbsenceList.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/31/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbsenceList : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UITableView *absentList;

- (void)setItem:(id)newDetailItem;

@end
