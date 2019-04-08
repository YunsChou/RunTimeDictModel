//
//  ViewController.m
//  RuntimeDictModel
//
//  Created by Yuns on 2019/4/8.
//  Copyright © 2019 None. All rights reserved.
//

#import "ViewController.h"
#import "DataMock.h"
#import "ObjModel.h"
#import "NSObject+Model.h"
#import "ModelObjectInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ObjModel *model = [self jsonToModel];
    
    [self dictWithModel:model];
}

// 字典转模型
- (ObjModel *)jsonToModel {
    NSString *json = [DataMock jsonWithSrcName:DataMockJson];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    ObjModel *model = [ObjModel objectWithDict:dict];
    NSLog(@"model: %@", model);
    
    return model;
}

// 模型转字典
- (void)dictWithModel:(id)model {
    NSDictionary *objDict = [ModelObjectInfo dictWithObject:model];
    RTDLog(@"dict: %@", objDict);
}

@end
