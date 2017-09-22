//
//  ViewController.m
//  FSRoutesProject
//
//  Created by qfu on 19/09/2017.
//  Copyright © 2017 qfu. All rights reserved.
//

#import "ViewController.h"
#import <FSRoutes/FSRoutes.h>
#import <FSRoutes/FSRoutesMatcher.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *rule = @"http://www.baidu.com/aaa/:param_0/bbb/:param_1/ccc/:param_2s";
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/aaa/123/bbb/321/ccc/444"];
    
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:rule];
    FSRoutesMatchResult *result = [matcher match:url];
    NSLog(@"%@",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
