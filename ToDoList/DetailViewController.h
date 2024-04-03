//
//  DetailViewController.h
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "TaskProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Data *selectedTask;
@property (nonatomic) NSInteger selectedTaskIndex;
@property (nonatomic, weak) id<TaskProtocol> insertNewIteam;

@end

NS_ASSUME_NONNULL_END
