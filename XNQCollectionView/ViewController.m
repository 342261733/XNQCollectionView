//
//  ViewController.m
//  XNQCollectionView
//
//  Created by QFPayShadowMan on 16/2/29.
//  Copyright © 2016年 xnq. All rights reserved.
//

#import "ViewController.h"
#import "XNQHomeViewCollectionViewCell.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>{
    __weak IBOutlet UICollectionView *_collectionView;
    NSMutableArray                   *_arrData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrData = [NSMutableArray arrayWithArray:@[@"hello",@"hi",@"你好",@"yes",@"no",@"oh"]];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView.collectionViewLayout = flowLayout;
    
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [_collectionView addGestureRecognizer:longPressGes];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XNQHomeViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [cell setCellTitle:_arrData[indexPath.row]];
    return cell;
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)longGes {
    switch (longGes.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *selectIndexPath = [_collectionView indexPathForItemAtPoint:[longGes locationInView:_collectionView]];
            if (!selectIndexPath) {
                break;
            }
            [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            [_collectionView updateInteractiveMovementTargetPosition:[longGes locationInView:longGes.view]];
            break;
        case UIGestureRecognizerStateEnded:
            [_collectionView endInteractiveMovement];
            break;
            
        default:
            [_collectionView cancelInteractiveMovement];
            break;
    }
}



#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrData.count == 0) {
        return CGSizeMake(0, 0);
    }
    if (_arrData.count <= 6) {
        return CGSizeMake((KScreenWidth)/3.0, 125);
    }
    else {
        return CGSizeMake((KScreenWidth)/4.0, 100);
    }
    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(100, 100);
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

#pragma mark -UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did select %@",indexPath);
    [_arrData addObjectsFromArray:@[@"what",@"soo"]];
    [collectionView reloadData];
    
    //    [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *strSource = [_arrData objectAtIndex:sourceIndexPath.item];
    [_arrData removeObjectAtIndex:sourceIndexPath.item];
    [_arrData insertObject:strSource atIndex:destinationIndexPath.item];
    NSLog(@"data array %@",_arrData);
}

@end