//
//  do_PrograssBar_Model.m
//  DoExt_UI
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_ProgressBar_UIModel.h"
#import "doProperty.h"

@implementation do_ProgressBar_UIModel

#pragma mark - 注册属性（--属性定义--）
-(void)OnInit
{
    [super OnInit];    
    //属性声明
	[self RegistProperty:[[doProperty alloc]init:@"progress" :Number :@"" :NO]];
	[self RegistProperty:[[doProperty alloc]init:@"style" :String :@"normal" :NO]];

}

@end