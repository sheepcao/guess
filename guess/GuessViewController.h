//
//  GuessViewController.h
//  guess
//
//  Created by qy on 13-8-13.
//  Copyright (c) 2013年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GuessViewController : UIViewController{
    UIImageView *imageView ;
    UIButton *choiceButtons[24];
    UIButton *answerButton[4];
}

@end
