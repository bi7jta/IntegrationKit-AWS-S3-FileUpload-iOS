//
//  APRequest.h
//  AnyPresence SDK
//

/*!
 @header APRequest
 @abstract APRequest class
 */

#import <Foundation/Foundation.h>

/*!
 @enum APRequestVerb
 @abstract Request operation.
 @constant kAPRequestVerbCreate Create.
 @constant kAPRequestVerbRead Read.
 @constant kAPRequestVerbUpdate Update.
 @constant kAPRequestVerbDelete Delete.
 */
typedef enum {
    kAPRequestVerbCreate,
    kAPRequestVerbRead,
    kAPRequestVerbUpdate,
    kAPRequestVerbDelete
} APRequestVerb;

/*!
 @typedef APRequestCallback
 @abstract Callback with response data.
 @param response Response data.
 @param error Error that has occured while executing the request, if any.
 */
typedef void(^APRequestCallback)(NSData * response, NSError * error);

/*!
 @const kAPRequestBaseURLException
 @abstract Exception thrown when no base URL has been set.
 */
extern NSString * const kAPRequestBaseURLException;

/*!
 @const kAPRequestConcurrentRequestException
 @abstract Exception thrown when request is instructed to load while already loading.
 */
extern NSString * const kAPRequestConcurrentRequestException;

/*!
 @const kAPRequestErrorDomain
 @abstract Default error domain for request errors.
 */
extern NSString * const kAPRequestErrorDomain;

/*!
 @const kAPRequestErrorURLResponseKey
 @abstract Key for underlying NSHTTPURLResponse object in userInfo.
 */
extern NSString * const kAPRequestErrorURLResponseKey;

/*!
 @const kAPRequestErrorStatusCodeKey
 @abstract Key for HTTP status code in userInfo
 */
extern NSString * const kAPRequestErrorStatusCodeKey;

/*!
 @const kAPRequestErrorNotification
 @abstract Notification that is posted when a @link //apple_ref/occ/clm/APRequest @/link object encounters an error.
 */
extern NSString * const kAPRequestErrorNotification;

/*!
 @const kAPRequestErrorNotificationErrorKey
 @abstract Key for error that caused the @link //apple_ref/occ/clconst/APRequest/kAPRequestErrorNotification @/link.
 */
extern NSString * const kAPRequestErrorNotificationErrorKey;

/*!
 @const kAPRequestErrorServerError
 @abstract Indicates there was a server error. See userInfo for more details.
 */
extern const NSUInteger kAPRequestErrorServerError;

/*!
 @class APRequest
 @abstract Utility class encapsulating an HTTP request.
 @discussion One request can be re-used in a serial manner. To reset a request, call @link //apple_ref/occ/instp/APRequest/abort @/link.
 */
@interface APRequest : NSObject

/*!
 @method initWithVerb:URL:
 @abstract Creates a request to load specified URL.
 @param verb Operation.
 @param URL URL to load.
 @result New request instance.
 */
- (id)initWithVerb:(APRequestVerb)verb URL:(NSURL *)URL;

/*!
 @method initWithVerb:resource:query:
 @abstract Creates a request to specified REST resource.
 @param verb Operation.
 @param name Name of REST resource.
 @param params Request parameters.
 @result New request instance.
 */
- (id)initWithVerb:(APRequestVerb)verb resource:(NSString *)name query:(NSDictionary *)params;

/*!
 @method initWithVerb:resource:query:dataSource:
 @abstract Creates a request to specified REST resource.
 @param verb String representing the desired CRUD operation (i.e. POST).
 @param name Name of REST resource.
 @param params Request parameters.
 @param dataSource Data source containing remote API configuration. (i.e. [AnyPresenceAPI class])  Data source must not be nil.
 @result New request instance.
 */
- (id)initWithVerb:(NSString *)verb resource:(NSString *)name query:(NSDictionary *)params dataSource:(id)dataSource;

/*!
 @method initWithVerb:URL:dataSource:
 @abstract Creates a request to load specified URL.
 @param verb String representing the desired CRUD operation (i.e. POST).
 @param URL URL to load.
 @param dataSource Data source containing remote API configuration.
 @result New request instance.
 */
- (id)initWithVerb:(NSString *)verb URL:(NSURL *)URL dataSource:(id)dataSource;

/*!
 @method setBaseURL:
 @abstract Sets base URL for subsequent requests to REST resources.
 @param URL New base URL.
 */
- (void)setBaseURL:(NSURL *)URL;

/*!
 @method setBody:as:
 @abstract Adds body to request.
 @param data Body contents.
 @param contentType MIME content type for body data.
 */
- (void)setBody:(NSData *)data as:(NSString *)contentType;

/*!
 @method setHttpHeaders:
 @abstract Adds Http Headers to request.
 @param httpHeaders Dictionary with Http Headers.
 */
- (void)setHttpHeaders:(NSDictionary *)httpHeaders;

/*!
 @method setContext:
 @abstract Adds context for interpolation of necessary fields.
 @param context Object instance or NSDictionary of ‘string’ to ‘object instance’ mapping for use with interpolation of headers, request URL, or previously defined variable at SDK creation.  For more details on the use of contexts, see the discussion section in @link //apple_ref/occ/cat/APObject(Remote) @/link.
 */
- (void)setContext:(id)context;

/*!
 @method load:
 @abstract Loads current request synchronously.
 @param error Error that occured while loading, if any.
 @result Data that has been loaded.
 */
- (NSData *)load:(NSError **)error __attribute__((deprecated("Use loadAsync: instead.")));

/*!
 @method loadAsync:
 @abstract Loads current request in background.
 @param callback Callback to be execute after loading completes.
 */
- (void)loadAsync:(APRequestCallback)callback;

/*!
 @method abort
 @abstract Aborts current request. No callbacks will be fired.
 */
- (void)abort;

@end
