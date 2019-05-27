//
//  LabelMethodBlockSubVC.m
//  Test
//
//  Created by Rillakkuma on 2016/11/29.
//  Copyright © 2016年 Rillakkuma. All rights reserved.
//

#import "LabelMethodBlockSubVC.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

@interface LabelMethodBlockSubVC ()
{
    int numC;//全局变量
    // 全局变量
    int global_var;
    BOOL chooseState;
}
// 属性声明的block都是全局的__NSGlobalBlock__
@property (nonatomic, copy) void (^copyBlock)(void);
@property (nonatomic, weak) void (^weakBlock)(void);

//测试字符串⬇️⬇️⬇️
@property(nonatomic,copy)NSString*str1;
@property(nonatomic,strong)NSString*str2;
//测试字符串⬆️⬆️⬆️

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
    [self testDataD];
    [self testDataE];//Operation
    [self testDataF];//GCD
    [self testDataG];//深、浅拷贝
    [self testDataH];//交换
    [self testDataL];//排序方式
    [self testDataM];//排序
    //    [self testDataK];
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
- (void (^)(float))add
{
    __weak typeof(self) wself = self;
    void (^result)(float) = ^(float value){
        wself.tmp += value;
        
    };
    return result;
}

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
        chooseState = YES;
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
