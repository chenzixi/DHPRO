//
//  LabelMethodBlockSubVC.m
//  Test
//
//  Created by Rillakkuma on 2016/11/29.
//  Copyright © 2016年 Rillakkuma. All rights reserved.
//

#import "LabelMethodBlockSubVC.h"

#import "Persion.h"
#import "KYDog.h"
#import "SFTextView.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

@interface LabelMethodBlockSubVC ()<UIScrollViewDelegate>
{
    int numC;//全局变量
    NSMutableArray *arrlist;
    UILabel *label;
    NSTimer *timer;
    
}
// 属性声明的block都是全局的__NSGlobalBlock__
@property (nonatomic, copy) void (^copyBlock)(void);
@property (nonatomic, weak) void (^weakBlock)(void);
@property(nonatomic, strong)SFTextView *textF;

@property (nonatomic, strong) KYUser *user;

@property(nonatomic,strong)Persion* p;
//测试字符串⬇️⬇️⬇️
@property(nonatomic,copy)NSString*str1;
@property(nonatomic,strong)NSString*str2;
//测试字符串⬆️⬆️⬆️
@property (nonatomic ,strong) UIButton *_btn;

@property (nonatomic,assign) float tmp;
@end

@implementation LabelMethodBlockSubVC

/*
 1. + (id)alloc 分配内存；
 
 2. - (id)init 方法（包括其他-(id)init...方法），只允许调用一次，并且要与 alloc方法 写在一起，在init方法中申请的内存，要在dealloc方法中释放（或者其他地方）；
 
 3. - (void)awakeFromNib 使用Xib初始化后会调用此方法，一般不会重写此方法；
 
 4. - (void)loadView 如果使用Xib创建ViewController，就不要重写该方法。一般不会修改此方法；
 
 5. - (void)viewDidLoad 视图加载完成之后被调用，这个方法很重要，可以在此增加一些自己定义的控件，注意此时view的frame不一定是显示时候的frame，真实的frame会在 - (void)viewDidAppear: 后。
 在iOS6.0+版本中在对象的整个生命周期中只会被调用一次，
 这里要注意在iOS3.0~iOS5.X版本中可能会被重复调用，当ViewController收到内存警告后，会释放View，并调用viewDidUnload，之后会重新调用viewDidLoad，所以要支持iOS6.0以前版本的童鞋要注意这里的内存管理。
 6. - (void)viewWillAppear:(BOOL)animated view 将要显示的时候，可以在此加载一些图片，和一些其他占内存的资源；
 7. - (void)viewDidAppear:(BOOL)animated view 已经显示的时候；
 8. - (void)viewWillDisappear:(BOOL)animated view 将要隐藏的时候，可以在此将一些占用内存比较大的资源先释放掉，在 viewWillAppear: 中重新加载。如：图片/声音/视频。如果View已经隐藏而又在内存中保留这些在显示前不会被调用的资源，那么App闪退的几率会增加，尤其是ViewController比较多的时候；
 
 9. - (void)viewDidAppear:(BOOL)animated view 已经隐藏的时候；
 
 10. - (void)dealloc，不要手动调用此方法，当引用计数值为0的时候，系统会自动调用此方法。
 二、使用 NavigationController 去 Push 切换显示的View的时候，调用的顺序：
 
 例如 从 A 控制器 Push 显示 B 控制器，
 
 [(A *)self.navigationController pushViewController:B animated:YES]
 
 1. 加载B控制器的View（如果没有的话）；
 
 2. 调用 A 的 - (void)viewWillDisappear:(BOOL)animated；
 
 3. 调用 B 的 - (void)viewWillAppear:(BOOL)animated；
 
 4. 调用 A 的 - (void)viewDidDisappear:(BOOL)animated；
 
 5. 调用 B 的 - (void)viewDidAppear:(BOOL)animated；
 
 总结来说，ViewController 的切换是先调用 隐藏的方法，再调用显示的方法；先调用Will，再调用Did。
 

 三、重新布局View的子View
 
 - (void)viewWillLayoutSubviews
 
 - (void)viewDidLayoutSubviews
 */

- (void)loadViewIfNeeded{//1
    [super loadViewIfNeeded];
}
- (void)loadView{
    [super loadView];//2
}

//将要显示的时候
-(void)viewWillAppear:(BOOL)animated{//4
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}
-(void)viewLayoutMarginsDidChange{//directionalLayoutMargins
    [super viewLayoutMarginsDidChange];//5
    //    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.view.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft)
    //    {
    //        // Right to left 语言下每行尾部在左边
    //        self.view.layoutMargins.left == 30.0;
    //    }
    //    else
    //    {
    //        self.view.layoutMargins.right == 30.0;
    //    }
    self.view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(0, 0, 0, 30);
}
-(void)viewWillLayoutSubviews{////将要布局子视图
    [super viewWillLayoutSubviews];//6
}
-(void)viewDidLayoutSubviews{//已经布局子视图
    [super viewDidLayoutSubviews];//7
//    [btn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//
//        // 初始宽、高为100，优先级最低
//        make.width.height.mas_equalTo(100 * self.scacle).priorityLow();
//        // 最大放大到整个view
//        make.width.height.lessThanOrEqualTo(self.view);
//    }];
}
//已经显示的时候  真实的frame会在这之后调用
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];//8
    [self baseBlock];

    //    [UIView animateWithDuration:100.0 animations:^{
    //        ThreeViewController *three = [[ThreeViewController alloc]init];
    //        three.modalPresentationStyle = UIModalPresentationFormSheet;
    //        three.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //        [self presentViewController:three animated:YES completion:^{
    //
    //        }];
    //    }];
    if (@available(iOS 11.0, *)) {
        NSString *edgeStr = NSStringFromUIEdgeInsets(self.view.safeAreaInsets);
        NSString *layoutFrmStr = NSStringFromCGRect(self.view.safeAreaLayoutGuide.layoutFrame);
        NSLog(@"viewDidAppear safeAreaInsets = %@, layoutFrame = %@", edgeStr, layoutFrmStr);
    } else {
        // Fallback on earlier versions
    }
    
}
- (void)safeAreaInsetsDidChange
{
    //写入变更安全区域后的代码...
    NSLog(@"safeAreaInsetsDidChange ");
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(@"backBlockNilMetnod");
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {//3//将要加载视图
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"侧滑";
    
    [self testDataP];//界面显示

    if (@available(iOS 11.0, *)) {
        NSString *edgeStr = NSStringFromUIEdgeInsets(self.view.safeAreaInsets);
        NSString *layoutFrmStr = NSStringFromCGRect(self.view.safeAreaLayoutGuide.layoutFrame);
        NSLog(@"viewDidLoad safeAreaInsets = %@, layoutFrame = %@", edgeStr, layoutFrmStr);
    } else {
        // Fallback on earlier versions
    }
    
	UIButton *pushNillButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[pushNillButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[pushNillButton setFrame:CGRectMake(10.0 ,80.0 ,120.0 ,20.0)];
	pushNillButton.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.00];       //背景颜
	[pushNillButton setTitle:@"回去" forState:(UIControlStateNormal)];
	[pushNillButton addTarget:self action:@selector(backBlockNilMetnod) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:pushNillButton];

    // Do any additional setup after loading the view.
}
- (void)baseBlock{
    numC = 100;
    [self testDataA];
    [self testDataB];
    [self testDataC];
    
    self.user = [[KYUser alloc] init];
    self.user.dog = [[KYDog alloc] init];
    self.user.dog.age = 12;
    self.user.dog.name = @"大大";
    self.user.userId = @"35325";
    [self testDataD];
    [self testDataE];//Operation
    [self testDataF];//GCD
    [self testDataG];//深、浅拷贝
    [self testDataH];//交换
    [self testDataL];//排序方式
    [self testDataM];
    //    [self testDataK];
    [self testDataN];//KVO进阶
}
- (void)testDataH{
    int a = 10;
    int b = 12;
    //    a = b + 0 * ( b = a);//a=12;b=10
    //    NSLog(@"%d",a);
    
    a = b - a; //a=2;b=12
    b = b - a; //a=2;b=10
    a = a + b; //a=10;b=10
    NSLog(@"%d",a);
    //    UITableView *_tableView = [];
    //    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
//全局变量
- (void)testDataA{
    
    void (^TestNumberC)(int)=^(int x){
        numC = 1000;
        NSLog(@"C2、num的h值是 %d",numC);
        
    };
    NSLog(@"C1、num的h值是 %d",numC);
    TestNumberC(86);
    NSLog(@"C3、num的h值是 %d",numC);
    
    //    __weak typeof(self) weakSelf = self;
    //    [previewVc setDoneButtonClickBlockWithPreviewType:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    //        __strong typeof(weakSelf) strongSelf = weakSelf;
    //        [strongSelf dismissViewControllerAnimated:YES completion:^{
    //            if (!strongSelf) return;
    //            if (strongSelf.didFinishPickingPhotosHandle) {
    //                strongSelf.didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
    //            }
    //        }];
    //    }]
}

//局部变量加__block
- (void)testDataB{
    __block int numA = 100;//在栈区
    void (^number)(int)=^(int x){
        numA = numA + x;
        NSLog(@"2、num的h值是 %d",numA);
        
    };//在堆区
    NSLog(@"1、num的h值是 %d",numA);
    number(2);
    NSLog(@"3、num的h值是 %d",numA);
    
}

//全局静态变量
static int numB = 100;
- (void)testDataC{
    void (^TestNumber)(int)=^(int x){
        numB = 1000;
        NSLog(@"S2、num的h值是 %d",numB);
        
    };NSLog(@"S1、num的h值是 %d",numB);
    TestNumber(86);
    NSLog(@"S3、num的h值是 %d",numB);
}

// 全局变量
int global_var = 4;
// 静态全局变量
//static int static_global_var = 5;

typedef void (^blockSave)(void);

typedef void (^typedefBlock)(void);

void (^outFuncBlock)(void) = ^{
    NSLog(@"someBlock");
};

- (void)testDataD{
    //    int multiplier = 6;
    //    int(^Block)(int) = ^int(int num)
    //    {
    //        return num * multiplier;
    //    };
    //    multiplier = 4;
    //    NSLog(@"result is %d", Block(2));
    
    int var = 1;
    __unsafe_unretained id unsafe_obj = nil;
    __strong id strong_obj = nil;
    static int static_var = 3 ;
    void(^block)(void) = ^{
        
        NSLog(@"局部变量<基本数据类型> var %d",var);
        NSLog(@"局部变量<__unsafe_unretained 对象类型> var %@",unsafe_obj);
        NSLog(@"局部变量< __strong 对象类型> var %@",strong_obj);
        NSLog(@"静态变量 %d",static_var);
        NSLog(@"全局变量 %d",global_var);
        NSLog(@"静态全局变量 %d",global_var);
    };
    NSLog(@"外部调用 %@",block);
    
//    32位无符号整数 ，  其表示范围是2的32次方，最大整数为 2的32次方-1
//    有符号数则要去除一个符号位，正数最大为2的31次方-1 , 负数最小为负  2的31次方
//
//    16位整数同理。
//
//    int  在32位系统中为  4字节，也就是32位。在一些16位系统中，int 为2字节,在64位系统中int为8字节。
    
    NSLog(@"block : %@", ^{NSLog(@"block");});      // __NSGlobalBlock__
    
    NSString *str3 = @"1234";
    NSLog(@"block is %@", ^{NSLog(@":%@", str3);});     // __NSStackBlock__
    
#pragma mark - 当全局block引用了外部变量，ARC机制优化会将Global的block,转为Malloc（堆）的block进行调用。
    __block int age = 20;
    int *ptr = &age;
    // ARC下
    blockSave x = ^{
        NSLog(@"(++age):%d", ++age);    // 变量前不加__block的情况下，会报错，变量的值只能获取，不能更改
    };
    blockSave y = [x copy];
    y();
    NSLog(@"x():%@, y():%@ , (*ptr):%d", x, y, *ptr);
    // MRC下
    Persion *test = [[Persion alloc] init];
    [test test];
//    [test exampleB];
    
    /**总结：
     ARC下：(++age):21   (*ptr):20    // blockSave在堆中，*ptr在栈中
     MRC下：(++age):21   (*ptr):21    // blockSave和*ptr都在栈中
     */
    
    
#pragma mark - copyBlock（未使用函数内变量） __NSGlobalBlock__
    
    self.copyBlock = ^{
        
    };
    NSLog(@"1：%@", self.copyBlock);
    
#pragma mark - weakBlock（未使用函数内变量） __NSGlobalBlock__
    
    self.weakBlock = ^{
        
    };
    NSLog(@"2：%@", self.weakBlock);
    
#pragma mark - copyBlock （使用函数内变量） __NSMallocBlock__
    
    self.copyBlock = ^{
        age = age+1-1;
    };
    NSLog(@"3：%@", self.copyBlock);
    
#pragma mark - weakBlock（使用函数内变量） __NSStackBlock__
    
    self.weakBlock = ^{
        age = age+1-1;
    };
    NSLog(@"4：%@", self.weakBlock);
    
#pragma mark - someBlock（定义在函数体外） __NSGlobalBlock__
    
    NSLog(@"5：%@", outFuncBlock);
    
#pragma mark - typedefBlock（函数体外自定义的Block） __NSGlobalBlock__
    
    typedefBlock b = ^{
        
    };
    NSLog(@"6：%@", b);
    
    
    
#pragma mark - 对栈中的block进行copy
    // 不引用外部变量，定义在全局区、表达式没有使用到外部变量时，生成的block都是__NSGlobalBlock__类型
    void (^testBlock1)(void) = ^(){
        
    };
    NSLog(@"testBlock1: %@", testBlock1);
    
    // 引用外部变量 -- ARC下默认对block进行了copy操作，所以这里是__NSMallocBlock__类型
    void (^testBlock2)(void) = ^(){
        age = age+1-1;
    };
    NSLog(@"testBlock2: %@", testBlock2);
    
    
    // Blocks提供了将Block和__block变量从栈上复制到堆上的方法来解决变量作用域结束时销毁的问题，堆上的Block会依然存在。
    
    
    /*那么什么时候栈上的Block会复制到堆上呢？
     1.调用Block的copy实例方法时
     2.Block作为函数返回值返回时（作为参数则不会）
     3.将Block赋值给附有__strong修饰符id类型的类或Block类型成员变量时
     4.将方法名中含有usingBlock的Cocoa框架方法或GCD的API中传递Block时
     
     在使用__block变量的Block从栈上复制到堆上时，__block变量也被从栈复制到堆上并被Block所持有。
     */
    
    
    /*block里面使用self会造成循环引用吗？
     
     1.很显然答案不都是，有些情况下是可以直接使用self的，比如调用系统的方法：
     [UIView animateWithDuration:0.5 animations:^{
     NSLog(@"%@", self);
     }];
     因为这个block存在于静态方法中，虽然block对self强引用着，但是self却不持有这个静态方法，所以完全可以在block内部使用self。
     
     2.当block不是self的属性时，self并不持有这个block，所以也不存在循环引用
     void(^block)(void) = ^() {
     NSLog(@"%@", self);
     };
     block();
     
     3.大部分GCD方法:
     dispatch_async(dispatch_get_main_queue(), ^{
     [self doSomething];
     });
     因为self并没有对GCD的block进行持有，没有形成循环引用。
     
     4.……
     
     只要我们抓住循环引用的本质，就不难理解这些东西。
     */
    
}

- (void)testDataE{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task0---%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    }];
    
    // 开始必须在添加其他操作之后
    [op start];
}

- (void)testDataF{
    /*
     通常我们会用for循环遍历，但是GCD给我们提供了快速迭代的方法dispatch_apply，使我们可以同时遍历。比如说遍历0~5这6个数字，for循环的做法是每次取出一个元素，逐个遍历。dispatch_apply可以同时遍历多个数字。
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"GCD快速迭代 //%zd------%@",index, [NSThread currentThread]);
    });
    
    
    //创建一个调度组
    dispatch_group_t group1 = dispatch_group_create();
    
    //进入调度组
    dispatch_group_enter(group1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //模拟请求耗时
        sleep(2);
        NSLog(@"A");
        //事件完成 离开调度组
        dispatch_group_leave(group1);
    });
    
    dispatch_group_enter(group1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"B");
        dispatch_group_leave(group1);
    });
    
    dispatch_group_enter(group1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"C");
        dispatch_group_leave(group1);
    });
    
    //所有任务从调度组里面拿出来 调用通知
    dispatch_group_notify(group1, dispatch_get_main_queue(), ^{
        NSLog(@"完成");
    });
    
    
    
    //调度组
    dispatch_group_t group = dispatch_group_create();
    
    /*
     参数1:调度组
     参数2:队列
     参数3:任务
     */
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"下载第1首歌曲");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"下载第2首歌曲");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"下载第3首歌曲");
    });
    //通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"歌曲下载完成");
    });
    
    
    
    
    //创建一个串行队列  通过串行队列进行线程依赖
    dispatch_queue_t serial_queue = dispatch_queue_create("cn.jimmypeng", DISPATCH_QUEUE_SERIAL);
    
    //异步把任务 放入 串行队列
    dispatch_async(serial_queue, ^{
        NSLog(@"A开始 %@",[NSThread currentThread]);
        //模拟请求耗时
        sleep(1);
        NSLog(@"A完成 %@",[NSThread currentThread]);
    });
    
    dispatch_async(serial_queue, ^{
        NSLog(@"B开始 %@",[NSThread currentThread]);
        sleep(1);
        NSLog(@"B完成 %@",[NSThread currentThread]);
    });
    
    dispatch_async(serial_queue, ^{
        NSLog(@"C开始 %@",[NSThread currentThread]);
        sleep(1);
        NSLog(@"C完成 %@",[NSThread currentThread]);
    });
    
    NSLog(@"完成");
    
    
    NSArray*moviesArray = [NSArray arrayWithObjects:
                           @"第1集", @"第2集",@"第3集",@"第4集",@"第5集",
                           @"第6集",@"第7集",@"第8集",@"第9集",@"第10集",
                           @"第11集", @"第12集",@"第13集",@"第14集",@"第15集",
                           @"第16集",@"第17集",@"第18集",@"第19集",@"第20集",
                           nil];
    
    dispatch_queue_t queueMovies = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphoreMovies = dispatch_semaphore_create(5);//创建信号量
    
    for (int i = 0 ; i<moviesArray.count; i++) {
        dispatch_semaphore_wait(semaphoreMovies, DISPATCH_TIME_FOREVER);//等待信号量 有闲置的信号量就让新的任务进来，如果没有就按照顺序等待闲置的信号量 可以设置等待时间
        dispatch_async(queueMovies, ^{
            //模拟下载任务
            NSLog(@"%@开始下载",moviesArray[i]);
            sleep(10+i*2);//假设下载一集需要10+i*2秒
            NSLog(@"%@下载完成",moviesArray[i]);
            
            dispatch_semaphore_signal(semaphoreMovies);//发送信号量 发送完成进度
        });
    }
    dispatch_queue_t queueshili = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphoreshili = dispatch_semaphore_create(5);
    
    for (int i = 0 ; i<20; i++) {
        dispatch_semaphore_wait(semaphoreshili, DISPATCH_TIME_FOREVER);
        dispatch_async(queueshili, ^{
            NSLog(@"任务%d开始",i);
            sleep(i);
            NSLog(@"任务%d结束",i);
            
            dispatch_semaphore_signal(semaphoreshili);
        });
    }
    
    /**
     栅栏函数
     <一>什么是dispatch_barrier_async函数
     毫无疑问,dispatch_barrier_async函数的作用与barrier的意思相同,在进程管理中起到一个栅栏的作用,它等待所有位于barrier函数之前的操作执行完毕后执行,并且在barrier函数执行之后,barrier函数之后的操作才会得到执行,该函数需要同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
     
     <二>dispatch_barrier_async函数的作用
     
     1.实现高效率的数据库访问和文件访问
     
     2.避免数据竞争
     */
    //同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
    dispatch_queue_t queuezhalan = dispatch_queue_create("zhalanqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queuezhalan, ^{
        NSLog(@"栅栏函数----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queuezhalan, ^{
        NSLog(@"栅栏函数----2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queuezhalan, ^{
        NSLog(@"栅栏函数----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queuezhalan, ^{
        NSLog(@"栅栏函数----4-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queuezhalan, ^{
        NSLog(@"栅栏函数----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queuezhalan, ^{
        NSLog(@"栅栏函数----5-----%@", [NSThread currentThread]);
    });
    dispatch_async(queuezhalan, ^{
        NSLog(@"栅栏函数----6-----%@", [NSThread currentThread]);
    });
    
}

-(void)testDataG{
    //对于不可变字符串来说 srong和copy 指向的地址都是一样的
    //对于可变字符串来说 copy的地址已不在指向原有的地址了，深拷贝了testStr字符串，并让copyStr对象指向这个字符串，反之strong是同一地址
    //当原字符串是NSString时，不管是strong还是copy属性的对象，都是指向原对象，copy操作只是做了次浅拷贝
    //当原字符串是NSMutableString时,copy操作只是做了次深拷贝，产生了一个新对象且copy的对象指向了这个新对象，这个copy属性对象类型始终是不可变的，所以是不可变得；
    NSMutableString*str=[NSMutableString stringWithFormat:@"helloworld"];
    //    NSString*str=[NSString stringWithFormat:@"helloworld"];
    
    self.str1=str;//copy
    
    self.str2=str;//strong
    
    //    [str appendString:@"hry"];
    
    NSLog(@"****************%@",self.str1);
    
    NSLog(@"****************%@",self.str2);
    
    NSLog(@"str:%p--%p",str,&str);
    
    NSLog(@"copy_str:%p--%p",_str1,&_str1);
    
    NSLog(@"strong_str:%p--%p",_str2,&_str2);
    
}

- (void)testDataL{
    //    NSMutableArray *arr = [@[@"24", @"17", @"85", @"13", @"9", @"54", @"76", @"45", @"5", @"63"]mutableCopy];
    //    for (int i = 0; i<arr.count-1; i++) {
    //        for (int j = 0; (j < arr.count-1-i); j++) {
    //            if ([arr[j] intValue]<[arr[j+1] intValue]){
    //                int tmp = [arr[j] intValue];
    //                NSLog(@"----<<>>%d",tmp);
    ////                arr[j] = arr[j+1];
    ////                arr[j+1] = tmp;
    //            }
    //        }
    //    }
    //冒泡排序
    //    int array[10] = {24, 17, 85, 13, 9, 54, 76, 45, 5, 63};
    //    int numcount = sizeof(array)/sizeof(int);
    //    for (int i = 0; i<numcount; i++) {
    //        NSLog(@"-第一层读数-%d",array[i]);
    //        for (int j = 0; j<numcount-i; j++) {
    //            NSLog(@"-第二层读数-%d",array[j]);
    //            //如果一个元素比另一个元素大，交换这两个元素的位置
    //            if (array[j]<array[j+1]) {
    //                int tmp = array[j];
    //                array[j]=array[j+1];
    //                array[j+1] = tmp;
    //            }
    //        }
    //
    //    }
    //    for(int i = 0; i < numcount; i++) {
    //        printf("最终结果--%d\t", array[i]);
    //    }
    //冒泡排序
    NSMutableArray *arrNum = [NSMutableArray arrayWithObjects:@"10",@"23",@"34",@"12",@"2",@"16", nil];
    for (int i = 0; i<arrNum.count; i++) {
        NSLog(@"外层冒泡排序循环：%@",arrNum[i]);
        for (int j = 0; j<arrNum.count-1-i; j++) {
            NSLog(@"内层冒泡排序循环：%@-%@-%lu",arrNum[j],arrNum[j+1],arrNum.count-1-i);
            if ([arrNum[j]intValue]<[arrNum[j+1]intValue]) {
                NSLog(@"冒泡排序判断：%@-%@-%@",arrNum[i],arrNum[j],arrNum[j+1]);
                int tmp = [arrNum[j]intValue];
                arrNum[j] = arrNum[j+1];
                arrNum[j+1] = [NSNumber numberWithInt:tmp];
                NSLog(@"冒泡排序判断：%@-%@-%@",arrNum[i],arrNum[j],arrNum[j+1]);
            }
        }
    }
    
    //    //选择排序 先设arr[1]为最小，逐一比较，若遇到比之小的则交换,
    //    for (int i = 0;i<arrNum.count; i++) {
    //        NSLog(@"i 选择排序：%@",arrNum[i]);
    //        for (int j = i+1;j<arrNum.count; j++) {
    //            NSLog(@"选择排序：%@",arrNum[j]);
    //            if ([arrNum[i]intValue] > [arrNum[j]intValue]) {// 将上一步找到的最小元素和第i位元素交换。
    //                NSLog(@"选择排序：%@--%@",arrNum[i],arrNum[j]);
    //                int tmp = [arrNum[i]intValue];
    //                arrNum[i] = arrNum[j];//exchange
    //                arrNum[j] = [NSNumber numberWithInt:tmp];
    //                NSLog(@"选择排序：%@--%@",arrNum[i],arrNum[j]);
    //            }
    //
    //        }
    //    }
    
    for(int i = 0; i < arrNum.count; i++) {
        printf("最终结果--%d\t", [arrNum[i]intValue]);
    }
}
- (void)testDataM
{
    //冒泡排序
    //    1, 最差时间复杂度 O(n^2)
    //    2, 平均时间复杂度 O(n^2)
    //    NSMutableArray *mutableArray = [@[@"12",@"45",@"1",@"5",@"18",@"35",@"7"]mutableCopy];
    //    for (int i = 0; i < mutableArray.count-1; i++) {
    //
    //        for (int j = 0; j < mutableArray.count-1-i; j++) {
    //
    //            if ([mutableArray[j] integerValue] > [mutableArray[j+1] integerValue]) {
    //                NSString *temp = mutableArray[j];
    //                mutableArray[j] = mutableArray[j+1];
    //                mutableArray[j+1] = temp;
    //            }
    //        }
    //    }
    //
    //    NSLog(@"冒泡排序结果：%@",mutableArray);
    
    NSMutableArray *numarrar = [@[@"4",@"2",@"7",@"12",@"9",@"1"]mutableCopy];
    //    for (int i = 0; i<numarrar.count-1; i++) {
    ////        NSLog(@"输出的数据 %@",numarrar[i]);
    //        for (int j = 0; j<numarrar.count-1-i;j++){
    ////            NSLog(@"输出的数据 %@",numarrar[j]);
    //            NSLog(@"输出的数据 %@-%@",numarrar[j],numarrar[j+1]);
    //            if ([numarrar[j] integerValue]>[numarrar[j+1] integerValue]) {
    //                NSLog(@"输出的数据 %@",numarrar[j]);
    //                NSString *tem = numarrar[j];
    //                numarrar[j]  = numarrar[j+1];
    //                numarrar[j+1]  = tem;
    //            }
    //        }
    //    }
    //选择排序
    //    平均时间复杂度：O(n^2)
    //    平均空间复杂度：O(1)
    //    struct utsname systemInfo;
    //    uname(&systemInfo);
    //    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //    NSLog(@"deviceString: %@",deviceString);
    //4 2 7 12 9 1
    for (int i = 0; i<numarrar.count-1; i++) {
        int index = i;//0
        for (int j= i+1; j<numarrar.count; j++) {//2 7 12 9 1;        2 4 7 12 9 1  j=2
            if ([numarrar[index]integerValue]>[numarrar[j]integerValue]) {//numarrar[index]=4，numarrar[j]=2  7
                index = j;//index = j = 1;
            }
            if (index != i) {//1 != 0;
                NSString *temp = numarrar[i];//temp = 4
                numarrar[i] = numarrar[index];//numarrar[i] = numarrar[index]=2
                numarrar[index] = temp;// numarrar[index] = 4
            }//2 4 7 12 9 1;4 2 7 12 9 1
            NSLog(@"选择排序结果：%@",numarrar);
        }
    }
    
    
    NSInteger num1 = 10,num2 = 30;
    
    NSInteger gcd = [self gcdWithNumber1:num1 Number2:num2];
    // 最小公倍数 = 两整数的乘积 ÷ 最大公约数
    NSLog(@"---%ld",num1 * num2 / gcd);
    int a = 1;
    int b = a++;
    int c = ++a;
    NSLog(@"---%d--%d--%d",a ,b ,c);

    
//    __block UIImage *image;
//    dispatch_sync_on_main_queue(^{
//        image = [UIImage imageNamed:@"Resource/img"];
//    });
    testPathForKey(@"123",@"789");
        //定义显示图片的
        NSArray *imageNameList = @[@"scanscanBg.png",@"scanscanBg.png",@"scanscanBg.png",@"scanscanBg.png"];
        UIScrollView *scrollViewRoot = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 300, DH_DeviceWidth, self.view.frame.size.height-350)];
        scrollViewRoot.delegate = self;
        scrollViewRoot.backgroundColor = [UIColor redColor];
        [self.view addSubview:scrollViewRoot];
        
        // 添加图片
        for (NSInteger index = 0; index < imageNameList.count; index ++) {
            // UIScrollView上的每一张图片
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index * DH_DeviceWidth, 0, scrollViewRoot.frame.size.width, scrollViewRoot.frame.size.height)];
            //加载图片方式一:一直在占用内存，并未释放，且自动识别@2x，@3x等不同分辨率的图片，会提供一个缓存，具体是在加载的时候缓存到系统内存，使用的时候从缓存中进行加载，但是过多的话会导致内存泄露等内存警告问题，imageNamed后面跟的不是图片名称，是图片集合的名称，所以关于image@2x，image@3x等，只需要写上前面的image，他们属于一个image下的图片集合，内部会根据屏幕分辨率自动识别，并进行展示
            imageView.image = [UIImage imageNamed:imageNameList[index]];
            //加载图片方式二:数据形式加载，不会一直加载在内存里，也就是说没有做图片缓存处理，且自动识别@2x，@3x等不同分辨率的图片
            imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameList[index] ofType:nil]];
            //NSString *filePaht1 = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"test.bundle/hotBagImage.png"];
            
            //加载图片方式三:数据形式加载，不会一直加载在内存里
            NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameList[index] ofType:nil]];
            imageView.image = [UIImage imageWithData:imageData];
            /*
             Assets.xcassets 在使用大量图片时，不推荐这种方式，我们的一些小的icon或者图片可以放置进来，我们的启动图等在这里面管理还是比较方便；
             NSBundle或者ContentsOfFile方式虽然加载图片不占用内存资源，起到了性能优化，但是占的APP储存空间相对比较大，会增加包的体积。其中ContentsOfFile不同于NSBundle的是可以创建文件夹来管理图片，但是这样在多人开发中容易丢失图片文件。
             */
            [scrollViewRoot addSubview:imageView];
            //contentSize 为什么不从0开始，因为0*kScreenWidth等于0，就相当于没有大小，挤掉了第一张(备注：因为图片资源是从0开始的，在这里乘以0就相当于把第一张的大小变为0)
            scrollViewRoot.contentSize = CGSizeMake((index+1) * DH_DeviceWidth, 0);
        
        
    }
    //    void (^num)(int)=^(int x){
    //        NSLog(@"1、执行");
    //        dispatch_sync(dispatch_get_main_queue(), ^{//有可能引入死锁的问题
    //            NSLog(@"2、执行");
    //        });
    //        NSLog(@"3、执行");
    //    };
    //    num(1);
    
    UIView *orangeView = [[UIView alloc] init];
    
    orangeView.frame = CGRectMake(0, 0, 200,200);
    
    orangeView.backgroundColor = [UIColor orangeColor];
    
    orangeView.center = self.view.center;
    
    [self.view addSubview:orangeView];
    
    
    UIView *blueView = [[UIView alloc] init];
    
    blueView.frame = CGRectMake(0, 0, 150,150);
    
    blueView.backgroundColor = [UIColor blueColor];
    
    //    blueView.layer.anchorPoint = CGPointMake(0.0, 1.0);
    //
    //    blueView.center = self.view.center;
    
    [self.view addSubview:blueView];
    /**
     - (void)updateConstraintsIfNeeded  调用此方法，如果有标记为需要重新布局的约束，则立即进行重新布局，内部会调用updateConstraints方法
     - (void)updateConstraints          重写此方法，内部实现自定义布局过程
     - (BOOL)needsUpdateConstraints     当前是否需要重新布局，内部会判断当前有没有被标记的约束
     - (void)setNeedsUpdateConstraints  标记需要进行重新布局
     */
    //and,with,这两个方法内部实际上什么都没干，只是在内部将self直接返回，功能就是为了更加方便阅读，对代码执行没有实际作用

    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.view).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(300, 300));
        
    }];
    // 下面的方法和上面例子等价，区别在于使用insets()方法。
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(blueView.bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(300, 300));
        // 下、右不需要写负号，insets方法中已经为我们做了取反的操作了
        make.edges.equalTo(blueView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    NSLog(@"orangeView center = %@",NSStringFromCGPoint(orangeView.center));
    
    NSLog(@"blueView center = %@",NSStringFromCGPoint(blueView.center));
    
    NSLog(@"orangeView bounds = %@",NSStringFromCGRect(orangeView.bounds));
    
    NSLog(@"blueView bounds = %@",NSStringFromCGRect(blueView.bounds));
    
}
static inline NSString* testPathForKey(NSString* directory, NSString* key) {
    //  stringByAppendingString 字符串拼接
    //    stringByAppendingPathComponent 路径拼接
    return [directory stringByAppendingString:key];
}
//YYKit中提供了一个同步扔任务到主线程的安全方法：
//static inline void dispatch_sync_on_main_queue(void (^block)(void)) {
//    NSLog(@"1、执行");
//    //    if (pthread_main_np()) {
//    //        block();
//    //    } else {
//    //        dispatch_sync(dispatch_get_main_queue(), block);
//    //    }
//    //    dispatch_sync(dispatch_get_main_queue(), ^{
//    //        NSLog(@"2、执行");
//    //    });
//    //    NSLog(@"3、执行");
//};

static UILabel *myLabel;
- (void)testDataN{
    
    /**KVO 高级用法
     doubleValue.intValue double转Int类型
     uppercaseString 小写变大写
     length 求各个元素的长度
     数学元素 @sum.self  @avg.self @max.self @min.self  @distinctUnionOfObjects.self(过滤)
     
     >>KVC setter方法
     通过setValue:forKeyPath:设置UI控件的属性：
     
     [self.label setValue:[UIColor greenColor] forKeyPath:@"textColor"];
     [self.button setValue:[UIColor orangeColor] forKeyPath:@"backgroundColor"];
     [self.textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
     
     */
    
    NSDictionary *dataSource = @[@{@"name":@"mike", @"sex":@"man", @"age":@"12"},
                                 @{@"name":@"jine", @"sex":@"women", @"age":@"10"},
                                 @{@"name":@"marry", @"sex":@"women", @"age":@"12"},
                                 @{@"name":@"mike", @"sex":@"man", @"age":@"11"},
                                 @{@"name":@"selly", @"sex":@"women", @"age":@"12"}];
    //KVC keyPath的getter方法：
    NSLog(@"name = %@",[dataSource valueForKeyPath:@"name"]);
    NSArray *array1 = @[@"apple",@"banana",@"pineapple",@"orange"];
    NSLog(@"%@",[array1 valueForKeyPath:@"uppercaseString"]);
    
    NSLog(@"filterName = %@",[dataSource valueForKeyPath:@"@distinctUnionOfObjects.sex"]);
    
    
    // 1、添加KVO监听
    //NSKeyValueObservingOptionInitial 观察最初的值 在注册观察服务时会调用一次
    //NSKeyValueObservingOptionPrior 分别在被观察值的前后触发一次 一次修改两次触发
    [self.user addObserver:self forKeyPath:@"dog.name" options:NSKeyValueObservingOptionNew context:nil];
    
    myLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 100, 30 )];
    myLabel.textColor = [UIColor redColor];
    myLabel.text = self.user.dog.name;
    //    myLabel.text = [self.user.dog valueForKeyPath:@"name"];
    [self.view addSubview:myLabel];
    
}
////  3秒钟后改变当前button的enabled状态
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    self.button.enabled = YES;
//});

// 返回一个容器，里面放字符串类型，监听容器中的属性
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"dog"]) {
        NSArray *arr = @[@"_dog.name", @"_dog.age"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:arr];
    }
    return keyPaths;
}

// 2、接收监听
/**
 KVO 必须实现
 
 @param keyPath 被观察的属性
 @param object 被观察对象
 @param change 添加监听时传过来的上下文信息
 @param context 字典，keys有以下五种：
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"--------------%@",change);
    NSLog(@"%@", keyPath);
    NSLog(@"%@", object);
    /*
     NSKeyValueChangeNewKey;新值
     NSKeyValueChangeOldKey;旧值
     NSKeyValueChangeIndexesKey;观察容器属性时会返回的索引值
     NSKeyValueChangeKindKey;
     
     NSKeyValueChangeSetting = 1 赋值 SET
     NSKeyValueChangeInsertion = 2 插入 insert
     NSKeyValueChangeRemoval = 3 移除 remove
     NSKeyValueChangeReplacement = 4 替换 replace
     
     */
    //    NSKeyValueChangeNotificationIsPriorKey
    NSLog(@"%@", change[NSKeyValueChangeNewKey]);
    NSLog(@"%@", (__bridge id)(context));
    myLabel.text = [self.user.dog valueForKeyPath:@"name"];
    
    //else   若当前类无法捕捉到这个KVO，那很有可能是在他的superClass，或者super-superClass...中
    //    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
}
// 3、触发修改属性值
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.user.userId = @"123456789";
    //    self.user.dog.name = @"肖";
    self.user.dog.age = 15;
    [self.user.dog setValue:@"20.0" forKey:@"name"];
    
}

-(NSString *)inputValue:(NSString *)str{
    
    NSMutableString *string=[[NSMutableString alloc] init];
    
    for(int i=0;i<str.length;i++){
        
        [string appendString:[str substringWithRange:NSMakeRange(str.length-i-1, 1)]];
        
    }
    
    return string;
    
}
- (void)testDataO{
    UIImage *image = [UIImage imageNamed:@"_MG_5586.JPG"];//8M

    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [[NSUUID UUID] UUIDString]];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93,93)];// 图片进行尺寸压缩
    
    [UIImageJPEGRepresentation(smallImage,0.3) writeToFile:imageFilePath atomically:YES];// 图片进行质量压缩
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    NSData *ImageData =UIImagePNGRepresentation(selfPhoto);
    NSLog(@"ImageData %lu",(unsigned long)ImageData.length);
}
static  UILabel *label;
- (void)testDataP
{
    NSInteger num = 3;
    label = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 200.0, self.view.frame.size.width-60.0, 16*3+8*2)];
    label.font = [UIFont systemFontOfSize:16.0];
    label.layer.borderColor = [UIColor redColor].CGColor;
    label.layer.borderWidth = 1.0;
    label.numberOfLines = num;
    [label setTag:189];
    [self.view addSubview:label];
    
    NSString *text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？转朱阁，低绮户，照无眠。不应有恨，何事长向别时圆？人有悲欢离合，月有阴晴圆缺，此事古难全。但愿人长久，千里共婵娟。";
//    NSString *text = @"明月几时有";
    label.text = text;
    NSDictionary *dictName = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *dictMore = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:[UIColor blueColor]};
    NSMutableAttributedString *attStr = [DHTool addWithName:label more:@"全文" nameDict:dictName moreDict:dictMore numberOfLines:num];
    label.attributedText = attStr;
    NSLog(@"%f--%@",[DHTool autoSizeOfHeghtWithText:label.text font:[UIFont systemFontOfSize:16.0] width:self.view.frame.size.width-60.0].height,label.text);

    label.frame = CGRectMake(30.0, 200.0, self.view.frame.size.width-60.0, 20*num);
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = label.frame;
//    [btn setTitle:@"test" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
//    [label addSubview:btn];
    
    //富文本
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 300.0, self.view.frame.size.width-60.0, 16*3+8*2)];
    label1.font = [UIFont systemFontOfSize:16.0];
    label1.layer.borderColor = [UIColor redColor].CGColor;
    label1.layer.borderWidth = 1.0;
    label1.numberOfLines = 1;
    label1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label1];
    
    NSString * string = [NSString stringWithFormat:@"您的号码是%@号",@"3"];
    label1.attributedText = [self paramWithStr:string Range:NSMakeRange(5, 1)];
    
}
/*
//发布信息textflied
-(SFTextView *)textF
{
    if (!_textF) {
        _textF = [[SFTextView alloc] init];
        _textF.font = FONT_SIZE(13);
        _textF.textColor = KColorC;
        _textF.backgroundColor = [UIColor whiteColor];
        //        _textF.backgroundColor = [UIColor clearColor];
        //        _textF.delegate = self;
        //设置placeholder属性
        [_textF setPlaceHolderAttr:@"  写下你的观点/见解" textColor:KColorD font:FONT_SIZE(13)];
        //设置字数限制属性
        [_textF setCharCountAttr:150 right:SNRealValue(11) bottom:SNRealValue(9) textColor:KColorC font:KFontSizeG];
        _textF.layer.cornerRadius = SNRealValue(5);
    }
    return _textF;
}
 */
- (NSMutableAttributedString *)paramWithStr:(NSString *)name Range:(NSRange)ran{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:name];

   /*
    常见的属性及说明
    NSFontAttributeName  字体
    NSParagraphStyleAttributeName  段落格式
    NSForegroundColorAttributeName  字体颜色
    NSBackgroundColorAttributeName   背景颜色
    NSStrikethroughStyleAttributeName 删除线格式
    NSUnderlineStyleAttributeName      下划线格式
    NSStrokeColorAttributeName        删除线颜色
    NSStrokeWidthAttributeName 删除线宽度
    NSShadowAttributeName  阴影
    
    属性及说明
    
    
    
    key
    说明
    

    NSFontAttributeName
    字体，value是UIFont对象
    
    
    NSParagraphStyleAttributeName
    绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象
    
    
    NSForegroundColorAttributeName
    文字颜色，value是UIFont对象
    
    
    NSLigatureAttributeName
    字符连体，value是NSNumber
    
    
    NSKernAttributeName
    字符间隔
    
    
    NSStrikethroughStyleAttributeName
    删除线，value是NSNumber
    
    
    NSUnderlineStyleAttributeName
    下划线，value是NSNumber
    
    
    NSStrokeColorAttributeName
    描绘边颜色，value是UIColor
    
    
    NSStrokeWidthAttributeName
    描边宽度，value是NSNumber
    
    
    NSShadowAttributeName
    阴影，value是NSShadow对象
    
    
    NSTextEffectAttributeName
    文字效果，value是NSString
    
    
    NSAttachmentAttributeName
    附属，value是NSTextAttachment 对象
    
    
    NSLinkAttributeName
    链接，value是NSURL or NSString
    
    
    NSBaselineOffsetAttributeName
    基础偏移量，value是NSNumber对象
    
    
    NSStrikethroughColorAttributeName
    删除线颜色，value是UIColor
    
    
    NSObliquenessAttributeName
    字体倾斜
    
    
    NSExpansionAttributeName
    字体扁平化
    
    
    NSVerticalGlyphFormAttributeName
    垂直或者水平，value是 NSNumber，0表示水平，1垂直
    
    富文本段落排版格式属性说明
    
    属性说明

    lineSpacing
    字体的行间距

    firstLineHeadIndent
    首行缩进
 
    alignment
    （两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）

    lineBreakMode
    结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    
    headIndent
    整体缩进(首行除外)

    minimumLineHeight
    最低行高

    maximumLineHeight
    最大行高
    
    paragraphSpacing
    段与段之间的间距
    
    paragraphSpacingBefore
    段首行空白空间
    
    baseWritingDirection
    书写方向（一共三种）
    
    hyphenationFactor
    连字属性 在iOS，唯一支持的值分别为0和1
    */
    
    //方法一：set方法单向设置和集合设置
    //方法1、
//    [attributeString setAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] range:ran];
    //方法2、
//    [attributeString setAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:22], NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil] range:ran];
    //方法3、
//    NSDictionary *attributedDict = @{
//                                     NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:22],
//                                     NSForegroundColorAttributeName:[UIColor redColor]
//                                     };
    //,NSUnderlineStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleDouble | NSUnderlineStyleThick)
//    [attributeString setAttributes:attributedDict];
    //方法二：add方法设置key-value
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:ran];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:22] range:ran];
    return  attributeString;
}
- (void)showAll:(UIButton *)btn{

}
- (CGFloat)heightTextWithText:(UILabel *)text
{
    //    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake((text.frame.size.width), MAXFLOAT);
    //    //1.2配置计算时的行截取方法,和contentLabel对应
    //    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    //    [style setLineSpacing:0];
    //    //    //1.3配置计算时的字体的大小
    //    //    //1.4配置属性字典
    //    NSDictionary *dic = @{NSFontAttributeName:text.font, NSParagraphStyleAttributeName:style};
    //    //    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:dic];
    //    //    lb.attributedText = attributeStr;
    //    //2.计算
    //    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    //    CGFloat heightText = [text.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    //
    // 计算高度
    //    CGSize size = [text boundingRectWithSize:CGSizeMake(SNRealValue(ScreenWidth - 38 - 26), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont_Regular(15)} context:nil].size;
    //    CGFloat heightText = size.height;
    size = [text.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:text.font,NSFontAttributeName, nil]];
    
    return size.height;
}
- (void (^)(float))add
{
    __weak typeof(self) wself = self;
    void (^result)(float) = ^(float value){
        wself.tmp += value;
        
    };
    return result;
}
- (NSInteger)gcdWithNumber1:(NSInteger)num1 Number2:(NSInteger)num2{
    
    while(num1 != num2){
        if(num1 > num2){
            num1 = num1-num2;
        } else {
            num2 = num2-num1;
        }
    }
    return num1;
}
// 改变图片尺寸
-(UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y =0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x =0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0,0, asize.width, asize.height));//clear background
        [image drawInRect:rect];//压缩图片h指定尺寸
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return newimage;
}
////这样循环次数多，效率低，耗时长。
//- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength WithoutImage:(UIImage *)image{
//    CGFloat compression = 1;
//    NSData *data = UIImageJPEGRepresentation(image, compression);
//    while (data.length > maxLength && compression > 0) {
//        compression -= 0.02;
//        data = UIImageJPEGRepresentation(image, compression); // When compression less than a value, this code dose not work
//    }
//    return data;
//}
////二分法来优化
/*
 当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。最多压缩 6 次，1/(2^6) = 0.015625 < 0.02，也能达到每次循环 compression减小 0.02 的效果。这样的压缩次数比循环减小 compression少，耗时短。需要注意的是，当图片质量低于一定程度时，继续压缩没有效果。也就是说，compression继续减小，data 也不再继续减小。
 */
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength WithoutImage:(UIImage *)image{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
    /*
     //方法结合计算
     // Compress by quality
     CGFloat compression = 1;
     NSData *data = UIImageJPEGRepresentation(self, compression);
     //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
     if (data.length < maxLength) return data;
     
     CGFloat max = 1;
     CGFloat min = 0;
     for (int i = 0; i < 6; ++i) {
     compression = (max + min) / 2;
     data = UIImageJPEGRepresentation(self, compression);
     //NSLog(@"Compression = %.1f", compression);
     //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
     if (data.length < maxLength * 0.9) {
     min = compression;
     } else if (data.length > maxLength) {
     max = compression;
     } else {
     break;
     }
     }
     //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
     if (data.length < maxLength) return data;
     UIImage *resultImage = [UIImage imageWithData:data];
     // Compress by size
     NSUInteger lastDataLength = 0;
     while (data.length > maxLength && data.length != lastDataLength) {
     lastDataLength = data.length;
     CGFloat ratio = (CGFloat)maxLength / data.length;
     //NSLog(@"Ratio = %.1f", ratio);
     CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
     (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
     UIGraphicsBeginImageContext(size);
     [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
     resultImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     data = UIImageJPEGRepresentation(resultImage, compression);
     //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
     }
     //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
     return data;
     */
}

- (void)backBlockNilMetnod{
	self.returnTextBlock(@"backBlockNilMetnod");
	[self dismissViewControllerAnimated:YES completion:nil];

}
- (void)returnText:(ReturnTextBlock)block {
	self.returnTextBlock = block;
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
