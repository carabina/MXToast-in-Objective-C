//
//  ViewController.m
//  MXToast-OC-Demo
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import "ViewController.h"
#import "MXToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"MXToast Demo Application"];
}

- (void)viewDidAppear:(BOOL)animated {
    [[MXToast toast:@"Tap To Show Toast" duration:5] show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[MXToast toastWithFormat:@"%@\nrandom number %zd", self.title, arc4random_uniform(20000)] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
