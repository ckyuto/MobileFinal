//
//  MyClass.m
//  MobileFinaliOS
//
//  Created by Mengzhen on 7/19/16.
//  Copyright © 2016 Carnegie Mellon University. All rights reserved.
//

#import "MyClass.h"
#import "Util.h"
#import "ClassDetail.h"

@interface MyClass ()
@end

@implementation MyClass{
    NSArray *classLists;
    NSDictionary * class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchClassObject];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchClassObject];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // You code here to update the view.
    [self fetchClassObject];
    
}

- (void) fetchClassObject{
    NSMutableDictionary* userDict = [Util getUserDict];
    NSString *teacherUserName = [userDict objectForKey:@"userName"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:teacherUserName forKey:@"teacherUserName"];
    
    NSMutableURLRequest *request = [Util getFormRequest:@"getCourseByTeacherUserName" params:params];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (data.length > 0 && error == nil){
                                                    NSArray *classDict = [[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] mutableCopy];
                                                    if (classDict){
                                                        classLists = classDict;
                                                        if (classLists.count != 0){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self.myClassList reloadData];
                                                            });
                                                        }
                                                    }
                                                    
                                                    NSLog(@"%@", [response description]);
                                                    NSLog(@"classLists: %@", classLists);
                                                    
                                                }
                                            }];
    [task resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [classLists count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:@"classCell"];
     //Configure the cell...
    class = classLists[[indexPath row]];
    cell.textLabel.text = class[@"courseName"];
    cell.detailTextLabel.text = class[@"courseNumber"];
    
    return cell;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"classList" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString: @"classList"]) {
        NSIndexPath *indexPath = [self.myClassList indexPathForCell:sender];
        class = classLists[[indexPath row]];
        [[segue destinationViewController] setDetailItem: class];
    }
    // Pass the selected object to the new view controller.
    
}


@end
