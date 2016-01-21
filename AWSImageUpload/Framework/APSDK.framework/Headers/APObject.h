//
//  APObject.h
//  AnyPresence SDK
//

/*!
 @header APObject
 @abstract APObject class
 */

#import <Foundation/Foundation.h>

/*!
 @class APObject
 @abstract Abstract base class for generated model objects.
 */
@interface APObject : NSObject

/*!
 @method dataSource
 @abstract Returns the data source class associated with the AnyPresence API.
 @result Class representing the data source associated with the AnyPresence API.
 */
+ (Class)dataSource;

@end
