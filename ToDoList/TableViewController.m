//
//  TableViewController.m
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import "TableViewController.h"
#import "TaskProtocol.h"
#import "ViewController.h"
@interface TableViewController () <TaskProtocol>

@property (nonatomic, strong) NSMutableArray<NSString *> *listOfItems;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listOfItems = [NSMutableArray arrayWithObjects:@"Item 1", @"Item 2", @"Item 3", nil];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.listOfItems[indexPath.row];
    
    return cell;
}

- (void)addButtonPressed {
    ViewController *addDataVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    addDataVC.insertNewIteam = self;
    [self.navigationController pushViewController:addDataVC animated:YES];
}

@end
