//
//  FSRouterItem.h
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSRouteItem : NSObject

@property (nonatomic) NSString *introdution;

@property (nonatomic) NSArray<NSURL *> *testURLs;

@property (nonatomic) NSArray<NSString *> *patterns;

@end

NS_ASSUME_NONNULL_END
