
// https://www.jianshu.com/p/d4d392651038
#import "WaterView.h"

@interface WaterView()
{
  UIColor *_waterColor;
  CGFloat _waterLineY;
  CGFloat _waveAmplitude;
  CGFloat _waveCycle;
  CGFloat _waveWidth;
  BOOL increase;
  CADisplayLink *_waveDisplayLink;
}

@end

@implementation WaterView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor grayColor]];
    _waveAmplitude=3.0;
    _waveCycle=1.0;
    _waveWidth=[UIScreen mainScreen].bounds.size.width;
    increase=NO;
    _waterColor=[UIColor colorWithRed:88/255.0f green:202/255.0f blue:139/255.0f alpha:1];
    _waterLineY=320.0;
    
    
    _waveDisplayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(runWave)];
    [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
  }
  return self;
}
-(void)runWave
{
  
  if (increase) {
    _waveAmplitude += 0.02;
  }else{
    _waveAmplitude -= 0.02;
  }
  
  
  if (_waveAmplitude<=1) {
    increase = YES;
  }
  
  if (_waveAmplitude>=1.5) {
    increase = NO;
  }
  
  _waveCycle+=0.1;
  
  [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointZero];
  [path addArcWithCenter:CGPointMake(150, 50) radius:50 startAngle:0 endAngle:2 clockwise:YES];
  path.lineWidth = 5.0;
  [path stroke];
  
  //初始化画布
  CGContextRef context = UIGraphicsGetCurrentContext();
  //
  //    NSMutableAttributedString *attriButedText=[self formatBatteryLevel:500];
  //    CGRect textSize = [attriButedText boundingRectWithSize:CGSizeMake(400, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
  //    CGPoint textPoint = CGPointMake(_waveWidth/2-textSize.size.width/2, 70);
  //    [attriButedText drawAtPoint:textPoint];
  
  //推入
  CGContextSaveGState(context);
  
  
  //定义前波浪path
  CGMutablePathRef frontPath = CGPathCreateMutable();
  
  //定义后波浪path
  CGMutablePathRef backPath=CGPathCreateMutable();
  
  //定义前波浪反色path
  CGMutablePathRef frontReversePath = CGPathCreateMutable();
  
  //定义后波浪反色path
  CGMutablePathRef backReversePath=CGPathCreateMutable();
  
  //画水
  CGContextSetLineWidth(context, 1);
  
  
  //前波浪位置初始化
  CGFloat frontY=_waterLineY;
  CGPathMoveToPoint(frontPath, NULL, 0, frontY);
  
  //前波浪反色位置初始化
  CGFloat frontReverseY=_waterLineY;
  CGPathMoveToPoint(frontReversePath, NULL, 0,frontReverseY);
  
  //后波浪位置初始化
  CGFloat backY=_waterLineY;
  CGPathMoveToPoint(backPath, NULL, 0, backY);
  
  //后波浪反色位置初始化
  CGFloat backReverseY=_waterLineY;
  CGPathMoveToPoint(backReversePath, NULL, 0, backReverseY);
  
  for(CGFloat x=0;x<=_waveWidth;x++){
    
    //前波浪绘制
    frontY= _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + _waterLineY;
    CGPathAddLineToPoint(frontPath, nil, x, frontY);
    
    //后波浪绘制
    backY= _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + _waterLineY;
    CGPathAddLineToPoint(backPath, nil, x, backY);
    
    
    if (x>=100) {
      
      //后波浪反色绘制
      backReverseY= _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + _waterLineY;
      CGPathAddLineToPoint(backReversePath, nil, x, backReverseY);
      
      //前波浪反色绘制
      frontReverseY= _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + _waterLineY;
      CGPathAddLineToPoint(frontReversePath, nil, x, frontReverseY);
    }
  }
  
  //后波浪绘制
//  CGContextSetFillColorWithColor(context, [[UIColor orangeColor] CGColor]);
  CGContextSetStrokeColorWithColor(context, [[UIColor orangeColor] CGColor]);
  CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
  
  CGPathAddLineToPoint(backPath, nil, _waveWidth, rect.size.height);
  CGPathAddLineToPoint(backPath, nil, 0, rect.size.height);
  CGPathAddLineToPoint(backPath, nil, 0, _waterLineY);
  CGPathCloseSubpath(backPath);
  CGContextAddPath(context, backPath);
  //CGContextFillPath(context);
  CGContextStrokePath(context);
  
  //推入
  CGContextSaveGState(context);
  
  //后波浪反色绘制
  CGPathAddLineToPoint(backReversePath, nil, _waveWidth, rect.size.height);
  CGPathAddLineToPoint(backReversePath, nil, 100, rect.size.height);
  CGPathAddLineToPoint(backReversePath, nil, 100, _waterLineY);
  
  CGContextAddPath(context, backReversePath);
  CGContextClip(context);
  //    [attriButedText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attriButedText.length)];
  //    [attriButedText drawAtPoint:textPoint];
  
  
  // CGContextSaveGState(context);
  //弹出
  CGContextRestoreGState(context);
  
  //前波浪绘制
//  CGContextSetFillColorWithColor(context, [_waterColor CGColor]);
  CGContextSetStrokeColorWithColor(context, [_waterColor CGColor]);
  CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
  CGPathAddLineToPoint(frontPath, nil, _waveWidth, rect.size.height);
  CGPathAddLineToPoint(frontPath, nil, 0, rect.size.height);
  CGPathAddLineToPoint(frontPath, nil, 0, _waterLineY);
  CGPathCloseSubpath(frontPath);
  CGContextAddPath(context, frontPath);
  //CGContextFillPath(context);
  CGContextStrokePath(context);
  //推入
  CGContextSaveGState(context);
  
  
  //前波浪反色绘制
  CGPathAddLineToPoint(frontReversePath, nil, _waveWidth, rect.size.height);
  CGPathAddLineToPoint(frontReversePath, nil, 100, rect.size.height);
  CGPathAddLineToPoint(frontReversePath, nil, 100, _waterLineY);
  
  CGContextAddPath(context, frontReversePath);
  CGContextClip(context);
  //    [attriButedText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attriButedText.length)];
  //    [attriButedText drawAtPoint:textPoint];
  CGContextStrokePath(context);
  //推入
  CGContextSaveGState(context);
  
  //释放
  CGPathRelease(backPath);
  CGPathRelease(backReversePath);
  CGPathRelease(frontPath);
  CGPathRelease(frontReversePath);
}

@end
