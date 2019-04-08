

#import <Foundation/Foundation.h>

@class ObjDataModel;
@class ObjDataTeacherModel;
@class ObjDataStudentModel;

@interface ObjModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) ObjDataModel *data;
@end

@interface ObjDataModel : NSObject
@property (nonatomic, copy) NSString *c_name;
@property (nonatomic, strong) ObjDataTeacherModel *teacher;
@property (nonatomic, strong) NSArray<ObjDataStudentModel *> *students;
@end

@interface ObjDataTeacherModel : NSObject
@property (nonatomic, copy) NSString *t_name;
@property (nonatomic, assign) NSInteger t_sex;
@end

@interface ObjDataStudentModel : NSObject
@property (nonatomic, copy) NSString *s_name;
@property (nonatomic, assign) NSInteger age;
@end
