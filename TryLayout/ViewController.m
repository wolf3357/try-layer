//
//  ViewController.m
//  TryLayout
//
//  Created by 金人网络 on 16/3/9.
//  Copyright © 2016年 金人网络. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)CALayer * layer1;
@property (nonatomic,strong)CALayer * layermin;
@property (nonatomic,strong)CALayer * layertime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_background"]];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];
    
    [self setCilke];
    [self setlayer];
}

-(void)setCilke{
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_background"]];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4);
    [self.view addSubview:imageView];
    
    UIImageView * imageCenter = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_center"]];
    imageCenter.frame = CGRectMake(0, 0, 20, 20);
    imageCenter.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4);
    [self.view addSubview:imageCenter];
    
    UIImageView * imageCircle1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_circle1"]];
    imageCircle1.frame = CGRectMake(0, 0, 150, 150);
    imageCircle1.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4);
    [self.view addSubview:imageCircle1];
    
    UIImageView * imageCircle2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_circle2"]];
    imageCircle2.frame = CGRectMake(0, 0, 170, 170);
    imageCircle2.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4);
    [self.view addSubview:imageCircle2];
    
}

-(void)setlayer{
    //动画载体
    self.layer1 = [CALayer layer];
    self.layer1.frame = CGRectMake(0, 0, 207, 207);
    self.layer1.position = CGPointMake(self.view.bounds.size.width/2+1, self.view.bounds.size.height/4+1);
    [self.view.layer addSublayer:self.layer1];
    //设置动画代理
    self.layer1.delegate = self;
    //设置动画
    [self.layer1 setNeedsDisplay];
    
    //动画  作用在layer某个属性上，动画效果不会影响layer原有的属性值
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //动画时长
    animation.duration = 1.0;
    //动画的初始值
    animation.fromValue = [NSNumber numberWithFloat:0];
    //动画的结束时的值
    animation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    //动画结束时的状态
    /*
        kCAFillModeForwards   保持结束时的状态
        kCAFillModeBackwards    回到开始时的状态
        kCAFillModeBoth         兼顾以上的两种效果
        kCAFillModeRemoved      结束时删除效果
     */
    animation.fillMode = kCAFillModeForwards;
    //动画的重复次数
    animation.repeatCount = HUGE_VALF;
    //开始动画
    [self.layer1 addAnimation:animation forKey:@"rotation"];
    
    
    
    self.layermin = [CALayer layer];
    self.layermin.frame = CGRectMake(self.view.bounds.size.width/2-50/2,self.view.bounds.size.height/4-50/2, 200,200);

    self.layermin.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4);
    [self.view.layer addSublayer:self.layermin];
    [self.layermin setNeedsDisplay];
    self.layermin.anchorPoint = CGPointMake(0, 0);
    self.layermin.delegate = self;
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation2.duration = animation.duration*60;
    animation2.fromValue = [NSNumber numberWithFloat:0];
    animation2.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    animation2.repeatCount = HUGE_VALF;
    animation2.fillMode = kCAFillModeForwards;
    [self.layermin addAnimation:animation2 forKey:@"rotation.x"];
    
    
    self.layertime = [CALayer layer];
    self.layertime.frame = CGRectMake(self.view.bounds.size.width/2,self.view.bounds.size.height/4, 10,30);
    //self.layertime.backgroundColor = [UIColor blackColor].CGColor;
    self.layertime.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4);
    [self.view.layer addSublayer:self.layertime];
    [self.layertime setNeedsDisplay];
    //动画运动时的锚点
    self.layertime.anchorPoint = CGPointMake(0.5, 0);
    self.layertime.delegate = self;
    CABasicAnimation * animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation3.duration = animation2.duration*60;
    animation3.fromValue = [NSNumber numberWithFloat:0];
    animation3.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    animation3.fillMode = kCAFillModeForwards;
    animation3.repeatCount = HUGE_VALF;
    [self.layertime addAnimation:animation3 forKey:@"rotation.x"];

}
//实现代理方法
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    if (layer == self.layer1) {
        UIImage * image = [UIImage imageNamed:@"clock_circle3"];
        CGContextDrawImage(ctx, CGRectMake(0, 0, 207, 207), image.CGImage);
    }
    if (layer == self.layermin) {
        UIImage * image = [UIImage imageNamed:@"clock_min"];
        CGContextDrawImage(ctx, CGRectMake(0, 0, 50, 50), image.CGImage);
    }
    if (layer == self.layertime) {
        UIImage * image = [UIImage imageNamed:@"clock_time"];
        CGContextDrawImage(ctx, CGRectMake(0, 0, 10, 30), image.CGImage);
    }
    

    CGContextRestoreGState(ctx);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




























@end

