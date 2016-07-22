//
//  SharePage.h
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/21/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <sys/utsname.h>
#import <Accounts/Accounts.h>

@interface SharePage : UIViewController
- (IBAction)postToFacebook:(id)sender;

@property (nonatomic) ACAccountStore *accountStore;

@end
