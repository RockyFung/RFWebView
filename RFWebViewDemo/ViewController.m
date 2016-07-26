//
//  ViewController.m
//  RFWebViewDemo
//
//  Created by rocky on 16/7/26.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import "RFWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"RFWebViewDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    [btn setTitle:@"点击跳转" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)clickBtn:(UIButton *)btn{
    RFWebViewController *webVC = [[RFWebViewController alloc]init];
    webVC.urlString = @"http://www.cocoachina.com";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
