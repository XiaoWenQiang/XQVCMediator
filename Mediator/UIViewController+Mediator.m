//
//  UIViewController+Mediator.m
//  XQVCMediator
//
//  Created by xiao qiang on 2018/3/26.
//  Copyright © 2018年 xiao qiang. All rights reserved.
//

#import "UIViewController+Mediator.h"
#import <objc/runtime.h>
#import "XQVCMediatorHeader.h"

@implementation UIViewController (Mediator)

- (NSString *)xq_string {
    return objc_getAssociatedObject(self, @"xq_string");
}

- (void)setXq_string:(NSString *)xq_string
{
    objc_setAssociatedObject(self, @"xq_string", xq_string, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)xq_query
{
    return objc_getAssociatedObject(self, @"xq_query");
}

- (void)setXq_query:(NSDictionary *)xq_query
{
    objc_setAssociatedObject(self, @"xq_query", xq_query, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)xq_params
{
    return objc_getAssociatedObject(self, @"xq_params");
}

- (void)setXq_params:(NSDictionary *)xq_params
{
    objc_setAssociatedObject(self, @"xq_params", xq_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (id)xq_vcWithString:(NSString *)string {
    return [self xq_vcWithString:string query:nil];
}

+ (id)xq_vcWithString:(NSString *)string query:(NSDictionary *)query {
    NSURL *url = [NSURL URLWithString:string];
    // 表示传递过来的不能得到URL
    if (url == nil) {
        // 转换成utf8编码的
        NSString *uft8String = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        url = [NSURL URLWithString:uft8String];
    }
    if (url == nil) {
        return nil;
    }
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    Class cls = nil;
    // 本地跳转页面
    if ([scheme isEqualToString:XQVCMediator_Scheme]) {
        cls = NSClassFromString(host);
    } else {
        // 有可能将来是有其他的
    }
    if (cls == nil) {
        return nil;
    }
    UIViewController *result = [[cls alloc] init];
    result.xq_query = query;
    result.xq_string = string;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (NSNotFound != [string rangeOfString:@"?"].location) {
        NSString *paramString = [string substringFromIndex:([string rangeOfString:@"?"].location + 1)];
        NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner *scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString *pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString *key = kvPair[0];
                NSString *value = kvPair[1];
                [params setValue:value forKey:key];
            }
        }
    }
    result.xq_params = params;
    
    return result;
    
}

@end
