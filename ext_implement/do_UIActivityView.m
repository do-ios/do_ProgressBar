//
//  do_UIActivityView.m
//  DoExt_UI
//
//  Created by yz on 15/4/14.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_UIActivityView.h"
//#import "do_PrograssBar.h"

@interface do_UIActivityView()

@end

@implementation do_UIActivityView 

-(instancetype)initWithActivityIndicatorStyle:(NSString *)style
{
    if (self = [super initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]) {
        if ([style isEqualToString:@"large"]) {
            self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        }
        self.color = [UIColor grayColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
