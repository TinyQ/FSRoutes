//
//  FSRoutesMatchResult.h
//  FSRoutes
//
//  Created by qfu on 21/09/2017.
//

#import <Foundation/Foundation.h>

@interface FSRoutesMatchResult : NSObject

@property (nonatomic) BOOL isMatch;
@property (nonatomic) NSArray<NSString *> *pathParameters;

@end
