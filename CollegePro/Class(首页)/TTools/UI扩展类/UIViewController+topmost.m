//
//  UIViewController+topmost.m
//  JHUniversalApp
//
//  Created by  William Sterling on 15/8/3.
//  Copyright (c) 2015年  William Sterling. All rights reserved.
//


#import "UIViewController+topmost.h"

@implementation UIViewController (topmost)

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

+ (id)getRootController
{
    UIWindow * wdw = [UIApplication sharedApplication].keyWindow;
    id rootVc = wdw.rootViewController;
    if ([rootVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController * naviVC = (UINavigationController *)rootVc;
        return [naviVC topViewController];
    }else{
        return rootVc;
    }
}

+ (void)backToHostController:(UIView *)view
{
    
    UIViewController * viewcontroller = [self getPresentedViewController];
    if (!viewcontroller.navigationController.parentViewController) {
        [viewcontroller dismissViewControllerAnimated:NO completion:^{
            UIResponder *responder = view;
            NSMutableArray *arrayViewController = [[NSMutableArray alloc] init];
            UIViewController * vc;
            while ((responder = [responder nextResponder]))
            {
                if ([responder isKindOfClass: [UIViewController class]])
                {
                    vc = (UIViewController *)responder;
                    [arrayViewController addObject:vc];
                }
            }
            
            if (arrayViewController.count > 0) {
                UIViewController * vc = arrayViewController.lastObject;
                if (vc)
                {
                    if (vc.navigationController.parentViewController) {
                        [vc.navigationController popViewControllerAnimated:NO];
                    }else{
                        [vc dismissViewControllerAnimated:NO completion:^{
                            
                        }];
                    }
                }
                
            }
            
        }];
    }else{
        UIResponder *responder = view;
        NSMutableArray *arrayViewController = [[NSMutableArray alloc] init];
        UIViewController * vc;
        while ((responder = [responder nextResponder]))
        {
            if ([responder isKindOfClass: [UIViewController class]])
            {
                vc = (UIViewController *)responder;
                if (![vc isKindOfClass:[NSClassFromString(@"TLTabbarViewController") class]]) {
                    [arrayViewController addObject:vc];
                }
                
            }
        }
        
        if (arrayViewController.count > 0) {
            UIViewController * vc = arrayViewController.lastObject;
            if (vc)
            {
                if (vc.navigationController.parentViewController) {
                    [vc.navigationController popViewControllerAnimated:NO];
                }else{
                    [vc dismissViewControllerAnimated:NO completion:^{
                        
                    }];
                }
            }
            
        }
        
    }
}


+ (void)backToHostController:(UIView *)view viewController:(UIViewController *)vc
{
    if (vc.navigationController) {
        if (vc.navigationController.parentViewController) {
            [vc.navigationController popToRootViewControllerAnimated:NO];
        }else{
            [vc.navigationController dismissViewControllerAnimated:NO completion:nil];
        }
    }else{
        [vc dismissViewControllerAnimated:NO completion:nil];
    }
    
    UIResponder *responder = view;
    NSMutableArray *arrayViewController = [[NSMutableArray alloc] init];
   
    while ((responder = [responder nextResponder]))
    {
        if ([responder isKindOfClass: [UIViewController class]])
        {
            UIViewController *topVC = (UIViewController *)responder;
            if (![topVC isKindOfClass:[NSClassFromString(@"TLTabbarViewController") class]]) {
                [arrayViewController addObject:vc];
            }
            
        }
    }
    
    if (arrayViewController.count > 0) {
        UIViewController * vc = arrayViewController.lastObject;
        if (vc)
        {
            if (vc.navigationController.parentViewController) {
                [vc.navigationController popViewControllerAnimated:NO];
            }else{
                [vc dismissViewControllerAnimated:NO completion:^{
                    
                }];
            }
        }
        
    }

}

+ (void)openUrlWithServerUrl:(NSString *)serverUrl localUrl:(NSString *)localUrl
{
//    NSDictionary * dic = @{@"type":@"customer",@"data":[NSNumber numberWithInt:0]};
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary * dataDic = @{@"DefaultLoad":@"0",@"animate":@"1",@"business":@"customer",@"className":@"JNWebViewController",@"entry":@"0",@"hascontent":@"",@"icon":@"",@"iconURL":@"",@"iconURLs":@"",@"id":@"",@"msgtype":@"",@"name":@"",@"package":@"",@"parentflag":@"",@"parentid":@"",@"reserved":jsonString,@"url":serverUrl,@"localUrl":localUrl};
//    id tempItem = [NSClassFromString(@"JHMenuItem") alloc];
//    id item = ((id(*)(id,SEL,NSDictionary *))objc_msgSend)(tempItem, NSSelectorFromString(@"initWithProperty:"),dataDic);
//    id clazz = [[NSClassFromString(@"JNWebViewController") alloc] init];
//    ((void(*)(id,SEL,id))objc_msgSend)(clazz, NSSelectorFromString(@"setMenuItem:"),item);
//    ((void(*)(id,SEL))objc_msgSend)(clazz, NSSelectorFromString(@"shouldMoveToSuperController"));
}


@end
