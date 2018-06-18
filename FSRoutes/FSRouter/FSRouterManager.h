//
//  FSRouterManager.h
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import <Foundation/Foundation.h>
@class FSRouter;

@interface FSRouterManager : NSObject

@property (nonatomic, readonly) FSRouter *router;
@property (nonatomic, readonly, class) FSRouterManager *shared;

@end
