//
//  UIViewController+Mediator.h
//  XQVCMediator
//
//  Created by xiao qiang on 2018/3/26.
//  Copyright © 2018年 xiao qiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Mediator)

@property (nonatomic, copy) NSString *xq_string;
@property (nonatomic, strong) NSDictionary *xq_query;
@property (nonatomic, strong) NSDictionary *xq_params;

+ (id)xq_vcWithString:(NSString *)string;
+ (id)xq_vcWithString:(NSString *)string query:(NSDictionary *)query;

@end
