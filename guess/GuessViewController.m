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
int answerButtonTag[4]={0};
int choicesTag[4]={0};
NSString *answer = @"锦上添花";
NSString *choices = @"锦是句成语是在上再绣花比喻好利佳加好添美发的要吉";
NSString *choices1 = @"锦是句成语是在上再绣花比喻好利佳加好添美发的要吉";
//NSMutableArray *temp=nil;
//NSMutableDictionary *findPosition;





- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
 //   self.findPosition=[NSMutableDictionary dictionaryWithCapacity:50];
    
    self.findPosition=[NSMutableArray arrayWithCapacity:25];
    
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
            
            NSLog(@"tag of %@ is %d",button.currentTitle,button.tag);
            
            [self.findPosition addObject:button.currentTitle];
            
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
        answerButton[i].backgroundColor = [UIColor blueColor];
        answerButton[i].tag = 3000+i;
        [answerButton[i] addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:answerButton[i]];	
    }
    
    CGRect frame = CGRectMake(200, 80, 500, 500);
    
    imageView = [[UIImageView alloc] initWithFrame:frame];
   // imageViewTemp=imageView;
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
               
                choicesTag[i]=btn.tag-2000;
                answerButtonTag[i]=answerButton[i].tag;
                
                [btn setTitle:@"" forState:UIControlStateNormal];
              
                
                [btn removeFromSuperview];
                
                break;
            }
        }
    } else if (btn.tag >= 3000) {
        // from answer box
        if (![[btn currentTitle] isEqualToString:@""]) {
 
            int index=0;
            for (int i=0; i<4; i++) {
               if( answerButtonTag[i]==btn.tag)
               {
                   index=choicesTag[i];
               
            
                    int x=(index%8)*80+70;
                    int y=(index/8)*80+700;
                    
            CGRect frame = CGRectMake(x, y, 70, 70);
            UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button1.frame = frame;
        //    NSString *title = [NSString stringWithFormat:@"%@", btn.currentTitle];
         //   NSLog(@"%@",btn.currentTitle);
            [button1 setTitle:btn.currentTitle forState: UIControlStateNormal];
         //   NSLog(@"%@",button1.currentTitle);
            
            button1.backgroundColor = [UIColor clearColor];
            button1.tag = 2000+choicesTag[i];
             
            [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button1];
                
                [btn setTitle:@"" forState:UIControlStateNormal];
               }
           
            }
                       
        }
        
                
        
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
            NSLog(@"%@",answerButton[0].currentTitle);

          //  CGRect frame = CGRectMake(200, 80, 500, 500);

         //  UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            imageView.image = [UIImage imageNamed:@"question2"];
            [self.view addSubview:imageView];   
           // imageViewTemp.image=[UIImage imageNamed:@"question2"];
  //          NSLog(@"%@",answerButton[1].currentTitle);
  //          NSLog(@"qqqq");

            int i;
            for (i=0; i<4; i++) {
              
                
                int x=(choicesTag[i]%8)*80+70;
                int y=(choicesTag[i]/8)*80+700;
                
                CGRect frame = CGRectMake(x, y, 70, 70);
                UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button1.frame = frame;
                [button1 setTitle:answerButton[i].currentTitle forState: UIControlStateNormal];
                //   NSLog(@"%@",button1.currentTitle);
                
                button1.backgroundColor = [UIColor clearColor];
                button1.tag = 2000+choicesTag[i];
                
                [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button1];
                
                  [answerButton[i] setTitle:@"" forState:UIControlStateNormal];


      //          NSLog(@"%@",answerButton[i].currentTitle);
            }
            
            
            
         
            
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
