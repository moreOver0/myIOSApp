//
//  PuzzleViewController.h
//  SlidingPuzzle
//
//  Created by my on 16/1/21.
//  Copyright © 2016年 zhux. All rights reserved.
//

#import "ViewController.h"
//#import "CollectionView.h"
#import "CollectionCell.h"

@interface PuzzleViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView* collection;

@property (strong, nonatomic) IBOutlet CollectionCell* cell1;
@property (strong, nonatomic) IBOutlet CollectionCell* cell2;
@property (strong, nonatomic) IBOutlet CollectionCell* cell3;


@end
