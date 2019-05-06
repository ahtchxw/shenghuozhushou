//
//  AirData.h
//  生活助手
//
//  Created by Turing on 18/4/14.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirData : NSObject

/**
 *
 
 aqi 	空气质量指数，AQI和PM25的关系 	74
 main 	主要污染物 	pm25
 qlty 	空气质量，取值范围:优，良，轻度污染，中度污染，重度污染，严重污染，查看计算方式 	良
 pm10 	pm10 	78
 pm25 	pm25 	66
 no2 	二氧化氮 	40
 so2 	二氧化硫 	30
 co 	一氧化碳 	33
 o3 	臭氧 	20
 pub_time 	数据发布时间,格式yyyy-MM-dd HH:mm 	2017-03-20 12:30
 */
@property(nonatomic,copy)NSString *aqi;

@property(nonatomic,copy)NSString *main;

@property(nonatomic,copy)NSString *qlty;

@property(nonatomic,copy)NSString *pm10;

@property(nonatomic,copy)NSString *pm25;

@property(nonatomic,copy)NSString *no2;

@property(nonatomic,copy)NSString *so2;
@property(nonatomic,copy)NSString *co;
@property(nonatomic,copy)NSString *o3;
@property(nonatomic,copy)NSString *pub_time;

+(instancetype)accoutWithDic:(NSDictionary *)dic;

@end
