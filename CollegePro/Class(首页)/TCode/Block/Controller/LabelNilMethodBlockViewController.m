//
//  LabelNilMethodBlockViewController.m
//  Test
//
//  Created by Rillakkuma on 2016/11/29.
//  Copyright © 2016年 Rillakkuma. All rights reserved.
//

#import "LabelNilMethodBlockViewController.h"
#import "UIColor+expanded.h"
#import <objc/message.h>

@interface LabelNilMethodBlockViewController ()
//声明成员属性
@end

@implementation LabelNilMethodBlockViewController
//+ (LabelNilMethodBlockViewController *)shareManage;
//{
//    //设置静态变量
//    static LabelNilMethodBlockViewController *s=nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (s==nil) {
//            s = [[LabelNilMethodBlockViewController alloc] init];
//        }
//    });
//    return s;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
	UIButton *pushNillButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[pushNillButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[pushNillButton setFrame:CGRectMake(10.0 ,80.0 ,120.0 ,20.0)];
	pushNillButton.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.00];       //背景颜
	[pushNillButton setTitle:@"回去" forState:(UIControlStateNormal)];
	[pushNillButton addTarget:self action:@selector(backBlockNilMetnod) forControlEvents:(UIControlEventTouchUpInside)];
	[self.view addSubview:pushNillButton];
	
    //    __weak typeof(self) _weakSelf = self;
    void(^DicBlock)(NSDictionary *dicdic) = ^(NSDictionary * inforDic){
        NSLog(@"dic %@",inforDic);
    };
    ((void(*)(id,SEL,id))objc_msgSend)(NSClassFromString(@"Persion"), NSSelectorFromString(@"numberInforDic:"), DicBlock);
    //上面这代码等同于下面
    id tempItem = [NSClassFromString(@"ExternModel") alloc];
    id item = ((id(*)(id,SEL,NSDictionary *))objc_msgSend)(tempItem, NSSelectorFromString(@"initWithProperty:"),@{@"kay":@"value"});
    NSLog(@"item %@",item);
    //随机生成一个名字
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    NSString    *uuidString = ( NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    NSLog(@"后台uuidString:%@",uuidString);
	// Do any additional setup after loading the view.
    //函数式编程
    //把Block当做函数的参数，可以把我们的逻辑和函数放在调用时候的block里面，而不是方法内部。这样会让我们在写代码的时候，把相关的逻辑都放在一起，提高了开发效率和程序的可读性。这其实就是函数式编程思想。函数式编程在很多第三方框架中都有明显的体现，比如说我们频繁使用的AFNetWorking、Masonry
    [self eatWith:^(NSDictionary *dic) {
        NSLog(@"dic %@",dic);
    }];
    
    void(^block)(int i) = self.run;
    block(1);
    //上面这两行代码可以合并为下面这一行
    self.run(10);//有没有发现这个调用和block作为属性时是一样的，下面会继续分析
    
    //链式调用
    self.travel(@"重庆").travel(@"北京");

    
    int (^myBlock)(void);
    int x;
    x = 10;
    myBlock = ^(void)
    {
        return x;
    };
    logBlock(myBlock);
    
    NSLog(@"--筛选数字：%@--",[self findNumFromStr:@"adsfadfe213234阿斯蒂芬"]);
    
}
void logBlock(int(^theBlock)(void))
{
    NSLog( @"Closure var X: %i", theBlock() );
}
- (void)getStr{
    NSLog(@"调用到的");
}
-(void)setReception:(receiveNoti)reception{
    NSLog(@"reception %@",reception);
//    if (reception) {
////        self.reception(@"reception");
//        NSLog(@"reception %@",reception);
//    }

}
- (void)backBlockNilMetnod{
	
	self.myReturnTextBlock(@"backBlockNilMetnodshu");
    [self closeCurruntPage];

}
+(void)numberInfor:(void (^)(NSString *))inforBlock{
    if (inforBlock) {
        inforBlock(@"中文");
    }
}
+(BOOL)isWhiteSkinColor{
    //白色皮肤颜色
    UIColor * whiteColor = [UIColor colorWithString:@"fbfcf9"];
    if (whiteColor)
    {
        return YES;
    }
    return NO;
}
// 防止多次调用
- (void)getShouldPrevent:(int)seconds{
    static BOOL shouldPrevent;
    if (shouldPrevent) return;
    shouldPrevent = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((seconds) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        shouldPrevent = NO;
    });
}
//block作为方法参数
- (void)eatWith:(void (^)(NSDictionary *dic))block {
    block(@{@"name":@"234"});
}
//block作为方法的返回值
- (void (^)(int i))run {
    return ^(int i){
        NSLog(@"我走了%d米",i);
    };
}
//后面带括号，说明方法的返回值是一个Block。
//调用方法肯定是对象才可以进行调用，说明Block的返回值是一个对象。
//点语法则说明这个方法没有参数。

//结合以上三点思考，我们可以得出一个结论，一个没有参数&有返回值&返回值是Block&Block的返回值是方法的调用者的方法，就可以实现链式调用：
- (LabelNilMethodBlockViewController *(^)(NSString *))travel {
    return ^(NSString *city){
        NSLog(@"我去了%@",city);
        return self;
    };
}
- (NSString *)findNumFromStr:(NSString *)originalString{
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    while(![scanner isAtEnd]){
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];tempStr = @"";
    }
    //    return [numberString integerValue];
    return numberString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
