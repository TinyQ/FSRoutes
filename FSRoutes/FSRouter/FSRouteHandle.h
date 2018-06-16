//
//  FSRouterHandler.h
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import <Foundation/Foundation.h>

@interface FSRouteHandle : NSObject

/**
 The serialized URL representation of the Handler.
 */
@property (nonatomic, copy, readonly) NSURL *URL;

/**
 The serialized Rule representation of the Handler.
 */
@property (nonatomic, copy, readonly) NSString *rule;

/**
 The query parameters parsed from the incoming URL.
 */
@property (nonatomic, copy, readonly) NSDictionary *queryParameters;

/**
 A dictionary of values keyed by their parameterized route component matched in the URL path.
 */
@property (nonatomic, copy, readonly) NSDictionary *routeParameters;

- (instancetype)initWithURL:(NSURL*)URL
                       rule:(NSString *)rule
            routeParameters:(NSDictionary *)routeParameters;

@end
