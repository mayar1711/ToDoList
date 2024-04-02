//
//  ToDoViewController.h
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "TaskProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoViewController : UIViewController  <UITableViewDataSource ,UITableViewDelegate ,TaskProtocol>

@end

NS_ASSUME_NONNULL_END
