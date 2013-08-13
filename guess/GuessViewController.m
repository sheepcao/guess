//
//  GuessViewController.m
//  guess
//
//  Created by qy on 13-8-13.
//  Copyright (c) 2013年 qy. All rights reserved.
//

#import "GuessViewController.h"

@interface GuessViewController ()

@end

@implementation GuessViewController

UIButton *answerButton[4];
NSString *answer = @"锦上添花";
NSString *choices = @"锦是句成语是在上再绣花比喻好利佳加好添美发的要吉";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 8; col++) {
            int x = 70 + col * 80;
            int y = 700 + row * 80;
            int i = row*8 + col;
            CGRect frame = CGRectMake(x, y, 70, 70);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = frame;
            NSString *title = [NSString stringWithFormat:@"%C", [choices characterAtIndex:i]];
            [button setTitle:title forState: UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
            button.tag = 2000+i;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    
    for (int i = 0; i < 4; i++) {
        int x = 200 + i * 100;
        int y = 600;
        CGRect frame = CGRectMake(x, y, 90, 90);
        answerButton[i] = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        answerButton[i].frame = frame;
        [answerButton[i] setTitle:@"" forState: UIControlStateNormal];
        answerButton[i].backgroundColor = [UIColor clearColor];
        answerButton[i].tag = 3000+i;
        [answerButton[i] addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:answerButton[i]];	
    }
    
    CGRect frame = CGRectMake(200, 80, 500, 500);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"question1"];
    [self.view addSubview:imageView];

}

-(IBAction) buttonClicked:(id)sender {
    UIButton *btn = (UIButton*) sender;

    if (btn.tag >= 2000 && btn.tag < 3000) {
        // from choices box
        for (int i = 0; i < 4; i++) {
            if ([[answerButton[i] currentTitle] isEqualToString:@""]) {
                [answerButton[i] setTitle:[btn currentTitle] forState:UIControlStateNormal];
                break;
            }
        }
    } else if (btn.tag >= 3000) {
        // from answer box
        [btn setTitle:@"" forState:UIControlStateNormal];
    } else {

    }
    int i;
    NSString *ans = @"";
    for (i = 0; i < 4; i++) {
        NSString *title = [answerButton[i] currentTitle];
        if (![title isEqualToString:@""]) {
            ans = [ans stringByAppendingString:title];
        } else {
            break;
        }
    }
    if (i == 4) {
        NSString *msg;
        if ([ans isEqualToString:answer]) {
            msg = @"运气不错，答对了！";
        } else {
            msg = @"人品不行，继续努力";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
