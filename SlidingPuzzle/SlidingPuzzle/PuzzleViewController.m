//
//  PuzzleViewController.m
//  SlidingPuzzle
//
//  Created by my on 16/1/21.
//  Copyright © 2016年 zhux. All rights reserved.
//

#import "PuzzleViewController.h"
#import "CollectionCell.h"

@interface PuzzleViewController ()

@end

@implementation PuzzleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    
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


#pragma mark -- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionCell* cell = nil;
    if(cell == nil){
        cell = self.cell2;
        
    }
    
    cell.content.image = [UIImage imageNamed:@"Maggie_3s.jpg"];

//    CollectionCell* cell;
    //图片名称
//    NSString *imageToLoad = [NSString stringWithFormat:@"%d.png", indexPath.row];
    //加载图片
//    cell.imageView.image = [UIImage imageNamed:imageToLoad];
    //设置label文字
//    cell.label.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.row,(long)indexPath.section];
    
    return cell;
}


@end
