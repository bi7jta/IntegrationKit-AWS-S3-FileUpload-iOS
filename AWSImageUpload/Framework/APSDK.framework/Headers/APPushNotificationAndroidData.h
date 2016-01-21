//
//  APPushNotificationAndroidData.h
//  AnyPresence SDK
//

#import <Foundation/Foundation.h>

/*!
 @class APPushNotificationAndroidData
 @abstract Represents Android data required for sending push notifications to a device.
 */
@interface APPushNotificationAndroidData : NSObject

/*!
 @var collapseKey
 @abstract An arbitrary string (such as "Updates Available") that is used to collapse a group of like messages when the device is offline, so that only the last message gets sent to the client. This is intended to avoid sending too many messages to the phone when it comes back online.
 */
@property (nonatomic, strong) NSString *collapseKey;

/*!
 @var delayWhileIdle
 @abstract True indicates that the message should not be sent immediately if the device is idle.
 */
@property (nonatomic, assign) BOOL *delayWhileIdle;

/*!
 @var ttl
 @abstract How long (in seconds) the message should be kept on GCM storage if the device is offline.
 */
@property (nonatomic, strong) NSNumber *ttl;

@end
