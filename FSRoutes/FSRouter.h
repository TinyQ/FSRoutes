//
//  FSRouter.h
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import <Foundation/Foundation.h>
@class FSRouteItem;
@class FSRouteHandle;

NS_ASSUME_NONNULL_BEGIN

@interface FSRouter : NSObject

- (void)addRoute:(FSRouteItem *)route handler:(FSRouteHandle *)handle;

- (BOOL)canRoute:(NSURL *)URL;

- (BOOL)routeURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
