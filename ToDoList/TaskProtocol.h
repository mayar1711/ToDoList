//
//  TaskProtocol.h
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import <Foundation/Foundation.h>
#import "Data.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TaskProtocol <NSObject>
- (void)didSaveTask :(Data *)newTask;
@end

NS_ASSUME_NONNULL_END
