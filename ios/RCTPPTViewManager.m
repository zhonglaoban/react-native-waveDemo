//
//  RCTPPTViewManager.m
//  wavedemo
//
//  Created by 钟凡 on 2018/7/24.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "RCTPPTViewManager.h"
#import "MyCustomView.h"

@interface RCTPPTViewManager()
@property (nonatomic, strong) MyCustomView *pptView;
@end

@implementation RCTPPTViewManager
RCT_EXPORT_MODULE();

- (UIView *)view {
  MyCustomView *pptView = [[MyCustomView alloc] init];
  self.pptView = pptView;
  return pptView;
}
RCT_EXPORT_METHOD(drawLines:(NSArray *)points lineWidth:(nonnull NSNumber *)lineWidth color:(NSDictionary *)dict)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    CGFloat r = [dict[@"r"] floatValue];
    CGFloat g = [dict[@"g"] floatValue];
    CGFloat b = [dict[@"b"] floatValue];
    CGFloat a = [dict[@"a"] floatValue];
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    [self.pptView drawLines:points lineWidth:[lineWidth floatValue] color:color];
  });
}

@end
