//
//  APPushNotification.h
//  AnyPresence SDK
//

#import <Foundation/Foundation.h>
#import "Typedefs.h"
#import "APPushNotificationIOSData.h"
#import "APPushNotificationAndroidData.h"

/*!
 @class APPushNotification
 @abstract Provides the means to register devices/channels and ability to send messages through APNS.
 */
@interface APPushNotification : NSObject

/*!
@method registerDevice:callback:
@abstract Registers a device to push notifications
@param deviceId Device identifier. Nil values and empty strings will cause a failed response upon request completion.
@param callback Callback to be execute after registration request is complete.
*/
+ (void)registerDevice:(NSString *)deviceId
              callback:(APPushCallback)callback;

/*!
 @method unregisterDevice:callback:
 @abstract Unregisters a device from push notifications.
 @param deviceId Device identifier. Nil values and empty strings will cause a failed response upon request completion.
 @param callback Callback to be execute after request to unregister device is complete.
 */
+ (void)unregisterDevice:(NSString *)deviceId
                callback:(APPushCallback)callback;

/*!
 @method subscribeToChannel:deviceId:callback:
 @abstract Subscribes to channel.
 @param channelName Name of channel to subscribe. Nil values and empty strings will cause a failed response upon request completion.
 @param deviceId Device identifier. Nil values and empty strings will cause a failed response upon request completion.
 @param callback Callback to be execute after channel subscription request is complete.
 */
+ (void)subscribeToChannel:(NSString *)channelName
                  deviceId:(NSString *)deviceId
                  callback:(APPushCallback)callback;

/*!
 @method unsubscribeToChannel:deviceId:callback:
 @abstract Unsubcribes from a channel.
 @param channelName Name of channel to unsubscribe. Nil values and empty strings will cause a failed response upon request completion.
 @param deviceId Device identifier. Nil values and empty strings will cause a failed response upon request completion.
 @param callback Callback to be execute after request to unsubscibe from channel is complete.
 */
+ (void)unsubscribeFromChannel:(NSString *)channelName
                      deviceId:(NSString *)deviceId
                      callback:(APPushCallback)callback;

/*!
 @method sendMessage:channelName:data:callback:
 @abstract Sends a message to a desired channel.
 @param payload Message to be sent.
 @param channelName Name of subscribed channel to which message is to be sent. Nil values and empty strings will cause a failed response upon request completion.
 @param iOSData Object containing alert, sound, badge and expiry information for use with APNS messages.
 @param androidData Object containing collapse key, delay and TTL information for use with GSM messages.
 @param callback Callback to be execute after message request is complete.
 */
+ (void)sendMessage:(NSString *)payload
        channelName:(NSString *)channelName
            iOSData:(APPushNotificationIOSData *)iOSData
        androidData:(APPushNotificationAndroidData *)androidData
           callback:(APPushCallback)callback;

@end
