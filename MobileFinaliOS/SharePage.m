//
//  SharePage.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/21/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "SharePage.h"

@interface SharePage ()

@end

@implementation SharePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)userHasAccessToFacebook
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeFacebook];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)postToFacebook:(id)sender {
    if ([self userHasAccessToFacebook])
    {
        
        //  Step 1:  Obtain access to the user's Twitter accounts
        ACAccountType *facebookAccountType =
        [self.accountStore accountTypeWithAccountTypeIdentifier:
         ACAccountTypeIdentifierFacebook];
        
        [self.accountStore
         requestAccessToAccountsWithType:facebookAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        			SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
                     [controller setInitialText:@"First post from my iPhone app"];
                     [self presentViewController:controller animated:YES completion:Nil];
                 }
             }
             else {
                 UIAlertController * alert = [UIAlertController
                                              alertControllerWithTitle:@"Facebook"
                                              message:@"Permission to access Facebook Account is not guaranteed."
                                              preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction* ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                          
                                      }];
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
             }
         }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                        message:@"Facebook integration is not available.  A Facebook account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

@end
