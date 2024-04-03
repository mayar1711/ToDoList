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
}
- (void)updateUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self.selectedTask];
    
    [defaults setObject:encodedData forKey:@"ToDoListTaskes"];
    
    [defaults synchronize];
}
@end
