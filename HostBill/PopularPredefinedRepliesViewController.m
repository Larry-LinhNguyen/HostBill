//
//  PopularPredefinedRepliesViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 12/16/12.
//  Copyright (c) 2012 AppBoxNZ Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "PopularPredefinedRepliesViewController.h"

@interface PopularPredefinedRepliesViewController (){
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
    NSMutableArray *_tempobject;
}


@end

@implementation PopularPredefinedRepliesViewController
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string1;
@synthesize tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *AD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.string = AD.URL;
    
    self.string1 = [NSString stringWithFormat:@"%@&call=getPopularPredefinedReplies", string];
    NSLog(@"%@",string1);
}
- (void)viewWillAppear:(BOOL)animated
{
    _objects = [[NSMutableArray alloc] init];
    _objects2 = [[NSMutableArray alloc] init];
    [tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self getData];
}
-(void)getData
{
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string1]];
    
    if (jsonData) {
        
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return;
            
        }
        
        NSLog (@"%@ ",jsonObjects);
        /*
        _tempobject = [jsonObjects valueForKey:@"transactions"];
        NSLog (@"%@ ",_tempobject);
        NSMutableDictionary  *dictionary;
        int count = [_tempobject count];
        for (int i=0; i < count; i++) {
            dictionary = [_tempobject objectAtIndex: i];
            NSLog (@"Each>>%u>: %@ ",i, dictionary);
            NSString * title = [NSString stringWithFormat:@"%@: In: %@, Out: %@",[dictionary valueForKey:@"id"], [dictionary valueForKey:@"in"], [dictionary valueForKey:@"out"]];
            [_objects insertObject:title atIndex:0];
            NSString * description = [NSString stringWithFormat:@"%@ %@",[dictionary valueForKey:@"firstname"],[dictionary valueForKey:@"lastname"]];
            [_objects2 insertObject:description atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
         */
        
        
    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Favourite replies" forIndexPath:indexPath];
    
    cell.textLabel.text = _objects[indexPath.row];
    cell.detailTextLabel.text = _objects2[indexPath.row];
    return cell;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Number of rows is the number of time zones in the region for the specified section.
    
    return _objects.count;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
