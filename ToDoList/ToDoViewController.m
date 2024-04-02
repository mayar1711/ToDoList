//
//  ToDoViewController.m
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import "ToDoViewController.h"
#import "TaskProtocol.h"
#import "Data.h"
#import "ViewController.h"

@interface ToDoViewController ()
{
    NSMutableArray *toDoList;
    ViewController *addTaskViewController;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) NSMutableArray<Data *> *task;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _table.delegate = self;
    _table.dataSource = self;
    toDoList =[NSMutableArray new];
    self.task = [NSMutableArray array];
    
    [self loadTasksFromDefults];
    [self setupNavigationBar];
    [self setupSearchController];
}

-(void)loadTasksFromDefults{
    NSUserDefaults *defults=[NSUserDefaults standardUserDefaults];
    NSDate *taskData=[defults objectForKey:@"ToDoListTaskes"];
    if(taskData!=nil){
        NSMutableArray *taskArray=[NSKeyedUnarchiver unarchiveObjectWithData:taskData];
        if([taskArray count]!=0){
            [toDoList addObjectsFromArray:taskArray];
            [self.table reloadData];
        }
    }

}
- (void)setupNavigationBar {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftButtonPressed)];
    self.navigationItem.rightBarButtonItem = leftButton;
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate = self;

    self.navigationItem.searchController = self.searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
}

- (void)leftButtonPressed {
    ViewController *addDataVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    addDataVC.insertNewIteam = self;
    [self.navigationController pushViewController:addDataVC animated:YES];
}

-(void)didSaveTask:(Data *)newTask {
    [toDoList addObject:newTask];
  //  [self loadTasksFromDefults];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    printf("\n%d\n ",self.task.count);
    return [toDoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Data *taskData = toDoList [indexPath.row];
    cell.textLabel.text = taskData.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self.table reloadData];
}
@end
