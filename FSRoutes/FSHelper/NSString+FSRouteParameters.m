//
//  NSString+FSRouteParameters.m
//  FSRoutes
//
//  Created by qfu on 2018/6/12.
//

//  Copy from deeplink NSString+DPLQuery.h|m

#import "NSString+FSRouteParameters.h"

@implementation NSString (FSRouteParameters)

+ (NSString *)fs_queryStringWithParameters:(NSDictionary *)parameters {
    NSMutableString *query = [NSMutableString string];
    [[parameters allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        NSString *value = [parameters[key] description];
        key   = [key fs_stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        value = [value fs_stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [query appendFormat:@"%@%@%@%@", (idx > 0) ? @"&" : @"", key, (value.length > 0) ? @"=" : @"", value];
    }];
    return [query copy];
}

- (NSDictionary *)fs_parametersFromQueryString {
    NSArray *params = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionaryWithCapacity:[params count]];
    for (NSString *param in params) {
        NSArray *pairs = [param componentsSeparatedByString:@"="];
        if (pairs.count == 2) {
            // e.g. ?key=value
            NSString *key   = [pairs[0] fs_stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *value = [pairs[1] fs_stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (key && value) {
                paramsDict[key] = value;
            }
        } else if (pairs.count == 1) {
            // e.g. ?key. key may be nil in sometimes
            NSString *key = [[pairs firstObject] fs_stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (key) {
                paramsDict[key] = @"";
            }
        }
    }
    return [paramsDict copy];
}

#pragma mark - URL Encoding/Decoding

- (NSString *)fs_stringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet *allowedCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~"];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharactersSet];
}

- (NSString *)fs_stringByReplacingPercentEscapesUsingEncoding:(NSStringEncoding)encoding {
    return [self stringByRemovingPercentEncoding];
}

@end
