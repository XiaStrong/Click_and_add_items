//
//  BlockBtn.m
//  ScrollViewAndItem
//
//  Created by Xia_Q on 15/7/7.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "BlockBtn.h"

@implementation BlockBtn

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)btnClick:(UIButton *)button
{
    //点击后执行传入的block
    if(self.action)
    {
        self.action(button);
    }
}

@end


@implementation UIButton (BlockBtn)

+(UIButton *)systemBtnWithFrame:(CGRect)frame title:(NSString *)title action:(void (^)(UIButton *))action
{
    BlockBtn *button = [BlockBtn buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.backgroundColor=[UIColor orangeColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.action = action;
    return button;

}

@end