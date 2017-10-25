//
//  ViewController.m
//  lockTest
//
//  Created by Honour on 2017/10/10.
//  Copyright © 2017年 Honour. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int _num;
    NSLock *_lock;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _num = 20;
    _lock = [[NSLock alloc]init];
    NSThread *th1 = [[NSThread alloc]initWithTarget:self selector:@selector(eatApples) object:nil];
    [th1 setName:@"A"];
    NSThread *th2 = [[NSThread alloc]initWithTarget:self selector:@selector(eatApples) object:nil];
    [th2 setName:@"B"];
    [th1 start];
    [th2 start];
}

- (void)eatApples
{
    
    for(;;)
    {
        @try{
            [_lock lock];
            if(_num > 0)
            {
                NSLog(@"%@吃了编号为%d的苹果",[NSThread currentThread].name,_num);
                [NSThread sleepForTimeInterval:0.01];
                _num--;
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception.reason);
        } @finally {
            [_lock unlock];
        }
    }
     
    /*
    while (YES)
    {
        @synchronized(self)
        {
            if(_num > 0)
            {
                NSLog(@"%@吃了编号为%d的苹果",[NSThread currentThread].name,_num);
                [NSThread sleepForTimeInterval:0.01];
                _num--;
            }
            else
            {
                return;
            }
        }
    }
*/
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
