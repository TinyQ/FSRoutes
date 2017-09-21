//
//  ViewController.m
//  FSRoutesProject
//
//  Created by qfu on 19/09/2017.
//  Copyright © 2017 qfu. All rights reserved.
//

#import "ViewController.h"
#import <FSRoutes/FSRoutes.h>

static NSString * const DPLNamedGroupComponentPattern22 = @":[a-zA-Z0-9-_][^/]+";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *test = @"www.baidu.com/aaa/:param_0/bbb/:param_1/ccc/:param_2";
    NSArray *testResult = [[self class] namedGroupTokensForString:test];
    NSLog(@"%@",testResult);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSArray *)namedGroupTokensForString:(NSString *)str {
    NSRegularExpression *componentRegex = [NSRegularExpression regularExpressionWithPattern:DPLNamedGroupComponentPattern22
                                                                                    options:0
                                                                                      error:nil];
    NSArray *matches = [componentRegex matchesInString:str
                                               options:0
                                                 range:NSMakeRange(0, str.length)];
    
    NSMutableArray *namedGroupTokens = [NSMutableArray array];
    for (NSTextCheckingResult *result in matches) {
        NSString *namedGroupToken = [str substringWithRange:result.range];
        [namedGroupTokens addObject:namedGroupToken];
    }
    return [NSArray arrayWithArray:namedGroupTokens];
}

@end
