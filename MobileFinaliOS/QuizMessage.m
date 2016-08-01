//
//  QuizMessage.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/31/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "QuizMessage.h"
#import "Util.h"

@interface QuizMessage ()

@end

@implementation QuizMessage{
    NSArray *quizSet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchQuiz];
    
    quizSet = [[NSArray alloc]init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchQuiz];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // You code here to update the view.
    [self fetchQuiz];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [quizSet count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quiz" forIndexPath:indexPath];
    NSDictionary* quiz = quizSet[[indexPath row]];
    cell.textLabel.text = quiz[@"url"];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void) fetchQuiz{
    NSMutableDictionary* userDict = [Util getUserDict];
    NSString *userName = [userDict objectForKey:@"userName"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:userName forKey:@"userName"];
    NSMutableURLRequest *request = [Util getFormRequest:@"getAllQuizByStudentUserName" params:params];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (data.length > 0 && error == nil){
                                                    quizSet = [[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] mutableCopy];
                                                    if (quizSet){
                                                        if (quizSet.count != 0){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self.quizTable reloadData];
                                                            });
                                                        }
                                                    }
                                                    
                                                    NSLog(@"%@", [response description]);                                                    
                                                }
                                            }];
    [task resume];

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *quiz = [quizSet objectAtIndex:indexPath.row];
    
    UIWebView *aWebView;
    CGRect screen = [[UIScreen mainScreen] bounds];
    aWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];//init and create the UIWebView
    aWebView.autoresizesSubviews = YES;
    aWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    //set the web view delegates for the web view to be itself
    [aWebView setDelegate:self];
    //Set the URL to go to for your UIWebView
    NSString *urlAddress = quiz[@"url"];
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //load the URL into the web view.
    [aWebView loadRequest:requestObj];
    //add the web view to the content view
    [self.view addSubview:aWebView];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
