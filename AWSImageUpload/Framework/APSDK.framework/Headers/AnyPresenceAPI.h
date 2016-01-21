//
//  AnyPresenceAPI.h
//  AnyPresence SDK
//

/*!
 @header AnyPresenceAPI
 @abstract AnyPresenceAPI class
 */

#import "APService.h"

/*!
 @class AnyPresenceAPI
 @abstract Contains configuration for AnyPresence's API.
 */

@interface AnyPresenceAPI : APService

/*!
 @method setBaseURL:
 @abstract Sets base URL for AnyPresence's API.
 @param url Base URL for AnyPresence's API (e.g. http://www.myserver.com/api/v1/).
 */
+ (void)setBaseURL:(NSURL *)url;

/*!
 @method setSSLCertificate:
 @abstract Sets path to certificate associated with AnyPresence's API.
 @param path Path to SSL certificate. (e.g. [[NSBundle mainBundle] pathForResource:@"MyCertificateName" ofType:@"cer"]).  This value must not be nil.
 @discussion Providing nil for a path is strictly prohibited.  Also please note that SSL pinning is incompatible with synchronous networking requests, so client code MUST use the asynchronous APIs.
 */
+ (void)setSSLCertificate:(NSString *)path;

/*!
 @method setBaseURL:withSSLCertificatePath:
 @abstract Sets base URL for AnyPresence's API while enabling and setting the SSL certificate for SSL pinning.
 @param url Base URL for AnyPresence's API (e.g. http://www.myserver.com/api/v1/).
 @param path Path to local SSL certificate for AnyPresence's API (e.g. [[NSBundle mainBundle] pathForResource:@"MyCertificateName" ofType:@"cer"]).  This value must not be nil.
 @discussion When passing a path, make sure the path does not equal nil.  Providing nil for a path is strictly prohibited.
 Also please note that SSL pinning is incompatible with synchronous networking requests, so client code MUST use the asynchronous APIs.
 */
+ (void)setBaseURL:(NSURL *)url withSSLCertificatePath:(NSString *)path;

/*!
 @method certificate
 @abstract Returns the certificate associated with AnyPresence's API.
 @result Binary representation of the certificate associate with AnyPresence's API.
 */
+ (NSData *)certificate;

@end
