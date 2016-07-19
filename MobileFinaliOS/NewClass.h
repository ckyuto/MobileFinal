//
//  NewClass.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/19/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewClass : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *courseName;

@property (weak, nonatomic) IBOutlet UITextField *description;
- (IBAction)saveClass:(id)sender;
- (IBAction)cancelClass:(id)sender;

@end
