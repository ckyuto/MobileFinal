//
//  TwitterShare.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/31/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <sys/utsname.h>
#import <Accounts/Accounts.h>

@interface TwitterShare : UIViewController

@property (nonatomic) ACAccountStore *accountStore;
- (IBAction)post:(id)sender;
@end
