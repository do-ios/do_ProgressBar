//
//  do_PrograssBar_UI.h
//  DoExt_UI
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol do_ProgressBar_IView <NSObject>

@required
//属性方法
- (void)change_progress:(NSString *)newValue;
- (void)change_style:(NSString *)newValue;

//同步或异步方法


@end