//
//  ViewController.h
//  AFNetDemo
//
//  Created by 晓磊 on 2017/8/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface User :NSObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSUInteger age;
@end
@interface Card :NSObject
@property (nonatomic,strong)NSString *infor;
@property (nonatomic,strong)User *user;
@end
@interface ViewController : UIViewController
{
    User *user;
    Card *card;
}

@end
