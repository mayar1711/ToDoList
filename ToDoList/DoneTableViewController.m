//
//  DoneTableViewController.m
//  ToDoList
//
//  Created by Mayar on 03/04/2024.
//

#import "DoneTableViewController.h"
#import "Data.h"
#import "DetailViewController.h"

@interface DoneTableViewController ()
{
    NSMutableArray *toDoList;
    NSMutableArray *doneTask;
}
@property (nonatomic, strong) NSMutableArray<NSString *> *listOfItems;

@end

@implementation DoneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    toDoList =[NSMutableArray new];
    doneTask=[NSMutableArray new];
     
    [self loadTasksFromDefults];
}


-(void)loadTasksFromDefults{
    NSUserDefaults *defults=[NSUserDefaults standardUserDefaults];
    NSDate *taskData=[defults objectForKey:@"ToDoListTaskes"];
        NSMutableArray *taskArray=[NSKeyedUnarchiver unarchiveObjectWithData:taskData];
    for(Data *task in taskArray){
        if([task.state isEqualToString :@"done"])
        {
            [doneTask addObject:task];
        }
        
    }
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return doneTask.count;
    
}
-(void)didSaveTask:(Data *)newTask {
    [toDoList addObject:newTask];
}
- (void)didDelete:(Data *)deleteTask{
    [toDoList removeObject:deleteTask];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    Data *taskData = doneTask[indexPath.row];
      cell.textLabel.text = taskData.name;
    cell.imageView.image=[UIImage imageNamed:taskData.pir];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Data *selectedColleague = doneTask[indexPath.row];
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.selectedTask = selectedColleague;
    detailVC.selectedTaskIndex=indexPath.row;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
