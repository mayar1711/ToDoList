//
//  Data.h
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Data : NSObject  <NSCoding>
   
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *dis;
@property (nonatomic, copy) NSString *date;
@property (nonatomic , copy) NSString *pir;
@property (nonatomic,copy)NSString *state;


@end

NS_ASSUME_NONNULL_END
