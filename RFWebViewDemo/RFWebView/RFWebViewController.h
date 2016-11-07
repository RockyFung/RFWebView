//
//  RFWebViewController.h
//  RFWebViewDemo
//
//  Created by rocky on 16/7/26.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface RFWebViewController : UIViewController
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, copy) NSString *navigationgTitle;
@property (nonatomic, strong) UIColor *navigationBarColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL showRefreshBtn;
@end
