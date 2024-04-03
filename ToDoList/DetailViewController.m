//
//  DetailViewController.m
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state;
@property (weak, nonatomic) IBOutlet UITextField *disText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property int prioritySegmentIndex;
@property int stateSegmentIndex;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameText.text = self.selectedTask.name;
       self.disText.text = self.selectedTask.dis;
       self.dateText.text = self.selectedTask.date;
    
    [self getPriority];
       [self.priority setSelectedSegmentIndex:_prioritySegmentIndex];
    [self getState];
    [self.state setSelectedSegmentIndex:_stateSegmentIndex];
     
}
- (IBAction)updateTask:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Update Task" message:@"Do you want to update this task?" preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
       UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self updateTaskAndSave];
           [self.navigationController popViewControllerAnimated:YES];
       }];
       
       [alert addAction:cancelAction];
       [alert addAction:updateAction];
       [self presentViewController:alert animated:YES completion:nil];
   }

-(void)getPriority{
    if([self.selectedTask.pir isEqual:@"mid"])
    {
        _prioritySegmentIndex=1;
    }
    else if ([self.selectedTask.pir isEqual:@"low"]){
        _prioritySegmentIndex=2;
        
    }
    else if ([self.selectedTask.pir isEqual:@"high"]){
        _prioritySegmentIndex=0;
    }
}
-(void)getState{
    if([self.selectedTask.state isEqual:@"todo"])
    {
        _stateSegmentIndex=0;
    }
    else if([self.selectedTask.state isEqual:@"doing"])
    {
        _stateSegmentIndex=1;
    }
   else if([self.selectedTask.state isEqual:@"done"])
    {
        _stateSegmentIndex=2;
    }
    
    
}
- (void)updateTaskAndSave {

    [self updateUserDefaults];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)updateUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *existingData = [defaults objectForKey:@"ToDoListTaskes"];
    NSMutableArray<Data *> *existingTasks = [NSMutableArray array];
    
    if (existingData) {
        existingTasks = [[NSKeyedUnarchiver unarchiveObjectWithData:existingData] mutableCopy];
    }
    
    NSLog(@"Existing tasks: %@", existingTasks);
    NSLog(@"Selected task: %@", self.selectedTask);
    
    NSInteger index = [existingTasks indexOfObject:self.selectedTask];
    if (index != 0) {
        Data *updatedTask = existingTasks[self.selectedTaskIndex];
        updatedTask.name = self.nameText.text;
        NSLog(@"Selected task: %@", updatedTask.name);
        updatedTask.dis = self.disText.text;
        updatedTask.date = self.dateText.text;
        NSNumber *periortyNum = [[NSNumber alloc] initWithInteger:_priority.selectedSegmentIndex];
        int x=periortyNum.intValue;
        switch (x) {
            case 0:
                updatedTask.pir =@"high";
                break;
            case 1:
                updatedTask.pir = @"mid";
                break;
            case 2:
                updatedTask.pir = @"low";
                break;
        }
        NSNumber *stateNum = [[NSNumber alloc] initWithInteger:_state.selectedSegmentIndex];
        int z=stateNum.intValue;
        switch (z) {
            case 0:
                updatedTask.state =@"todo";
                break;
            case 1:
                updatedTask.state = @"doing";
                break;
            case 2:
                updatedTask.state = @"done";
                break;
        }
        [_insertNewIteam didDelete:existingTasks[_selectedTaskIndex]];
        [existingTasks removeObjectAtIndex:_selectedTaskIndex];
        [existingTasks addObject:updatedTask];
        //[_insertNewIteam didSaveTask:updatedTask];

        NSLog(@"Selected task: %@", updatedTask.state);
        NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:existingTasks];
        [defaults setObject:encodedData forKey:@"ToDoListTaskes"];
        [defaults synchronize];
        
    } else {
        NSLog(@"Selected task not found in existing tasks.");
    }
}

@end
