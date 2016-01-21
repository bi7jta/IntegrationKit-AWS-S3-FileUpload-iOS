//
//  Upload.h
//  AnyPresence SDK
//

/*!
 @header Upload
 @abstract Upload class
 */

#import "APObject.h"
#import "Typedefs.h"

/*!
 @class Upload
 @abstract Generated model object: Upload.
 @discussion Use @link //apple_ref/occ/cat/Upload(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Upload/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Upload : APObject {
}

/*!
 @method dataSource
 @abstract Returns the data source class associated with a Upload.
 @result Class representing the data source associated with a Upload.
 */
+ (Class)dataSource;

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key. Generated on the server.
 */
@property (nonatomic, strong) NSString * id;

/*!
 @var createdAt
 @abstract Generated model property: created_at.
 */
@property (nonatomic, strong) NSDate * createdAt;

/*!
 @var link
 @abstract Generated model property: link.
 */
@property (nonatomic, strong) NSString * link;

/*!
 @var name
 @abstract Generated model property: name.
 */
@property (nonatomic, strong) NSString * name;

@end
