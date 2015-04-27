//
//  DateFormatterHelp.m
//  Pods
//
//  Created by zhuayi on 15/4/27.
//
//

#import "DateFormatterHelp.h"

static DateFormatterHelp *sharedCLDelegate = nil;

@implementation DateFormatterHelp

+ (DateFormatterHelp *)sharedInstance {
    @synchronized(self) {
        if(sharedCLDelegate == nil) {
            sharedCLDelegate = [[self alloc] init]; //   assignment   not   done   here
            [sharedCLDelegate setDateFormat:@"yyyy-MM-dd"];
        }
    }
    return sharedCLDelegate;
}


@end
