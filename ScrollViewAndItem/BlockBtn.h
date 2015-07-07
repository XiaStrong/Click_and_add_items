//
//  BlockBtn.h
//  ScrollViewAndItem
//
//  Created by Xia_Q on 15/7/7.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BlockBtn : UIButton
{
    //处理事件的block语句块
    void (^_action)(UIButton *button);
}

@property(copy,nonatomic)void (^action)(UIButton *button);

@end

//为调用方便，添加类别
@interface UIButton (BlockBtn)

//按钮创建方法
+(UIButton *)systemBtnWithFrame:(CGRect)frame title:(NSString *)title action:(void(^)(UIButton *button))action;

@end