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

int choicesTag[4];
NSString *answer = @"锦上添花";
NSString *choices = @"锦是句成语是在上再绣花比喻好利佳加好添美发的要吉";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /* create 3x8 choices buttons */ 
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 8; col++) {
            int x, y;
            CGRect frame;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                x = 70 + col * 80;
                y = 700 + row * 80;
                frame = CGRectMake(x, y, 70, 70);
            } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                x = 20 + col * 35;
                y = 350 + row * 35;
                frame = CGRectMake(x, y, 32, 32);
            }
            
            int i = row * 8 + col;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            choiceButtons[i] = button;
            button.frame = frame;
            button.backgroundColor = [UIColor clearColor];
            button.tag = 2000+i;
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    
    /* create 4 answer buttons */
    for (int i = 0; i < 4; i++) {
        int x, y;
        CGRect frame;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            x = 200 + i * 100;
            y = 600;
            frame = CGRectMake(x, y, 90, 90);
        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            x = 60 + i * 50;
            y = 300;
            frame = CGRectMake(x, y, 45, 45);
        }

        answerButton[i] = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        answerButton[i].frame = frame;
        answerButton[i].backgroundColor = [UIColor blueColor];
        answerButton[i].tag = 3000+i;
        [answerButton[i] addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:answerButton[i]];
    }
    
    /* Image frame */
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frame = CGRectMake(200, 80, 500, 500);
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        frame = CGRectMake(60, 40, 250, 250);
    }
    
    imageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:imageView];
    
    /* start the game */
    [self newRound];
}

-(IBAction) buttonClicked:(id)sender {
    UIButton *btn = (UIButton*) sender;
    
    if (btn.tag >= 2000 && btn.tag < 3000) {
        // from choices box
        for (int i = 0; i < 4; i++) {
            if ([[answerButton[i] currentTitle] isEqualToString:@""]) {
                [answerButton[i] setTitle:[btn currentTitle] forState:UIControlStateNormal];
                choicesTag[i] = btn.tag;
                [btn setHidden:YES];
                break;
            }
        }
    } else if (btn.tag >= 3000) {
        // from answer box
        if (![[btn currentTitle] isEqualToString:@""]) {
            int idx = choicesTag[btn.tag - 3000] - 2000;
            [choiceButtons[idx] setHidden:NO];
            [btn setTitle:@"" forState:UIControlStateNormal];
        }
    } else {
        NSLog(@"Invalid TAG %d", btn.tag);
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
            NSLog(@"%@",answerButton[0].currentTitle);
            [self newRound];
        } else {
            msg = @"人品不行，继续努力";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void) newRound
{
    static int round = 1;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"question%d", round++ % 11]];
    for (int i = 0; i < 24; i++) {
        NSString *title = [NSString stringWithFormat:@"%C", [choices characterAtIndex:i]];
        [choiceButtons[i] setTitle:title forState:UIControlStateNormal];
        [choiceButtons[i] setHidden:NO];
    }
    for (int i = 0; i < 4; i++) {
        [answerButton[i] setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
