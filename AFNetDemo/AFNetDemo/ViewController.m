//
//  ViewController.m
//  AFNetDemo
//
//  Created by 晓磊 on 2017/8/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkReachabilityManager.h"

@implementation Card
- (NSString *)info {
    return [NSString stringWithFormat:@"%@/%lu",_user.name,(unsigned long)_user.age];
}
 - (void)setInfo:(NSString *)info {
    NSArray *array = [info componentsSeparatedByString:@"/"];
    _user.name = array[0];
    _user.age = [array[1] integerValue];
}

//当user中的name或者age的值发生改变的时候，就会触发info的键值监听方法。这就是键值依赖的作用。
+(NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    NSArray * moreKeyPaths = nil;
    if ([key isEqualToString:@"infor"]) {
        moreKeyPaths = [NSArray arrayWithObjects:@"user.name",@"user.age",nil];
    }
    if (moreKeyPaths) {
        keyPaths = [keyPaths setByAddingObjectsFromArray:moreKeyPaths];
    }
    return keyPaths;
}

@end
@implementation User

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"xxxx");
}


@end
@interface ViewController ()<NSStreamDelegate>

@end

@implementation ViewController
static void *PersonAccountBalanceContext = &PersonAccountBalanceContext;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self scf];
}

//
- (void)reachability {
    AFNetworkReachabilityManager *reachability =[AFNetworkReachabilityManager managerForDomain:@"www.aachuxing.com"];
    //AFNetworkReachabilityManager *reachability =[AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                 NSLog(@"----未知-----");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"----没有网络-----");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"----wifi------");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"-----手机网络------");
                break;
            default:
                break;
        }
    }];
    
}


static void ReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info){
    NSLog(@"%d",flags);
    
}

- (void) scf{
    SCNetworkReachabilityRef scfReach = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [@"www.aachuxing.com" UTF8String]);
   // SCNetworkConnectionContext contex = {0, (__bridge void *)block,retainCallBack,reaseCallBack,NULL};
    SCNetworkReachabilitySetCallback(scfReach, ReachabilityCallback, nil);
    SCNetworkReachabilityScheduleWithRunLoop(scfReach, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}
//kvo
- (void)card {
    user = [[User alloc] init];
    card = [[Card alloc] init];
    card.user = user;
    [card addObserver:self forKeyPath:@"infor" options:(NSKeyValueObservingOptionNew |
                                                     NSKeyValueObservingOptionOld) context:nil];
    card.user.age = 1;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"xxxx");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
