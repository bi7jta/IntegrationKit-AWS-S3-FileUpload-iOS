//
//  Typedefs.h
//  AnyPresence SDK
//

/*!
 @header Typedefs
 @abstract Typedefs
 */

#ifndef AnyPresence_SDK_Typedefs_h
#define AnyPresence_SDK_Typedefs_h

/*!
 @typedef APCallback
 @abstract Simple callback.
 @param error Error that has occured while executing the request, if any.
 */
typedef void(^APCallback)(NSError * error);

/*!
 @typedef APObjectCallback
 @abstract Callback that returns one object.
 @param object Object.
 @param error Error that has occured while executing the request, if any.
 */
typedef void(^APObjectCallback)(id object, NSError * error);

/*!
 @typedef APObjectsCallback
 @abstract Callback that returns an array of objects.
 @param objects Array of objects.
 @param error Error that has occured while executing the request, if any.
 */
typedef void(^APObjectsCallback)(NSArray * objects, NSError * error);

/*!
 @typedef APPushCallback
 @abstract Callback that returns response data for push notification requests.
 @param response Response to push notification request.
 @param error Error that has occured while executing the request, if any.
 */
typedef void(^APPushCallback)(NSString *response, NSError * error);

#endif
