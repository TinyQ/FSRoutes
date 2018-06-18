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

@property (nonatomic) NSArray<NSString *> *testURLs;

@property (nonatomic) NSArray<NSString *> *rules;

@end

NS_ASSUME_NONNULL_END
