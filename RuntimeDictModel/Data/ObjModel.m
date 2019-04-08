

#import "ObjModel.h"
#import "NSObject+Model.h"

@implementation ObjModel

@end

@implementation ObjDataModel
+ (NSDictionary *)arrayContainModelClass {
    return @{@"students": @"ObjDataStudentModel"};
}
@end

@implementation ObjDataTeacherModel
+ (NSDictionary *)replacedKeyFromePropertyName {
    // 当前的 新key, 对应字典(数据)中的 旧key
    return @{@"t_sex": @"sex"};
}
@end

@implementation ObjDataStudentModel

@end
