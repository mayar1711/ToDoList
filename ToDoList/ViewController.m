//
//  ViewController.m
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

{
    NSMutableData *notes;
}
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *disText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation ViewController
{
    NSUserDefaults *myDefaulse;
    NSMutableArray <Data *>*taskes;
    NSDate *date ;
    NSDate *defultTask ;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    date = [NSDate date];
    myDefaulse=[NSUserDefaults standardUserDefaults];
    defultTask=[myDefaulse objectForKey:@"ToDoListTaskes"];
    if(defultTask!=nil){
        taskes=[NSKeyedUnarchiver unarchiveObjectWithData:defultTask];
    }else{
        taskes=[NSMutableArray new];
    }
}
- (IBAction)saveBtn:(id)sender {
    
    NSString *name = self.nameText.text;
    NSString *dis = self.disText.text;
    NSNumber *periortyNum = [[NSNumber alloc] initWithInteger:_priority.selectedSegmentIndex];
    Data *newTask = [[Data alloc] init];
    newTask.name = name;
    newTask.dis = dis;
    newTask.date = [self formattedDate];
    newTask.state=@"todo";
    int x=periortyNum.intValue;
    switch (x) {
        case 0:
            newTask.pir = @"high";
            break;
        case 1:
            newTask.pir = @"mid";
            break;
        case 2:
            newTask.pir = @"low";
            break;
       
        default:
            newTask.pir = @"high";
            break;
    }
        
    [taskes addObject:newTask];
    NSLog(@" \nTask saved successfully %@ \n.",newTask.pir);

    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:taskes];
    [myDefaulse setObject:encodedData forKey:@"ToDoListTaskes"];
    [_insertNewIteam didSaveTask:newTask];
    BOOL result=[myDefaulse synchronize];
    NSLog(@"Task saved successfully.");
    
    [self.navigationController popViewControllerAnimated:YES];
}
 - (NSString *)formattedDate {
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     return [dateFormatter stringFromDate:[NSDate date]];
 }

@end
