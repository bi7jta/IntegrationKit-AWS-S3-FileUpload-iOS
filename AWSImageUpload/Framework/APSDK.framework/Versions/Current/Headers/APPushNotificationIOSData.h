//
//  APPushNotificationIOSData.h
//  AnyPresence SDK
//

#import <Foundation/Foundation.h>

/*!
 @class APPushNotificationIOSData
 @abstract Represents APNS data required for sending push notifications to a device.
 */
@interface APPushNotificationIOSData : NSObject

/*!
 @var alert
 @abstract An alert message to display to the user.
 */
@property (nonatomic, strong) NSString *alert;

/*!
 @var sound
 @abstract The name of a sound file in the app bundle.
 */
@property (nonatomic, strong) NSString *sound;

/*!
 @var badge
 @abstract The number to display as the badge of the app icon.
 */
@property (nonatomic, strong) NSNumber *badge;

/*!
 @var expiry
 @abstract A fixed UNIX epoch date expressed in seconds (UTC) that identifies when the notification is no longer valid and can be discarded.
 */
@property (nonatomic, strong) NSNumber *expiry;

@end
