//
//  RFWebViewController.m
//  RFWebViewDemo
//
//  Created by rocky on 16/7/26.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "RFWebViewController.h"

#define navigationBarHeight 0
@interface RFWebViewController ()

@end

@implementation RFWebViewController


- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor grayColor];
    
    
    
    [self setupNavigationBar];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 打开页面加载url
    [self loadRequest];

}
- (void)setupNavigationBar{
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.titleView = self.titleLabel;
    
    // 设置导航条背景色
    if (self.navigationBarColor) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:self.navigationBarColor] forBarMetrics:UIBarMetricsDefault];
        UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20)];
        vv.backgroundColor = self.navigationBarColor;
        [self.navigationController.navigationBar addSubview:vv];
    }
    
    
    // 标题颜色
    if (self.titleColor) {
        self.navigationController.navigationBar.tintColor = self.titleColor;
    }
    
    // 右上角刷新按钮
    if (self.showRefreshBtn) {
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        refreshBtn.frame = CGRectMake(0, 0, 50, 30);
        [refreshBtn addTarget: self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:refreshBtn];
    }
 
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progressView.progress = self.webView.estimatedProgress;
        // 加载完成
        if (self.webView.estimatedProgress  >= 1.0f ) {
            
            [UIView animateWithDuration:0.5f animations:^{
                self.progressView.alpha = 0.0f;
                self.progressView.progress = 0.0f;
            }];
            
        }else{
            self.progressView.alpha = 1.0f;
        }
        
    }
    
}

#pragma mark Action
- (void)loadRequest {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}

- (void)reloadAction {
    
    [self.webView reload];
}

#pragma mark LazyLoad
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.frame = CGRectMake(0, navigationBarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - navigationBarHeight);
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.frame = CGRectMake(0, navigationBarHeight, [UIScreen mainScreen].bounds.size.width, 2);
    }
    return _progressView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    }
    return _titleLabel;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
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
