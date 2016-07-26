//
//  RFWebViewController.h
//  RFWebViewDemo
//
//  Created by rocky on 16/7/26.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFWebViewController : UIViewController
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *navigationgTitle;
@property (nonatomic, strong) UIColor *navigationBarColor;
@property (nonatomic, strong) UIColor *titleColor;
@end
