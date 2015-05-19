//
//  do_PrograssBar_View.m
//  DoExt_UI
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_ProgressBar_UIView.h"

#import "doInvokeResult.h"
#import "doUIModuleHelper.h"
#import "doScriptEngineHelper.h"
#import "doIScriptEngine.h"

#import "do_UIActivityView.h"
#import "do_UIProgressView.h"

#define MAXPROGRESS 100.0f
#define STYLEHORIZOTAL @"horizontal"
#define STYLENORMAL @"normal"

@interface do_ProgressBar_UIView()

@property(nonatomic,strong)do_UIProgressView *do_progress;
@property(nonatomic,strong)do_UIActivityView *do_activity;
@property(nonatomic,assign) float do_realH;
@property(nonatomic,assign) float do_realW;
@property(nonatomic,copy) NSString *styleFalg;


@end

@implementation do_ProgressBar_UIView
#pragma mark - doIUIModuleView协议方法（必须）
//引用Model对象
- (void) LoadView: (doUIModule *) _doUIModule
{
    _model = (typeof(_model)) _doUIModule;
    UIView *subView = [self InitView];
    [self addSubview:subView];
}

- (UIView *)InitView
{
    UIView *prograssBarView;
    self.do_realH = _model.RealHeight;
    self.do_realW = _model.RealWidth;
    CGFloat realW = _model.RealWidth;
    CGFloat realH =  _model.RealHeight;
    NSString *barStyle = [(doUIModule*)_model GetPropertyValue:@"style"];

    if ([barStyle isEqualToString:STYLEHORIZOTAL])
    {
        do_UIProgressView *progressView = [[do_UIProgressView alloc]init];
        self.do_progress = progressView;
        progressView.frame = CGRectMake(0,realH / 2, realW , realH);
        prograssBarView = progressView;
        self.styleFalg = barStyle;
    }
    else
    {
        do_UIActivityView *activityView = [[do_UIActivityView alloc] initWithActivityIndicatorStyle:@"large"];
        [activityView startAnimating];
        prograssBarView = activityView;
        self.do_activity = activityView;
    }
    return prograssBarView;
}
//销毁所有的全局对象
- (void) OnDispose
{
    _model = nil;
    //自定义的全局属性
}
//实现布局
- (void) OnRedraw
{
    //实现布局相关的修改
    //重新调整视图的x,y,w,h
    [doUIModuleHelper OnRedraw:_model];
    CGRect frame ;
    if(self.do_progress)
    {
        frame = CGRectMake(0,  _model.RealHeight / 2, _model.RealWidth, _model.RealHeight);
        self.do_progress.frame = frame;
    }
    else if (self.do_activity)
    {
        self.do_activity.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
}

#pragma mark - TYPEID_IView协议方法（必须）
#pragma mark - Changed_属性
/*
 如果在Model及父类中注册过 "属性"，可用这种方法获取
 NSString *属性名 = [(doUIModule *)_model GetPropertyValue:@"属性名"];
 
 获取属性最初的默认值
 NSString *属性名 = [(doUIModule *)_model GetProperty:@"属性名"].DefaultValue;
 */
- (void)change_progress:(NSString *)newValue
{
    //自己的代码实现
    if (self.do_progress) {
        self.do_progress.progress = [newValue doubleValue] / MAXPROGRESS;
    }
    
}
- (void)change_style:(NSString *)newValue
{
    //自己的代码实现
    UIView *subView = [self.subviews lastObject];
    if ([subView isKindOfClass:[do_UIActivityView class]]) {//从do_UIActivityView变化
        if ([newValue isEqualToString:STYLEHORIZOTAL] ||[newValue isEqualToString:STYLENORMAL]) {
            [subView removeFromSuperview];
            do_UIProgressView * progressVew = [[do_UIProgressView alloc]init];
            progressVew.frame = CGRectMake(0, self.do_realH / 2, self.do_realW, self.do_realH);
            [self addSubview:progressVew];//waring
        }
        else
        {
            if ([self.styleFalg isEqualToString:newValue]) {//第一次加载从默认到activity
                self.styleFalg = nil;
                return;
            }
            do_UIActivityView *activityView = (do_UIActivityView *)subView;
            activityView.activityIndicatorViewStyle = [newValue isEqualToString:@"large"] ? UIActivityIndicatorViewStyleWhiteLarge : UIActivityIndicatorViewStyleGray;
            activityView.color = [UIColor grayColor];
            [activityView startAnimating];
        }
    }
    else if ([subView isKindOfClass:[do_UIProgressView class]]){//从do_UIProgressView变化
        if ([newValue isEqualToString:STYLEHORIZOTAL] || [newValue isEqualToString:STYLENORMAL]) {
            return ;
        }
        [subView removeFromSuperview];
        do_UIActivityView * activity = [[do_UIActivityView alloc]initWithActivityIndicatorStyle:newValue];
        activity.frame = CGRectMake(self.do_realW / 2, self.do_realH / 2, 0, 0);
        [activity startAnimating];
        [self addSubview:activity];
    }
    
}

#pragma mark - doIUIModuleView协议方法（必须）<大部分情况不需修改>
- (BOOL) OnPropertiesChanging: (NSMutableDictionary *) _changedValues
{
    //属性改变时,返回NO，将不会执行Changed方法
    return YES;
}
- (void) OnPropertiesChanged: (NSMutableDictionary*) _changedValues
{
    //_model的属性进行修改，同时调用self的对应的属性方法，修改视图
    [doUIModuleHelper HandleViewProperChanged: self :_model : _changedValues ];
}
- (BOOL) InvokeSyncMethod: (NSString *) _methodName : (NSDictionary *)_dicParas :(id<doIScriptEngine>)_scriptEngine : (doInvokeResult *) _invokeResult
{
    //同步消息
    return [doScriptEngineHelper InvokeSyncSelector:self : _methodName :_dicParas :_scriptEngine :_invokeResult];
}
- (BOOL) InvokeAsyncMethod: (NSString *) _methodName : (NSDictionary *) _dicParas :(id<doIScriptEngine>) _scriptEngine : (NSString *) _callbackFuncName
{
    //异步消息
    return [doScriptEngineHelper InvokeASyncSelector:self : _methodName :_dicParas :_scriptEngine: _callbackFuncName];
}
- (doUIModule *) GetModel
{
    //获取model对象
    return _model;
}

@end
