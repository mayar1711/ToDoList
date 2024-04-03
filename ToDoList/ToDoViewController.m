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
#import "DetailViewController.h"

@interface ToDoViewController ()
{
    NSMutableArray *toDoList;
    ViewController *addTaskViewController;
    NSMutableArray<Data *> *midPriorityTasks;
    NSMutableArray<Data *> *highPriorityTasks ;
    NSMutableArray<Data *> *lowPriorityTasks ;
}



@property (nonatomic, strong) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) NSMutableArray<Data *> *task;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       midPriorityTasks = [NSMutableArray array];
       highPriorityTasks = [NSMutableArray array];
       lowPriorityTasks = [NSMutableArray array];
       _table.delegate = self;
       _table.dataSource = self;
       toDoList =[NSMutableArray new];
       self.task = [NSMutableArray array];
       [self loadTasksFromDefults];
       [self filterTasksByPriority];
       [self setupNavigationBar];
       [self setupSearchController];
       self.task=highPriorityTasks;
     //  [self.table reloadData];
}



- (void)filterTasksByPriority {
    [midPriorityTasks removeAllObjects];
      [highPriorityTasks removeAllObjects];
      [lowPriorityTasks removeAllObjects];
      
    for (Data *task in toDoList) {
           if ([task.pir isEqualToString:@"mid"]) {
               [midPriorityTasks addObject:task];
               NSLog(@"Added mid-priority task: %@", task.name);
           } else if ([task.pir isEqualToString:@"high"]) {
               [highPriorityTasks addObject:task];
               NSLog(@"Added high-priority task: %@", task.name);
           } else if ([task.pir isEqualToString:@"low"]) {
               [lowPriorityTasks addObject:task];
               NSLog(@"Added low-priority task: %@", task.name);
           }
       }
   }
- (IBAction)filter:(id)sender {
    switch (_priority.selectedSegmentIndex) {
         case 0:
             self.task = highPriorityTasks;
             break;
         case 1:
             self.task = midPriorityTasks;
             break;
         case 2:
             self.task = lowPriorityTasks;
             break;
         default:
             self.task = highPriorityTasks;
             break;
     }

    [self.table reloadData];
    
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
    return [self.task count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Data *taskData = self.task[indexPath.row];
      cell.textLabel.text = taskData.name;

      return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    Data *selectedTask = self.task[indexPath.row];
    detailViewController.selectedTask = selectedTask;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  //  [self loadTasksFromDefults];
    [self filterTasksByPriority];
    [self.table reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete Task" message:@"Are you sure you want to delete this task?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [_task removeObjectAtIndex:indexPath.row];
            [self updateUserDefaults];
            [self.table reloadData];
        }];
        [alert addAction:cancelAction];
        [alert addAction:deleteAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)updateUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:_task];
    [defaults setObject:encodedData forKey:@"ToDoListTaskes"];
    [defaults synchronize];
}

@end
