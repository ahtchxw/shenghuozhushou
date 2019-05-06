//
//  AirData.m
//  生活助手
//
//  Created by Turing on 18/4/14.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import "AirData.h"

@implementation AirData


+(instancetype)accoutWithDic:(NSDictionary *)dic
{
    AirData *data = [[self alloc] init];
    
    [data setValuesForKeysWithDictionary:dic];
    
    return data;
}


@end
