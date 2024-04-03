//
//  Data.m
//  ToDoList
//
//  Created by Mayar on 02/04/2024.
//

#import "Data.h"

@implementation Data

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_dis forKey:@"dis"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeObject:_pir forKey:@"pir"];
    [coder encodeObject:_state forKey:@"state"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _dis = [coder decodeObjectForKey:@"dis"];
        _date = [coder decodeObjectForKey:@"date"];
        _pir = [coder decodeObjectForKey:@"pir"];
        _state =[coder decodeObjectForKey:@"state"];
    }
    return self;
}

@end

