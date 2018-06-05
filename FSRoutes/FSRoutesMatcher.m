//
//  FSRoutesMatcher.m
//  FSRoutes
//
//  Created by qfu on 21/09/2017.
//

#import "FSRoutesMatcher.h"

static NSString * const FSRNamedGroupComponentPattern = @":[a-zA-Z0-9-_][^/]+";
static NSString * const FSRRouteParameterPattern      = @":[a-zA-Z0-9-_]+";
static NSString * const FSRURLParameterPattern        = @"([^/]+)";

@interface FSRoutesMatcher()

@property (nonatomic) NSString *rule;
@property (nonatomic) NSArray<NSString *> *schemeAndExpression;
@property (nonatomic) NSArray<NSString *> *routeParameterKeys;
@property (nonatomic) NSString *routePattern;
@property (nonatomic) NSRegularExpression *regularExpression;

@end

@implementation FSRoutesMatcher

- (instancetype)initWithRule:(NSString *)rule {
    self = [super init];
    if (self) {
        _rule = rule;
        _schemeAndExpression = [[self class] separatedSchemeAndExpressFromRule:rule];
        _routeParameterKeys = [[self class] routeParametersFromeRule:rule];
        _routePattern = [[self class] routePatternFromRule:[self ruleExpression]];
    }
    return self;
}

#pragma mark - public

+ (instancetype)matcherWithRule:(NSString *)rule {
    NSParameterAssert(rule);
    if ([rule isEqualToString:@""]) {
        return nil;
    }
    return [[FSRoutesMatcher alloc] initWithRule:rule];;
}

- (FSRoutesMatchResult *)match:(NSURL *)url {
    NSParameterAssert(url);
    FSRoutesMatchResult *matchResult = [[FSRoutesMatchResult alloc] init];
    NSString *matchString = [[self class] matchStringFromURL:url];
    if (self.regularExpression == nil) {
        self.regularExpression = [[NSRegularExpression alloc] initWithPattern:self.routePattern options:0 error:nil];
    }
    NSArray *matches = [self.regularExpression matchesInString:matchString options:0 range:NSMakeRange(0, matchString.length)];
    if (!matches.count) {
        return matchResult;
    }
    matchResult.match = YES;
    // Set route parameters in the routeParameters dictionary
    NSMutableDictionary *routeParameters = [NSMutableDictionary dictionary];
    for (NSTextCheckingResult *result in matches) {
        // Begin at 1 as first range is the whole match
        for (NSInteger i = 1; i < result.numberOfRanges && i <= self.routeParameterKeys.count; i++) {
            NSString *parameterName         = self.routeParameterKeys[i - 1];
            NSString *parameterValue        = [matchString substringWithRange:[result rangeAtIndex:i]];
            routeParameters[parameterName]  = parameterValue;
        }
    }
    matchResult.parameter = routeParameters;
    return matchResult;
}

- (NSString *)ruleScheme {
    NSArray *array = self.schemeAndExpression;
    return array.count > 1 ? [array firstObject] : nil;
}

- (NSString *)ruleExpression {
    NSArray *array = self.schemeAndExpression;
    return array.count > 0 ? [array lastObject] : nil;
}

#pragma mark - helper

+ (NSString *)matchStringFromURL:(NSURL *)URL {
    return [NSString stringWithFormat:@"%@%@", URL.host, URL.path];
}

+ (NSArray<NSString *> *)separatedSchemeAndExpressFromRule:(NSString *)rule {
    NSParameterAssert(rule);
    NSString *str = [rule copy];
    return [str componentsSeparatedByString:@"://"];
}

+ (NSArray<NSString *> *)routeParametersTokensFromeRule:(NSString *)rule {
    NSParameterAssert(rule);
    NSString *str = [rule copy];
    NSInteger length = rule.length;
    NSRegularExpression *componentRegex = [NSRegularExpression regularExpressionWithPattern:FSRNamedGroupComponentPattern
                                                                                    options:0
                                                                                      error:nil];
    NSArray *matches = [componentRegex matchesInString:str
                                               options:0
                                                 range:NSMakeRange(0, length)];
    NSMutableArray *namedGroupTokens = [NSMutableArray array];
    for (NSTextCheckingResult *result in matches) {
        NSString *namedGroupToken = [str substringWithRange:result.range];
        [namedGroupTokens addObject:namedGroupToken];
    }
    return [NSArray arrayWithArray:namedGroupTokens];
}

+ (NSArray<NSString *> *)routeParametersFromeRule:(NSString *)rule {
    NSParameterAssert(rule);
    NSString *str = [rule copy];
    NSMutableArray *groupNames = [NSMutableArray array];
    
    NSArray *namedGroupExpressions = [self routeParametersTokensFromeRule:str];
    NSRegularExpression *parameterRegex = [NSRegularExpression regularExpressionWithPattern:FSRRouteParameterPattern
                                                                                    options:0
                                                                                      error:nil];
    for (NSString *namedExpression in namedGroupExpressions) {
        NSArray *componentMatches = [parameterRegex matchesInString:namedExpression
                                                            options:0
                                                              range:NSMakeRange(0, namedExpression.length)];
        NSTextCheckingResult *foundGroupName = [componentMatches firstObject];
        if (foundGroupName) {
            NSString *stringToReplace  = [namedExpression substringWithRange:foundGroupName.range];
            NSString *variableName     = [stringToReplace stringByReplacingOccurrencesOfString:@":"
                                                                                    withString:@""];
            
            [groupNames addObject:variableName];
        }
    }
    return [NSArray arrayWithArray:groupNames];
}

+ (NSString *)routePatternFromRule:(NSString *)rule {
    NSParameterAssert(rule);
    NSString *modifiedStr = [rule copy];
    NSArray *namedGroupExpressions = [self routeParametersTokensFromeRule:modifiedStr];
    NSRegularExpression *parameterRegex = [NSRegularExpression regularExpressionWithPattern:FSRRouteParameterPattern
                                                                                    options:0
                                                                                      error:nil];
    // For each of the named group expressions (including name & regex)
    for (NSString *namedExpression in namedGroupExpressions) {
        NSString *replacementExpression       = [namedExpression copy];
        NSTextCheckingResult *foundGroupName  = [[parameterRegex matchesInString:namedExpression
                                                                         options:0
                                                                           range:NSMakeRange(0, namedExpression.length)] firstObject];
        // If it's a named group, remove the name
        if (foundGroupName) {
            NSString *stringToReplace  = [namedExpression substringWithRange:foundGroupName.range];
            replacementExpression = [replacementExpression stringByReplacingOccurrencesOfString:stringToReplace
                                                                                     withString:@""];
        }
        
        // If it was a named group, without regex constraining it, put in default regex
        if (replacementExpression.length == 0) {
            replacementExpression = FSRURLParameterPattern;
        }
        
        modifiedStr = [modifiedStr stringByReplacingOccurrencesOfString:namedExpression
                                                             withString:replacementExpression];
    }
    
    if (modifiedStr.length && !([modifiedStr characterAtIndex:0] == '/')) {
        modifiedStr = [@"^" stringByAppendingString:modifiedStr];
    }
    modifiedStr = [modifiedStr stringByAppendingString:@"$"];
    return modifiedStr;
}

@end
