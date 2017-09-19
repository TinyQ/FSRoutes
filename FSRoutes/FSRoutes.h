//
//  FSRoutes.h
//  Pods-FSRoutesProject
//
//  Created by qfu on 19/09/2017.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSRoutes : NSObject

- (instancetype)init;
- (BOOL)routeURL:(NSURL *)URL;
- (BOOL)routeURL:(NSURL *)URL parameters:(nullable NSDictionary<NSString *, id> *)parameters;

@end

NS_ASSUME_NONNULL_END
