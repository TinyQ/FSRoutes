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

typedef BOOL (^FSRouteHandler)(FSRouteHandle *handle);
typedef void (^FSRouteUnmatchedHandler)(FSRouteHandle *handle);

@interface FSRouter : NSObject

@property (nonatomic, readonly) NSMutableOrderedSet<FSRouteItem *> *routes;
@property (nonatomic, readonly) NSMutableOrderedSet<NSString *> *rules;
@property (nonatomic, readonly) NSMutableDictionary<NSString *, id> *handlers;

- (void)addRoute:(FSRouteItem *)route handler:(FSRouteHandler)handler;

- (void)setUnmatchedURLHandler:(FSRouteUnmatchedHandler)handler;

- (BOOL)canRoute:(NSURL *)URL;

- (BOOL)routeURL:(NSURL *)URL;

- (BOOL)routeURL:(NSURL *)URL context:(nullable NSDictionary<NSString *,id> *)context;

@end

NS_ASSUME_NONNULL_END
