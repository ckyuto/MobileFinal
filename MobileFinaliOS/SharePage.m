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
    self.accountStore = [[ACAccountStore alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeTwitter];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)post:(id)sender {
    NSLog(@"button action activated");
    if ([self userHasAccessToTwitter])
    {
        
        NSLog(@"user has access token");
        //  Step 1:  Obtain access to the user's Twitter accounts
        if(self.accountStore == nil){
            self.accountStore = [[ACAccountStore alloc] init];
        }
        ACAccountType *twitterAccountType =
        [self.accountStore accountTypeWithAccountTypeIdentifier:
         ACAccountTypeIdentifierTwitter];
        
//        NSDictionary *options = @{
//                                  @"ACFacebookAppIdKey" : @"123456789",
//                                  @"ACFacebookPermissionsKey" : @[@"publish_stream"],
//                                  @"ACFacebookAudienceKey" : ACFacebookAudienceEveryone};
        
        [self.accountStore
         requestAccessToAccountsWithType:twitterAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 NSLog(@"granted");
                 if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                     NSLog(@"is available");
                     SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                     
                     [controller setInitialText:@"First post from my iPhone app"];
                     [self presentViewController:controller animated:YES completion:Nil];
                 } else{
                     NSLog(@"SLComposeViewController is not available");
                 }
             }
             else {
                 NSLog(@"permission not granted");
                 UIAlertController * alert = [UIAlertController
                                              alertControllerWithTitle:@"Twitter"
                                              message:@"Permission to access Twitter Account is not guaranteed."
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
        NSLog(@"integration not available");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Twitter integration is not available.  A Twitter account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}
@end
