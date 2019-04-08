//
//  NSObject+Model.m
//  runtimeDictModel
//
//  Created by weiying on 16/3/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

// 字典转模型
+ (instancetype)objectWithDict:(NSDictionary *)dict
{
    // 创建对应模型对象
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    
    // 获取成员属性列表
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 遍历属性列表
    for (int i = 0; i < count; i++) {
        
        // 获取成员属性
        Ivar ivar = ivarList[i];
        
        // 获取成员属性名: C -> OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // _成员属性名 => 字典key
        NSString *key = [ivarName substringFromIndex:1];
        
        // 去字典中取出对应value给模型属性赋值
        id value = [dict objectForKey:key];
        // 判断对应类是否实现key命名替换协议
        if ([self respondsToSelector:@selector(replacedKeyFromePropertyName)]) {
            // 转换成id类型，就能调用任何对象的方法
            id idSelf = self;
            NSString *dictKey = [[idSelf replacedKeyFromePropertyName] objectForKey:key] ? : key;
            value = [dict objectForKey:dictKey];
        }

        // 获取成员属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 二级转换：字典中还有字典
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType containsString:@"NS"]) { // 是字典对象,并且属性名对应类型是自定义类型
            
            // 处理类型字符串
            ivarType = [[ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            // 获取模型Class
            Class modalClass = NSClassFromString(ivarType);
            
            // 字典转模型
            if (modalClass) {
                // 字典转模型
                value = [modalClass objectWithDict:value];
            }
        }
        
        // 三级转换：字典中有数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类是否实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                
                // 获取数组中字典对应的模型
                NSString *arrValue =  [[idSelf arrayContainModelClass] objectForKey:key];
                
                // 生成模型
                Class classModel = NSClassFromString(arrValue);
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    // 字典转模型
                    id model =  [classModel objectWithDict:dict];
                    [arrM addObject:model];
                }
                
                // 把模型数组赋值给value
                value = arrM;
                
            }
        }
        
        // KVC字典转模型
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    // 返回对象
    return objc;
    
}


@end
