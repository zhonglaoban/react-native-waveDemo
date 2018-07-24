//
//  MyCustomView.h
//  wavedemo
//
//  Created by 钟凡 on 2018/7/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomView : UIView
-(void)drawLines:(NSArray *)points lineWidth:(CGFloat)lineWidth color:(UIColor *)color;
@end
