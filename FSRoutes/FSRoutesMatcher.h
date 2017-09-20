//
//  FSRoutesMatcher.h
//  FSRoutes
//
//  Created by qfu on 21/09/2017.
//

#import <Foundation/Foundation.h>
#import "FSRoutesMatchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSRoutesMatcher : NSObject

/**
 Initializes a route matcher.

 @param rule Match rule string
 @return An route matcher instance.
 */
+ (instancetype)matcherWithRule:(NSString *)rule;

/**
 Matches a URL against the route and returns a result object

 @param url The url to be compared with the rule.
 @return A FSRoutesMatchResult instance if the URL matched the route, otherwise nil.
 */
- (FSRoutesMatchResult *)match:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
