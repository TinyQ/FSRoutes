//
//  FSRoutesMatcher.m
//  FSRoutes
//
//  Created by qfu on 21/09/2017.
//

#import "FSRoutesMatcher.h"

static NSString * const FSRoutesMatcherPathParametersPattern = @":[a-zA-Z0-9-_][^/]+";

@interface FSRoutesMatcher()

@property (nonatomic) NSString *rule;
@property (nonatomic) NSString *rule_scheme;
@property (nonatomic) NSString *rule_expression;

@end

@implementation FSRoutesMatcher

+ (instancetype)matcherWithRule:(NSString *)rule {
    NSParameterAssert(rule);
    return [[FSRoutesMatcher alloc] initWithRule:rule];;
}

- (instancetype)initWithRule:(NSString *)rule {
    self = [super init];
    if (self) {
        _rule = rule;
        _rule_scheme = [self schemeFromRule:rule];
        _rule_expression = [self expressionFromRule:rule];
    }
    return self;
}

- (FSRoutesMatchResult *)match:(NSURL *)url {
    NSParameterAssert(url);
    NSString *url_scheme = url.scheme;
    if (!self.rule_scheme) {
        return nil;
    }
    if (![self.rule_scheme isEqualToString:url_scheme]) {
        return nil;
    }
    FSRoutesMatchResult *result = [[FSRoutesMatchResult alloc] init];
    // TODO:
    return result;
}

#pragma mark - private

- (NSString *)schemeFromRule:(NSString *)rule {
    NSArray *parts = [rule componentsSeparatedByString:@"://"];
    return parts.count > 1 ? [parts firstObject] : nil;
}

- (NSString *)expressionFromRule:(NSString *)rule {
    NSArray *parts = [rule componentsSeparatedByString:@"://"];
    return parts.count == 2 ? [parts lastObject] : nil;
}

+ (NSArray<NSString *> *)pathParametersFromExpression:(NSString *)expression {
    NSRegularExpression *componentRegex = [NSRegularExpression regularExpressionWithPattern:FSRoutesMatcherPathParametersPattern
                                                                                    options:0
                                                                                      error:nil];
    NSArray *matches = [componentRegex matchesInString:expression
                                               options:0
                                                 range:NSMakeRange(0, expression.length)];
    NSMutableArray *namedGroupTokens = [NSMutableArray array];
    for (NSTextCheckingResult *result in matches) {
        NSString *namedGroupToken = [expression substringWithRange:result.range];
        [namedGroupTokens addObject:namedGroupToken];
    }
    return [NSArray arrayWithArray:namedGroupTokens];
}

@end
