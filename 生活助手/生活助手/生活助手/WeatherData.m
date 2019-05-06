//
//  WeatherData.m
//  简约天气通
//
//  Created by 胡潇炜 on 16/5/30.
//  Copyright © 2016年 胡潇炜. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

+(instancetype)accoutWithDic:(NSDictionary *)dic
{
    WeatherData *data = [[self alloc] init];
    
    [data setValuesForKeysWithDictionary:dic];
    
    return data;
}

@end
