//
//  ViewController.m
//  MobileFinaliOS
//
//  Created by Wei YuYen on 2016/7/1.
//  Copyright © 2016年 Carnegie Mellon University. All rights reserved.
//

#import "ViewController.h"
#import "GTLDrive.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "Util.h"

// Constants used for OAuth 2.0 authorization.
static NSString *const kKeychainItemName = @"Mobile Application Development3";
static NSString *const kClientId = @"25974626856-3pq3i2k03pu2fajve5hlj8cavvvp8412.apps.googleusercontent.com";
static NSString *const kClientSecret = @"f479rQ_GhKQh4JpfvciHO-tQ";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    GTMOAuth2Authentication *auth =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientId
                                                      clientSecret:kClientSecret];
    if ([auth canAuthorize]) {
        [self isAuthorizedWithAuthentication:auth];
        [self fetchUserObject:auth.userEmail];
    }

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
    
    [NSThread sleepForTimeInterval:5.0f];
    if (!self.isAuthorized) {
        // Sign in.
        SEL finishedSelector = @selector(viewController:finishedWithAuth:error:);
        GTMOAuth2ViewControllerTouch *authViewController =
        [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDrive
                                                   clientID:kClientId
                                               clientSecret:kClientSecret
                                           keychainItemName:kKeychainItemName
                                                   delegate:self
                                           finishedSelector:finishedSelector];
        [self presentViewController:authViewController
                           animated:YES
                         completion:nil];
    }
}

static float count =0;

- (void)updateProgressBar:(NSTimer *)timer{
    int load = 1 + arc4random_uniform(100);
    count += load;
    if (count <=100){
        self.progressView.progress = (float)count/100.0f;
    } else
    {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self fetchUserObject: auth.userEmail];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (error == nil) {
        [self isAuthorizedWithAuthentication:auth];
    }
}

- (void) fetchUserObject: (NSString*) userName{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:userName forKey:@"userName"];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"getUser" params:params];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (data.length > 0 && error == nil){
                                                    NSMutableDictionary *userDict = [[NSJSONSerialization JSONObjectWithData:data
                                                                                                                     options:0
                                                                                                                       error:NULL] mutableCopy];
                                                    
                                                    [Util setUserDict:userDict];

                                                    if([userDict objectForKey:@"role"] == (id)[NSNull null]){
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self performSegueWithIdentifier:@"ConfigViewController" sender:self];
                                                            
                                                        });
                                                        
                                                    }else{
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            if([[userDict objectForKey:@"role"] isEqualToString:@"TEACHER"]){
                                                                [self performSegueWithIdentifier:@"TeacherTabView" sender:self];
                                                            }
                                                            
                                                            if([[userDict objectForKey:@"role"] isEqualToString:@"STUDENT"]){
                                                                [self performSegueWithIdentifier:@"StudentTabView" sender:self];
                                                            }
                                                        });
                                                    }
                                                    
                                                }
                                            }];
    [task resume];
}




- (void)isAuthorizedWithAuthentication:(GTMOAuth2Authentication *)auth {
    //add auth for drive service
    [Util setAuthForDriverService:auth];
    self.isAuthorized = YES;
}

@end
