//
//  NTViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "NTViewController.h"
#import "NTButton.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "BaseNavigationViewController.h"
#import "UIImage+UIImageExtras.h"

#define kTotalTabBarVC 4

@interface NTViewController (){

    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    
    NTButton * _previousBtn;//记录前一次选中的按钮
}


@end

@implementation NTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor grayColor];
        self.title = @"视图";
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //wsq
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != _tabBarView) {//_tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
//        if ([obj isKindOfClass:[]]) {
//            
//        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tabBar.hidden = YES;
    CGFloat tabBarViewY = self.view.frame.size.height - 49;
    
    
    //_tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tabBarViewY, 320, 49)];
    //wsq
    _tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:_tabBarView];
    //wsq
    [self.tabBar addSubview:_tabBarView];
    
    FirstViewController * first = [[FirstViewController alloc]init];
    first.delegate = self;
    //wsq  多肽
    UINavigationController * navi1 = [[BaseNavigationViewController alloc]initWithRootViewController:first];
    SecondViewController * second = [[SecondViewController alloc]init];
    UINavigationController * navi2 = [[UINavigationController alloc]initWithRootViewController:second];
    ThirdViewController * third = [[ThirdViewController alloc]init];
    UINavigationController * navi3 = [[UINavigationController alloc]initWithRootViewController:third];
    FourthViewController * fourth = [[FourthViewController alloc]init];
    UINavigationController * navi4 = [[UINavigationController alloc]initWithRootViewController:fourth];
    
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4, nil];
    
    [self creatButtonWithNormalName:@"我的训练_03.png" andSelectName:@"我的训练2_09.png" andTitle:nil andIndex:0];
    [self creatButtonWithNormalName:@"我的用户详情_03.png" andSelectName:@"会话2_03.png" andTitle:nil andIndex:1];
    [self creatButtonWithNormalName:@"动态_03.png" andSelectName:@"动态2_03.png" andTitle:nil andIndex:2];
    [self creatButtonWithNormalName:@"我的_09.png" andSelectName:@"用户2_09.png" andTitle:nil andIndex:3];
    NTButton * button = _tabBarView.subviews[0];
    [self changeViewController:button];
    
    // Do any additional setup after loading the view.
}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    NTButton * customButton = [NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;

    CGFloat buttonW = _tabBarView.frame.size.width / kTotalTabBarVC;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    customButton.frame = CGRectMake(buttonW * index, 0, buttonW, buttonH);
    
    UIImage *imageNormal = [UIImage imageNamed:normal];
    [customButton setImage:[imageNormal imageByScalingToSize:CGSizeMake(imageNormal.size.width/2, imageNormal.size.height/2)] forState:UIControlStateNormal];
    //[customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    //这里应该设置选中状态的图片。wsq
    UIImage * imageSelected=[UIImage imageNamed:selected];
    [customButton setImage:[imageSelected imageByScalingToSize:CGSizeMake(imageSelected.size.width/2, imageSelected.size.height/2)] forState:UIControlStateSelected];
    

    [customButton setTitle:title forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
   
    [_tabBarView addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项） wsq
    {
        _previousBtn = customButton;
        _previousBtn.selected = YES;
    }

}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(NTButton *)sender
 {
     if(self.selectedIndex != sender.tag){ //wsq®
         self.selectedIndex = sender.tag; //切换不同控制器的界面
         _previousBtn.selected = ! _previousBtn.selected;
         _previousBtn = sender;
         _previousBtn.selected = YES;
     }
}

#pragma mark 是否隐藏tabBar
//wsq
//-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean{
//    
//    _tabBarView.hidden=boolean;
//}

@end
