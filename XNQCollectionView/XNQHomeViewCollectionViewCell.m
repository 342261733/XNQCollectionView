//
//  XNQHomeViewCollectionViewCell.m
//  CollectionView
//
//  Created by xnq on 16/2/29.
//  Copyright © 2016年 xnq. All rights reserved.
//

#import "XNQHomeViewCollectionViewCell.h"

@interface XNQHomeViewCollectionViewCell () {
    
    __weak IBOutlet UILabel *_cellTitle;
}


@end

@implementation XNQHomeViewCollectionViewCell

- (void)setCellTitle:(NSString *)strCellTitle {
    _cellTitle.text = strCellTitle;
}

@end
