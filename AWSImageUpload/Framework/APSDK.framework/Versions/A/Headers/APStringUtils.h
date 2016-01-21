//
//  APStringUtils.h
//  AnyPresence SDK
//

#import "APObject.h"

extern NSString * const kAPInterpolationDefaultKey;
extern NSString * const kAPInterpolationUserKey;
extern NSString * const kAPInterpolationRelationKey;

typedef void(^Update)(NSString * string);

@class APObject;

@interface APStringUtils : NSObject

+ (NSDictionary *)context:(id)context withInstanceOfSelf:(APObject *)object;
+ (NSString *)interpolateString:(NSString *)string withObject:(id)object;
+ (NSString *)urlEncodeString:(NSString *)string;

@end
