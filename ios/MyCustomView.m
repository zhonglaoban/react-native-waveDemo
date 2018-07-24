//
//  MyCustomView.m
//  wavedemo
//
//  Created by 钟凡 on 2018/7/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "MyCustomView.h"

@implementation MyCustomView
-(void)drawLines:(NSArray *)points lineWidth:(CGFloat)lineWidth color:(UIColor *)color {
  CAShapeLayer *lineLayer = [CAShapeLayer layer];
  UIBezierPath *path = [UIBezierPath bezierPath];
  for (int i = 0; i < points.count; i++) {
    NSDictionary *pointDict = points[i];
    CGFloat x = [pointDict[@"x"] floatValue];
    CGFloat y = [pointDict[@"y"] floatValue];
    CGPoint point = CGPointMake(x, y);
    if (i == 0) {
      [path moveToPoint:point];
    }else {
      [path addLineToPoint:point];
    }
  }
  lineLayer.path = path.CGPath;
  lineLayer.lineWidth = lineWidth;
  lineLayer.strokeColor = color.CGColor;
  lineLayer.fillColor = [UIColor clearColor].CGColor;
  [self.layer addSublayer:lineLayer];
}

@end
