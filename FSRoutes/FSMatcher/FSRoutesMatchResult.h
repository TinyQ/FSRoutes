//
//  FSRoutesMatchResult.h
//  FSRoutes
//
//  Created by qfu on 21/09/2017.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSRoutesMatchResult : NSObject

@property (nonatomic) BOOL match;
@property (nonatomic) NSDictionary<NSString *,NSString *> *parameter;

@end

NS_ASSUME_NONNULL_END
