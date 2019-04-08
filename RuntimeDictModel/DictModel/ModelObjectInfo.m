//
//  ModelObjectInfo.m
//  RuntimeDictModel
//
//  Created by Yuns on 2019/4/8.
//  Copyright © 2019 None. All rights reserved.
//

#import "ModelObjectInfo.h"
#import <objc/runtime.h>

@implementation ModelObjectInfo

/// 模型转字典
+ (NSDictionary *)dictWithObject:(id)obj {
    // 创建字典对象
    id dict = [NSMutableDictionary dictionary];
    
    unsigned int count = 0;
    
    // 获取对象属性列表
    Ivar *ivarList = class_copyIvarList([obj class], &count);
    
    // 遍历属性列表
    for (int i = 0; i < count; i++) {
        
        // 获取对象属性
        Ivar ivar = ivarList[i];
        
        // 获取对象属性名: C -> OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 去对象中取出对应value
        id value = [obj valueForKey:ivarName];
        
        // 获取对象属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        ivarType = [[ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        // 二级转换：对象中有模型对象
        if (NSClassFromString(ivarType) != nil && ![ivarType containsString:@"NS"]) {
            // 模型转字典
            value = [self dictWithObject:value];
        }
        
        // 三级转换：对象中有数组
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *arrDict = [NSMutableArray array];
            // 遍历模型数组
            for (id obj in value) {
                // 字典转模型
                id muDict =  [self dictWithObject:obj];
                [arrDict addObject:muDict];
            }
            
            // 把模型数组赋值给value
            value = arrDict;
        }
        
        // KVC赋值
        if (value) {
            [dict setValue:value forKey:ivarName];
        }
    }
    return dict;
}

@end
