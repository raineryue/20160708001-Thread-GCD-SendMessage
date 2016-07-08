//
//  ViewController.m
//  20160708001-Thread-GCD-SendMessage
//
//  Created by Rainer on 16/7/8.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showDownLoadImage];
}

- (void)showDownLoadImage {
    // 使用 异步函数 + 并行队列 下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获取图片地址
        NSURL *imageUrl = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/38dbb6fd5266d0163e620ee5962bd40734fa3587.jpg"];
        
        // 下载图片
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        
        // 回到主线程中显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
        
    });
}

@end
