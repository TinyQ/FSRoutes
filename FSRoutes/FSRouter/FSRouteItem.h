//
//  FSRouterItem.h
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSRouteItem : NSObject <NSCopying>

@property (nonatomic, copy) NSString *introdution;

@property (nonatomic, copy) NSArray<NSString *> *testURLs;

@property (nonatomic, copy) NSArray<NSString *> *rules;

@end

NS_ASSUME_NONNULL_END
