//
//  FSRouterHandler.h
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSRouteHandle : NSObject <NSCopying>

/**
 The serialized URL representation of the Handler.
 */
@property (nonatomic, copy, readonly) NSURL *URL;

/**
 The serialized Rule representation of the Handler. When in UnmatchedURLHandler, rule is null.
 */
@property (nonatomic, copy, readonly, nullable) NSString *rule;

/**
 The query parameters parsed from the incoming URL.
 */
@property (nonatomic, copy, readonly, nullable) NSDictionary *queryParameters;

/**
 A dictionary of values keyed by their parameterized route component matched in the URL path.
 */
@property (nonatomic, copy, readonly, nullable) NSDictionary *routeParameters;

/**
 A dictionary of values keyed by their parameterized context parameter in the open url with context.
 */
@property (nonatomic, copy, readonly, nullable) NSDictionary *contextParameters;
/**
 Create a FSRouteHandle instance.
 */
+ (instancetype)handleWithURL:(NSURL *)URL
                         rule:(nullable NSString *)rule
              routeParameters:(nullable NSDictionary *)routeParameters
            contextParameters:(nullable NSDictionary *)contextParameters;

- (instancetype) init __attribute__((unavailable("init not available, call static instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call static instead")));

@end

NS_ASSUME_NONNULL_END
