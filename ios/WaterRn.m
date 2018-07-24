

#import "WaterRn.h"
#import <React/RCTLog.h>
#import "WaterView.h"

@implementation WaterRn
RCT_EXPORT_MODULE();

- (UIView *)view {
  return [[WaterView alloc] init];
}

RCT_EXPORT_METHOD(share:successCallback:(RCTResponseSenderBlock*)successCallback errorCallback:(RCTResponseSenderBlock*)errorCallback )
{
    // return [[WaterView alloc] initWithFrame:CGRectZero];
}

@end
