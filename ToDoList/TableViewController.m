//
//  TableViewController.m
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import "TableViewController.h"
#import "TaskProtocol.h"
#import "ViewController.h"
#import "Data.h"
#import "DetailViewController.h"

@interface TableViewController () <TaskProtocol>

{
    NSMutableArray *toDoList;
    NSMutableArray *doneTask;
}

@property (nonatomic, strong) NSMutableArray<NSString *> *listOfItems;



@end

@implementation TableViewController

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
        if([task.state isEqualToString :@"doing"])
        {
            [doneTask addObject:task];
        }
        
    }
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return doneTask.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    Data *taskData = doneTask[indexPath.row];
      cell.textLabel.text = taskData.name;
    cell.imageView.image=[UIImage imageNamed:taskData.pir];

    return cell;
}

- (void)addButtonPressed {
    ViewController *addDataVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    addDataVC.insertNewIteam = self;
    [self.navigationController pushViewController:addDataVC animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete Task" message:@"Are you sure you want to delete this task?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self->doneTask removeObjectAtIndex:indexPath.row];
            [self updateUserDefaults];
        }];
        [alert addAction:cancelAction];
        [alert addAction:deleteAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)updateUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:doneTask];
    [defaults setObject:encodedData forKey:@"ToDoListTaskes"];
    [defaults synchronize];
}

-(void)didSaveTask:(Data *)newTask {
    [toDoList addObject:newTask];
}
- (void)didDelete:(Data *)deleteTask{
    [toDoList removeObject:deleteTask];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Data *selectedColleague = doneTask[indexPath.row];
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.selectedTask = selectedColleague;
    detailVC.selectedTaskIndex=indexPath.row;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
@end
