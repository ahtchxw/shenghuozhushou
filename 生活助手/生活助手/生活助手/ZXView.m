//
//  ZXView.m
//  折线图
//
//  Created by iOS on 16/6/28.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "ZXView.h"
#import "AFNetworking.h"
#import "AirData.h"

@interface ZXView ()
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;
@property (nonatomic, strong)UIBezierPath * path1;
/** 渐变背景视图 */
@property (nonatomic, strong) UIView *gradientBackgroundView;
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;

@property(nonatomic,strong)AirData *data;
@end
@implementation ZXView
static CGFloat bounceX = 20;
static CGFloat bounceY = 20;
static NSInteger countq = 0;
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     //   self.my
        self.backgroundColor = [UIColor whiteColor];
        
        [self weatherData];
        
        [self createLabelX];
        [self createLabelY];
        [self drawGradientBackgroundView];
        [self setLineDash];
          }
    return self;
}

- (void)drawRect:(CGRect)rect{
       /*******画出坐标轴********/
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextMoveToPoint(context, bounceX, bounceY);
    CGContextAddLineToPoint(context, bounceX, rect.size.height - bounceY);
    CGContextAddLineToPoint(context,rect.size.width -  bounceX, rect.size.height - bounceY);
    CGContextStrokePath(context);
    
}


-(void)weatherData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/air/now?location=auto_ip&key=9ebb4f12d9164806a20f7542824acae4"];
    NSString* url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",url);
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
        NSMutableDictionary *dic = responseObject[@"HeWeather6"][0][@"air_now_city"];
        
        AirData *data = [AirData accoutWithDic:dic];
        self.data = data;
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"failure");
        
    }];
}


#pragma mark 添加虚线
- (void)setLineDash{

    for (NSInteger i = 0;i < 6; i++ ) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
          dashLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 1.0;


        UILabel * label1 = (UILabel*)[self viewWithTag:2000 + i];
        
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor blueColor];
        
        [color set];
 [path moveToPoint:CGPointMake( 0, label1.frame.origin.y - bounceY)];
 [path addLineToPoint:CGPointMake(self.frame.size.width - 2*bounceX,label1.frame.origin.y - bounceY)];
        CGFloat dash[] = {10,10};
        [path setLineDash:dash count:2 phase:10];
        [path stroke];
        dashLayer.path = path.CGPath;
        [self.gradientBackgroundView.layer addSublayer:dashLayer];
         }
}

#pragma mark 画折线图
- (void)dravLine{
    
    UILabel * label = (UILabel*)[self viewWithTag:1000];
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    self.path1 = path;
    UIColor * color = [UIColor greenColor];
    [color set];
    //[path moveToPoint:CGPointMake( label.frame.origin.x - bounceX, (600 -arc4random()%600) /600.0 * (self.frame.size.height - bounceY*2 )  )];


    
    //创建折现点标记
    for (NSInteger i = 0; i< 6; i++) {
        UILabel * label1 = (UILabel*)[self viewWithTag:1000 + i];
        //CGFloat  arc = arc4random()%600;
        
        
        //[path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -arc) /600.0 * (self.frame.size.height - bounceY*2 ) )];
        
        if (i==0) {
            
            CGFloat floatString = [self.data.pm25 floatValue]*3.0;
            [path moveToPoint:CGPointMake( label.frame.origin.x - bounceX, (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 )  )];
            [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) )];
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) , 30, 15)];
            //  falglabel.backgroundColor = [UIColor blueColor];
            falglabel.tag = 3000+ i;
            falglabel.text = self.data.pm25;
            falglabel.font = [UIFont systemFontOfSize:8.0];
            [self addSubview:falglabel];
            
            NSLog(@"pm25 %@",self.data.pm25);
        }
        else if (i==1) {
            
            CGFloat floatString = [self.data.pm10 floatValue]*3.0;
            [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) )];
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) , 30, 15)];
            //  falglabel.backgroundColor = [UIColor blueColor];
            falglabel.tag = 3000+ i;
            falglabel.text = self.data.pm10;
            falglabel.font = [UIFont systemFontOfSize:8.0];
            [self addSubview:falglabel];
            NSLog(@"pm10 %@",self.data.pm10);
        }

        else if (i==2) {
            CGFloat floatString = [self.data.no2 floatValue]*3.0;
            [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) )];
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) , 30, 15)];
            //  falglabel.backgroundColor = [UIColor blueColor];
            falglabel.tag = 3000+ i;
            falglabel.text = self.data.no2;
            falglabel.font = [UIFont systemFontOfSize:8.0];
            [self addSubview:falglabel];
            NSLog(@"no2 %@",self.data.no2);
        }
        else if (i==3) {
            CGFloat floatString = [self.data.so2 floatValue]*3.0;
            [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) )];
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) , 30, 15)];
            //  falglabel.backgroundColor = [UIColor blueColor];
            falglabel.tag = 3000+ i;
            falglabel.text = self.data.so2;
            falglabel.font = [UIFont systemFontOfSize:8.0];
            [self addSubview:falglabel];
            NSLog(@"so2 %@",self.data.so2);
        }

        else if (i==4) {
            CGFloat floatString = [self.data.co floatValue]*3.0;
            [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) )];
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) , 30, 15)];
            //  falglabel.backgroundColor = [UIColor blueColor];
            falglabel.tag = 3000+ i;
            falglabel.text = self.data.co;
            falglabel.font = [UIFont systemFontOfSize:8.0];
            [self addSubview:falglabel];
            NSLog(@"co %@",self.data.co);
        }
        
        else {
            CGFloat floatString = [self.data.o3 floatValue]*3.0;
            [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 ) )];
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (600 -floatString) /600.0 * (self.frame.size.height - bounceY*2 )  , 30, 15)];
            //  falglabel.backgroundColor = [UIColor blueColor];
            falglabel.tag = 3000+ 5;
            falglabel.text = self.data.o3;
            falglabel.font = [UIFont systemFontOfSize:8.0];
            [self addSubview:falglabel];
            NSLog(@"o3 %@",self.data.o3);
        }


        
    }
    // [path stroke];
    
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    self.lineChartLayer.lineWidth = 0;
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    
    [self.gradientBackgroundView.layer addSublayer:self.lineChartLayer];//直接添加导视图上
 //   self.gradientBackgroundView.layer.mask = self.lineChartLayer;//添加到渐变图层

}
#pragma mark 创建x轴的数据
- (void)createLabelX{
    //CGFloat  month = 12;
    for (NSInteger i = 0; i < 6; i++) {
//        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/month * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/month- 5, bounceY/2)];
        if (i==0) {
            UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/6 * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/6- 5, bounceY/2)];
            //       LabelMonth.backgroundColor = [UIColor greenColor];
            LabelMonth.tag = 1000 + i;
            LabelMonth.text = @"pm2.5";
            LabelMonth.font = [UIFont systemFontOfSize:10];
            //LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
            [self addSubview:LabelMonth];
        }
        else if (i==1) {
            UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/6 * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/6- 5, bounceY/2)];
            //       LabelMonth.backgroundColor = [UIColor greenColor];
            LabelMonth.tag = 1000 + i;
            LabelMonth.text = @"pm10";
            LabelMonth.font = [UIFont systemFontOfSize:10];
            //LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
            [self addSubview:LabelMonth];
        }
        
        else if (i==2) {
            UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/6 * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/6- 5, bounceY/2)];
            //       LabelMonth.backgroundColor = [UIColor greenColor];
            LabelMonth.tag = 1000 + i;
            LabelMonth.text = @"no2";
            LabelMonth.font = [UIFont systemFontOfSize:10];
            //LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
            [self addSubview:LabelMonth];
        }
        else if (i==3) {
            UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/6 * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/6- 5, bounceY/2)];
            //       LabelMonth.backgroundColor = [UIColor greenColor];
            LabelMonth.tag = 1000 + i;
            LabelMonth.text = @"so2";
            LabelMonth.font = [UIFont systemFontOfSize:10];
            //LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
            [self addSubview:LabelMonth];
        }
        else if (i==4) {
            UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/6 * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/6- 5, bounceY/2)];
            //       LabelMonth.backgroundColor = [UIColor greenColor];
            LabelMonth.tag = 1000 + i;
            LabelMonth.text = @"co";
            LabelMonth.font = [UIFont systemFontOfSize:10];
            //LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
            [self addSubview:LabelMonth];
        }
        
        else {
            UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/6 * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/6- 5, bounceY/2)];
            //       LabelMonth.backgroundColor = [UIColor greenColor];
            LabelMonth.tag = 1000 + 5;
            LabelMonth.text = @"o3";
            LabelMonth.font = [UIFont systemFontOfSize:10];
            //LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
            [self addSubview:LabelMonth];
        }
    }

}
#pragma mark 创建y轴数据
- (void)createLabelY{
    CGFloat Ydivision = 2;
    for (NSInteger i = 0; i < Ydivision; i++) {
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height - 2 * bounceY)/Ydivision *i + bounceX, bounceY, bounceY/2.0)];
     //   labelYdivision.backgroundColor = [UIColor greenColor];
        labelYdivision.tag = 2000 + i;
        labelYdivision.text = [NSString stringWithFormat:@"%.0f",(Ydivision - i)*100];
         labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
    }
}


#pragma mark 渐变的颜色
- (void)drawGradientBackgroundView {
    // 渐变背景视图（不包含坐标轴）
    self.gradientBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(bounceX, bounceY, self.bounds.size.width - bounceX*2, self.bounds.size.height - 2*bounceY)];
    [self addSubview:self.gradientBackgroundView];
    /** 创建并设置渐变背景图层 */
    //初始化CAGradientlayer对象，使它的大小为渐变背景视图的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientBackgroundView.bounds;
    //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
    self.gradientLayer.startPoint = CGPointMake(0, 0.0);
    self.gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    //设置颜色的渐变过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:253 / 255.0 green:164 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:251 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.gradientBackgroundView.layer addSublayer:self.gradientLayer];
     //[self.layer addSublayer:self.gradientLayer];
}




#pragma mark 点击重新绘制折线和背景
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    countq++;
    if (countq%2 == 0) {
        [self.lineChartLayer removeFromSuperlayer];
        for (NSInteger i = 0; i < 12; i++) {
            UILabel * label = (UILabel*)[self viewWithTag:3000 + i];
            [label removeFromSuperview];
        }
    }else{

        [self dravLine];

    self.lineChartLayer.lineWidth = 2;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = self;
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
        //[self setNeedsDisplay];
    }
}
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始®");
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"停止~~~~~~~~");
}
@end
