//
//  TestViewController.m
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//


#import "TestViewController.h"
#import "JKAreaCollectionViewCell.h"
#import "JKAreaTableViewCell.h"
#import "JKReusableView.h"
#import "FootReusableView.h"
#import "JKFlowLayout.h"
#import "黑金商城-Swift.h"

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    JKFlowLayout *layout;
    NSInteger _selectIndex;//记录位置
    BOOL _isScrollDown;//滚动方向
}


@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation TestViewController
static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";
#define CIO_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CIO_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define JKRandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1.0]
#define TitleBlackCOLOR [UIColor colorWithRed:(51)/255.0 green:(51)/255.0 blue:(51)/255.0 alpha:1]
#define backgrCOlor [UIColor colorWithRed:(245)/255.0 green:(245)/255.0 blue:(245)/255.0 alpha:1]
#define whitesmallColorc [UIColor colorWithRed:(250)/255.0 green:(250)/255.0 blue:(250)/255.0 alpha:1]
#define huiCoor [UIColor colorWithRed:(156)/255.0 green:(160)/255.0 blue:(181)/255.0 alpha:1]

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:(245)/255.0 green:(245)/255.0 blue:(245)/255.0 alpha:1];
    self.title = @"商品分类";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

    
    
    _selectIndex = 0;
    _isScrollDown = YES;

   
//    UIView * tableViewBgview = [[UIView alloc]initWithFrame:CGRectMake(0, 15.0, 100.0, CIO_SCREEN_HEIGHT - 64.0)];
//    tableViewBgview.backgroundColor = UIColor.whiteColor;
//    [self.view addSubview:tableViewBgview];
    layout = [JKFlowLayout new];
    //layout.itemSize = CGSizeMake((CIO_SCREEN_WIDTH-78)/4.0, 40);
    //layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    layout.naviHeight = 0;
    
    /**
     *  设置滑动方向
     *  UICollectionViewScrollDirectionHorizontal 水平方向
     *  UICollectionViewScrollDirectionVertical   垂直方向
     */
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectionView registerClass:[JKAreaCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[JKReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
    [self.collectionView registerClass:[FootReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:footerID];
   
    // collectionView 的添加
    [self.view addSubview:self.collectionView];
    
    // tableView 的添加
    [self.view addSubview:self.tableView];
//    UIView *headTableView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CIO_SCREEN_WIDTH, 8)];
//    headTableView.backgroundColor = backgrCOlor;
//    self.tableView.tableHeaderView = headTableView;
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchResultsViewController * vc = [SearchResultsViewController new];
   
    GoodsCategoryModel * model = self.titleArr[indexPath.section];
    NSArray * array = model.sonList;
    if (indexPath.row > array.count - 1) {
        return;
    }
    GoodsCategoryModelSonList *sonmodel = array[indexPath.row];
              
    vc.cateId = [[NSString alloc]initWithFormat:@"%@",sonmodel.lsID];
    vc.parentCateId = [[NSString alloc]initWithFormat:@"%@",sonmodel.pid];
    vc.mailDisText = sonmodel.cateName;
    [self.navigationController pushViewController:vc animated:true];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
//    return self.headTittleDataArray.count;
    
    return self.titleArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSArray *array = self.dataArray[section];
    GoodsCategoryModel * model = self.titleArr[section];
    NSArray * array = model.sonList;
    int yu = array.count % 3;
    
    if (yu != 0) {
        int cha = 3 - yu;
        return array.count + cha;
    }
    return array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

        JKAreaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
       GoodsCategoryModel * model = self.titleArr[indexPath.section];
        NSArray * array = model.sonList;
//        NSArray *array = self.dataArray[indexPath.section];
        if (indexPath.row > array.count - 1) {
           cell.areaName.text = @"";
           cell.areaImage.hidden = YES;
        }else{
            cell.areaImage.hidden = NO;
//            cell.areaName.text = array[indexPath.row];
            
               
            GoodsCategoryModelSonList *somModel = array[indexPath.row];
            cell.areaName.text =  somModel.cateName;
            [[SwiftOC new] getImgae:cell.areaImage :somModel.icon];
        }
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgV.bounds byRoundingCorners:UIRectCornerAllCorners  cornerRadii:CGSizeMake(0, 0)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

           maskLayer.frame = cell.bgV.bounds;

           maskLayer.path = maskPath.CGPath;

           cell.bgV.layer.mask = maskLayer;
    if (indexPath.row == 0 ) {
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgV.bounds byRoundingCorners:UIRectCornerTopLeft  cornerRadii:CGSizeMake(10, 10)];

        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

        maskLayer.frame = cell.bgV.bounds;

        maskLayer.path = maskPath.CGPath;

        cell.bgV.layer.mask = maskLayer;
    }
    
    if (indexPath.row == 2) {
         UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgV.bounds byRoundingCorners:UIRectCornerTopRight  cornerRadii:CGSizeMake(10, 10)];

               CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

               maskLayer.frame = cell.bgV.bounds;

               maskLayer.path = maskPath.CGPath;

               cell.bgV.layer.mask = maskLayer;
    }
    
    int yu = array.count % 3;
    long int sum  = array.count;
    if (yu != 0) {
        int cha = 3 - yu;
        sum = array.count + cha;
    }
    if (indexPath.row == sum - 3) {
         UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgV.bounds byRoundingCorners:UIRectCornerBottomLeft  cornerRadii:CGSizeMake(10, 10)];

               CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

               maskLayer.frame = cell.bgV.bounds;

               maskLayer.path = maskPath.CGPath;

               cell.bgV.layer.mask = maskLayer;
    }
    
    if (indexPath.row == sum - 1) {
         UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgV.bounds byRoundingCorners:UIRectCornerBottomRight  cornerRadii:CGSizeMake(10, 10)];

               CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

               maskLayer.frame = cell.bgV.bounds;

               maskLayer.path = maskPath.CGPath;

               cell.bgV.layer.mask = maskLayer;
    }
    
        return cell;
 
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionFooter) {
        
        FootReusableView *footer = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerID forIndexPath:indexPath];
        footer.backgroundColor = backgrCOlor;
        return footer;
    }

     JKReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
    
       header.backgroundColor = backgrCOlor;
    
    
    GoodsCategoryModel * model = self.titleArr[indexPath.section];
    header.headText.text =  model.cateName;
    
    
      return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   
        
    return CGSizeMake(0, 40);

   // return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 2) {
     
       return CGSizeMake(0, 8);
    }

    return CGSizeZero;
}

// 导航栏是否消失
-(BOOL)prefersStatusBarHidden
{
    return NO;
}

//列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
//    return 1.f;
     return 0.f;
}

//行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
     return 0.f;
//    return 1.f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
//    return UIEdgeInsetsMake(1, 0, 1,0);
    return UIEdgeInsetsMake(0, 0, 0,0);
}
/*
 格子的宽高设置
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake((CIO_SCREEN_WIDTH-69-9-2)/3.0, 100);
    return CGSizeMake((CIO_SCREEN_WIDTH- 128)/3.0, (110.0/375.0)*CIO_SCREEN_WIDTH);
}
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
       
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(114,8, CIO_SCREEN_WIDTH-128, CIO_SCREEN_HEIGHT-100-8) collectionViewLayout: layout];
        _collectionView.backgroundColor = backgrCOlor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.pagingEnabled = NO;
    }
    
    return _collectionView;
}



-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,8.0, 100, CIO_SCREEN_HEIGHT-64)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //self.tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = UIColor.whiteColor;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return self.tableTittleDataArray.count;
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *cellID = @"cellID";
  
  
    
   JKAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            
    if (!cell) {
                
        cell = [[JKAreaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_selectIndex == indexPath.row) {
        
        cell.nameText.backgroundColor = [UIColor whiteColor];
        cell.nameText.textColor =  [UIColor colorWithRed:(222)/255.0 green:(21)/255.0 blue:(36)/255.0 alpha:1];
    }else{
        cell.nameText.backgroundColor = whitesmallColorc;
         cell.nameText.textColor =  [UIColor colorWithRed:(153)/255.0 green:(153)/255.0 blue:(153)/255.0 alpha:1];
    }
    
//    cell.nameText.text = self.tableTittleDataArray[indexPath.row];
    
     GoodsCategoryModel * model = self.titleArr[indexPath.row];
    cell.nameText.text = model.cateName;
    cell.backgroundColor = UIColor.clearColor;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 57.0;
            
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CIO_SCREEN_WIDTH, 0.1)];
    headView.backgroundColor = UIColor.clearColor;
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CIO_SCREEN_WIDTH, 0.1)];
    footView.backgroundColor = backgrCOlor;
    
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    //         当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section];
    }
}
// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath {
    //当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}
// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index {

    _selectIndex = index;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.tableView reloadData];
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

// 选中 处理collectionView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    CGRect headerRect = [self frameForHeaderForSection:_selectIndex];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
     [self.tableView reloadData];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}

-(void)click{
  
    [self.navigationController popViewControllerAnimated:YES];
    
}
                                                                                                                 
                                                                                                                 
                                                                                                                 
@end

