//
//  RFWebViewController.m
//  RFWebViewDemo
//
//  Created by rocky on 16/7/26.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "RFWebViewController.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface RFWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *progressTimer;
@end

@implementation RFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.translucent = NO;
    
    if (self.navigationgTitle) {
        self.navigationItem.title = self.navigationgTitle;
    }
    
    // 设置导航条背景色
    if (self.navigationBarColor) {
        [self.navigationController.navigationBar setBackgroundColor:self.navigationBarColor];
        UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, -20, KScreenWidth, 20)];
        vv.backgroundColor = self.navigationBarColor;
        [self.navigationController.navigationBar addSubview:vv];
    }
    
    
    // 标题颜色
    if (self.titleColor) {
        self.navigationController.navigationBar.tintColor = self.titleColor;
    }
    
    
    
    // 设置webView
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    NSURL *url = [NSURL URLWithString:self.urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
    
    // 添加进度条
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 2)];
    _progressView.progressTintColor = [UIColor greenColor];
    _progressView.trackTintColor = [UIColor clearColor];
    [self.view addSubview:_progressView];
    
    
    // 设置定时器
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(progressTimerAction) userInfo:nil repeats:YES];
    [_progressTimer setFireDate:[NSDate distantFuture]];
    
    // 右上角刷新按钮
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setImage: [UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
    refreshBtn.frame = CGRectMake(0, 0, 25, 25);
    [refreshBtn addTarget: self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:refreshBtn];


}
- (void)refresh{
    [self.webView reload];
}


- (void)progressTimerAction{
    _progressView.progress += 0.005;
    if (_progressView.progress >= 0.95){
        [_progressTimer setFireDate:[NSDate distantFuture]];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    _progressView.progress= 0.0;
    [_progressTimer setFireDate:[NSDate distantPast]];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([error code] == NSURLErrorCancelled)//一个页面没有被完全加载之前收到下一个请求，此时迅速会出现此error,error=-999
        //此时可能已经加载完成，则忽略此error，继续进行加载。
    {
        return;
    }
    _progressView.progress = 0.0;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressTimer setFireDate:[NSDate distantFuture]];
    _progressView.progress = 0.0;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;   //为yes加载内容，否则不
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
