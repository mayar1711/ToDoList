//
//  ViewController.h
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "TaskProtocol.h"

@interface ViewController : UIViewController

@property (nonatomic, weak) id<TaskProtocol> insertNewIteam;

@end
