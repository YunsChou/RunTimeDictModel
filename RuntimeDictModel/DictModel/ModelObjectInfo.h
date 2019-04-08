//
//  ModelObjectInfo.h
//  RuntimeDictModel
//
//  Created by Yuns on 2019/4/8.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 将长信息打印完全
#ifdef DEBUG
#define RTDLog(FORMAT, ...) fprintf(stderr, "%s:%d\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define RTDLog(FORMAT, ...) nil
#endif

@interface ModelObjectInfo : NSObject

/// 模型转字典
+ (NSDictionary *)dictWithObject:(id)obj;

@end
