//
//  MainViewController.m
//  SlidingPuzzle
//
//  Created by my on 16/1/21.
//  Copyright © 2016年 zhux. All rights reserved.
//

#import "MainViewController.h"
#import "PairInteger.h"
@interface MainViewController ()
{
    int N;
    int blankPosX, blankPosY;
    UIImageView* imageViews[3][3];
    UIImage* images[3][3];
    
    NSMutableArray* stack;
    
}
@end

@implementation MainViewController

int dx[4] = {0, 0, -1, 1};
int dy[4] = {-1, 1, 0, 0};


- (void)initImages {
    for(int i = 0; i < N; ++i)
    {
        for(int j = 0; j < N; ++j){
            images[i][j] = [UIImage imageNamed:[NSString stringWithFormat:@"%d_%d-%d.jpg", N, i, j]];
        }
    }
    images[blankPosX][blankPosY] = nil;
}

- (void)initImageViews {
    CGFloat deltaY = self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y;
    CGFloat deltaX = 5;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height - deltaY;

    int interal = 2;
    CGFloat blockLen = (width-8)/N - 2;
    deltaY += (height-(blockLen*N+interal*(N-1)))/2;
    
    CGFloat x = 0;
    CGFloat y = 0;
    for(int i = 0; i < N; ++i)
    {
        x = 0;
        for(int j = 0; j < N; ++j)
        {
            imageViews[i][j] = [[UIImageView alloc] initWithImage:images[i][j]];
            imageViews[i][j].frame = CGRectMake(x+deltaX, y+deltaY, blockLen, blockLen);
            
            [imageViews[i][j] setUserInteractionEnabled:YES];
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveBlock:)];
            [singleTap setNumberOfTapsRequired:1];
            singleTap.delegate = imageViews[i][j];
            [imageViews[i][j] addGestureRecognizer:singleTap];

            x += interal + blockLen;
        }
        y += interal + blockLen;
    }
    imageViews[blankPosX][blankPosY].image = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    N = 3;
    blankPosX = N-1;
    blankPosY = N-1;
    [self initImages];
    [self initImageViews];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    do{
        [self newGame];
    }while([self check]);
    
    for(int i = 0; i < N; ++i){
        for(int j = 0; j < N; ++j){
            [self.view addSubview:imageViews[i][j]];
        }
    }
    [self.navigationItem.rightBarButtonItem setTarget:self];
    [self.navigationItem.rightBarButtonItem setAction:@selector(newGame)];
    [self.navigationItem.leftBarButtonItem setTarget:self];
    [self.navigationItem.leftBarButtonItem setAction:@selector(undo)];

    UISwipeGestureRecognizer *swipe;
    swipe =  [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBlock:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipe];
    
    swipe =  [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBlock:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:swipe];
    
    swipe =  [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBlock:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipe];
    
    swipe =  [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBlock:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:swipe];
}

- (void)newGame {
    stack = [[NSMutableArray alloc] initWithCapacity:10];

    int x, y, k;
    for(int i = 0; i < 10000; ++i){
        k = arc4random_uniform(4);
        x = blankPosX + dx[k];
        y = blankPosY + dy[k];
        if([self validPosX:x PosY:y]){
            [self exchangeBlankKind:0 posX:x posY:y];
        }
    }
    
}

- (void)undo {
    if([self check])
        return;
    PairInteger* pair = [stack lastObject];
    if(pair != nil){
        [self exchangeBlankKind:-1 posX:pair.x posY:pair.y];
        [stack removeLastObject];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (bool)validPosX:(int)x PosY:(int)y {
    if(x>=0 && x<N && y>=0 && y<N)
        return true;
    return false;
}

- (void)exchangeBlankKind:(int)k posX:(int)x posY:(int)y {
    if([self validPosX:x PosY:y]){
        if(k == 1){
//            printf("blank to %d %d\n", x, y);
            PairInteger* pair = [[PairInteger alloc] init];
            pair.x = blankPosX;
            pair.y = blankPosY;
            [stack addObject:pair];
            
        }else if(k == -1){
//            printf("blank back to %d %d\n", x, y);
        }
        UIImage* tmp = imageViews[x][y].image;
        imageViews[x][y].image = imageViews[blankPosX][blankPosY].image;
        imageViews[blankPosX][blankPosY].image = tmp;
        blankPosX = x;
        blankPosY = y;
    }

}

- (bool)check {
    for(int i = 0; i < N; ++i){
        for(int j = 0; j < N; ++j){
            if(imageViews[i][j].image != images[i][j]){
                return false;
            }
        }
    }
    return true;
}

- (void)moveBlock: (UIGestureRecognizer *)recognizer{
    if([self check])
        return;
    UIImageView* curr = (UIImageView*)recognizer.delegate;
    int x = -1;
    int y = -1;
    for(int i = 0; i < N; ++i){
        for(int j = 0; j < N; ++j){
            if(curr == imageViews[i][j]){
                x = i;
                y = j;
            }
        }
    }

    if(x != -1 && y != -1){
        bool get = false;
        for(int k = 0; k < 4; ++k){
            if(x+dx[k] == blankPosX && y+dy[k] == blankPosY){
                get = true;
                break;
            }
        }
        if(get){
            [self exchangeBlankKind:1 posX:x posY:y];
        }
    }
}

- (void)swipeBlock: (UISwipeGestureRecognizer *)recognizer {
    if([self check])
        return;
    int x = blankPosX;
    int y = blankPosY;
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        y++;
    }
    else if(recognizer.direction == UISwipeGestureRecognizerDirectionDown){
        x--;
    }
    else if(recognizer.direction == UISwipeGestureRecognizerDirectionUp){
        x++;
    }
    else if(recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        y--;
    }
    
    [self exchangeBlankKind:1 posX:x posY:y];
}



@end
