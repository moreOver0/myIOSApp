//
//  DetailViewController.h
//  Pedometer - Name of the Health
//
//  Created by my on 16/1/19.
//  Copyright © 2016年 zhux. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

