

#import "DataMock.h"

@implementation DataMock

+ (NSString *)jsonWithSrcName:(NSString *)srcName {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:srcName ofType:nil];
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    return jsonString;
}

@end
