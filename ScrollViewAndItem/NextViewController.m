//
//  NextViewController.m
//  ScrollViewAndItem
//
//  Created by Xia_Q on 15/7/7.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "NextViewController.h"
#import "Normal.h"
@interface NextViewController ()
{
    NSMutableDictionary *_dict;
}
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dict=[[NSMutableDictionary alloc]init];
        
    


    [_btn1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_btn2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_btn3 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_btn4 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_btn5 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_btn6 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [_btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_btn5 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_btn6 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];

    
    [_btn1 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn4 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn5 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn6 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn1.tag=1;
    _btn2.tag=2;
    _btn3.tag=3;
    _btn4.tag=4;
    _btn5.tag=5;
    _btn6.tag=6;
    
    
    UIButton *button=[UIButton systemBtnWithFrame:CGRectMake(10 , 500, rect.size.width-20, 30) title:@"确定" action:^(UIButton *button) {
        
        if (self.getDict) {
            self.getDict(_dict);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    button.backgroundColor=[UIColor orangeColor];
    
    [self.view addSubview:button];


}

-(void)btn:(UIButton *)btn
{
    btn.selected=!btn.selected;
    if (btn.selected) {
        [_dict setObject:[NSString stringWithFormat:@"%ld",btn.tag] forKey:[NSString stringWithFormat:@"%ld",btn.tag]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
