//
//  MainViewController.m
//  SlidingPuzzle
//
//  Created by my on 16/1/21.
//  Copyright © 2016年 zhux. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    
    int deltaY;
    UIImageView* imageViews[3][3];
    UIImage* images[9];
    
}


@end

@implementation MainViewController

- (void)initImages {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    deltaY = self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y;
    printf("%d\n", deltaY);
    
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImageView* imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Maggie_3s.jpg"]];
    imageView1.frame = CGRectMake(0, 64, 120, 120);
    
    
    [imageView1 setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [imageView1 addGestureRecognizer:singleTap];
    
    
    [self.view addSubview:imageView1];
    

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


- (void)singleTapping: (UIGestureRecognizer *)recognizer{
    printf("get\n");
}

@end
