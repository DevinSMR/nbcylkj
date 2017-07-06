/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGClassCategoryController.h"
#import "NTGInstitutionTableView.h"
#import "NTGSendRequest.h"
#import "NTGAgencyPageController.h"
#import "NTGSeller.h"
#import "NTGProductSellerAttrWrapper.h"
#import "NTGConstant.h"
#import "NTGOrderType.h"
#import "NTGAttribute.h"
#import "EQPageCycleSize.h"
#import "NTGGestureRecognizer.h"
#import "NTGFilterView.h"
#import "NTGAttributeView.h"
#import "NTGFilterCell.h"
#import "NTGAttributeCell.h"
#import <MJRefresh.h>

/**
 * control - 分类机构列表控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGClassCategoryController ()<InstitutionTableViewDelegate,NTGOrderTypeDelegate,FilterViewDelegate,AttributeViewDelegate>
@property (weak, nonatomic) IBOutlet NTGInstitutionTableView *InstitutionTable;

@property (nonatomic,strong) NTGOrderType *orderType;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) NSMutableArray *defaultAttrs;
@property (nonatomic,strong) NSMutableArray *priceAttrs;
@property (strong, nonatomic) NTGGestureRecognizer *customGestureRecognizer;
@property (nonatomic,strong) NSArray *attribute;
@property (nonatomic,strong) UIView *coverFilterView;
@property (nonatomic,strong) NTGFilterView *filterView;
@property (nonatomic,strong) NTGAttributeView *attributeView;
@property (nonatomic,strong) NSIndexPath *index;

@end

@implementation NTGClassCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_reqParam ||![_reqParam isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *tempReqParam = [NSMutableDictionary dictionary];
        [tempReqParam addEntriesFromDictionary:_reqParam];
        _reqParam = tempReqParam;
    }
    
    [self.reqParam setValue:@"1" forKey:@"pageNumber"];
    [self.reqParam setValue:@"10" forKey:@"pageSize"];
    self.InstitutionTable.delegateInstitution = self;
    
    // 下拉刷新
    self.InstitutionTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshDown];
    }];
    
    // 上拉刷新
    self.InstitutionTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshUp];
    }];
    
    [self pageInitData:NTGPulRefreshInit];
    [self initDefaultFilter];
    [self initPriceFilter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.isDiscovery) {
        self.backToPage(1);

    }
}


- (void) pageInitData :(NTGPullRefresh)action {
    if (action == NTGPulRefreshInit || action == NTGPulRefreshDown) {
        [self.reqParam setObject:@"1" forKey:@"pageNumber"];
    }
    
    [self initData:action];
}


- (void) updateTableView:(NSArray *)sellers action:(NTGPullRefresh)action state:(BOOL) state {
    if (action == NTGPulRefreshDown || action == NTGPulRefreshInit) {//表示是下拉刷新、初始化加载
        if (state) {
            [self.InstitutionTable clearSellers];
        }
        
        if (action == NTGPulRefreshDown) {
            [self.InstitutionTable.mj_header endRefreshing];
        }
        
    }
    else{//上拉加载
        if (sellers.count == 0) {
            [self.InstitutionTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.InstitutionTable.mj_footer endRefreshing];
        }
    }
    if (state) {
        NSString *pageNumber = [self.reqParam valueForKey:@"pageNumber"];
        pageNumber = [NSString stringWithFormat:@"%d",([pageNumber intValue] + 1) ];
        [self.reqParam setValue:pageNumber forKey:@"pageNumber"];
        [self.InstitutionTable addSellers:sellers];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/** 代理方法 */
-(void)clickindexPathRow:(NTGSeller *)seller index:(int)inde {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AgencyPage" bundle:nil];
    NTGAgencyPageController *agencyPageController = [storyboard instantiateViewControllerWithIdentifier:@"agencyPageController"];
    agencyPageController.seller = seller;
    [self.navigationController pushViewController:agencyPageController animated:YES];
}

/** 处理点按手势 */
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.coverView = recognizer.view;
    for (int i = (int)self.view.subviews.count-1; i>=0; i--) {
        UIView *subView =  self.view.subviews[i];
        if ([subView isKindOfClass:[NTGOrderType class]]) {
            [subView removeFromSuperview];
            self.coverView.hidden = YES;
        }
    }
}

- (void)bindTap:(UIView *)imgVCustom {
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self                                                                                 action:@selector(handleTap:)];
    //使用一根手指双击时，才触发点按手势识别器
    recognizer.numberOfTapsRequired = 1;
    recognizer.numberOfTouchesRequired = 1;
    [imgVCustom addGestureRecognizer:recognizer];
}

/** 更新数据 */
- (void) initData :(NTGPullRefresh)action {
     NSString *appPath = _categoryNav.appPath;
    if ([appPath hasPrefix:@"http://"]) {
        self.navigationItem.title = _categoryNav.name;
        [NTGSendRequest getWrapperInstitutionAttrList:self.reqParam requestAddr:appPath  successBack: ^(NTGProductSellerAttrWrapper *sellerAttrWrapper) {
            NSArray * institution = sellerAttrWrapper.page.content;
            self.attribute = sellerAttrWrapper.attribute;
            if (institution.count == 0) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
                self.InstitutionTable.tableFooterView = view;
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
                label.text = @"抱歉，没有找到符合的商品！";
                label.textAlignment = NSTextAlignmentCenter;
                [view addSubview:label];
            }else {
            [self updateTableView:institution action:action state:YES];
            }
        }];
    }else {
        self.navigationItem.title = [self.reqParam valueForKey:@"_categoryNav_"];
        [NTGSendRequest getWrapperInstitutionAttrList:self.reqParam requestAddr:@"/app/institution/list.jhtml"  successBack: ^(NTGProductSellerAttrWrapper *sellerAttrWrapper) {
            
            NSArray * institution = sellerAttrWrapper.page.content;
            self.attribute = sellerAttrWrapper.attribute;
            if (institution.count == 0) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
                self.InstitutionTable.tableFooterView = view;
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
                label.text = @"抱歉，没有找到符合的机构！";
                label.textAlignment = NSTextAlignmentCenter;
                [view addSubview:label];
            }else {
                [self updateTableView:institution action:action state:YES];
            }
        }];
    }
}

- (IBAction)orderTypeBtn:(id)sender {
    
    self.orderType = [[NTGOrderType alloc]init];
    UIView *orderTypeView = nil;
    
    UIButton *btn = (UIButton *)sender;
    
    NSInteger tag = btn.tag;
    
    if (!self.coverView) {
        self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 190, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-190)];
        self.coverView.backgroundColor = [UIColor blackColor];
        self.coverView.alpha = 0.5;
        [self.view addSubview:self.coverView];
        [self bindTap:self.coverView];
    }
    NSMutableArray *tempArray = [NSMutableArray array];
    
    if(tag == 100) {
        tempArray = _defaultAttrs;
    }else if(tag == 200){
        tempArray = _priceAttrs;
    }
    if (!orderTypeView) {
        orderTypeView =  [self.orderType viewWithRect: CGRectMake(0, 110, self.view.frame.size.width, 80) attrs:tempArray];
    }
    
    orderTypeView.hidden = btn.selected;
    self.coverView.hidden = btn.selected;
    self.orderType.orderTypeDelegate = self;
    [self.view addSubview:orderTypeView];
}

- (void)dataFilter:(NTGAttribute *)attr {
    for (int i = (int)self.view.subviews.count-1; i>=0; i--) {
        UIView *subView =  self.view.subviews[i];
        if ([subView isKindOfClass:[NTGOrderType class]]) {
            [subView removeFromSuperview];
            self.coverView.hidden = YES;
        }
    }
    for (int i = 0 ; i< _defaultAttrs.count; i++) {
        NTGAttribute *aAttr = (NTGAttribute *)_defaultAttrs[i];
        [aAttr changeAllOptionsTag:NO];
    }
    for (int i = 0 ; i< _priceAttrs.count; i++) {
        NTGAttribute *aAttr = (NTGAttribute *)_priceAttrs[i];
        [aAttr changeAllOptionsTag:NO];
    }
    
    [attr changeAllOptionsTag:YES];
    
    if (attr.option.count > 0) {
        NTGAttibuteOption *options = (NTGAttibuteOption *)attr.option[0];
        [self.reqParam setValue:options.value forKey:attr.value];
        [self pageInitData:NTGPulRefreshInit];
    }
}

/** 筛选 按钮 */
- (IBAction)filterBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.filterView = [NTGFilterView viewWithView];
    self.filterView.frame = CGRectMake(80, 0, self.view.frame.size.width-80, self.view.frame.size.height-20);
    self.filterView.attributes = self.attribute;
    self.filterView.delegateFilter = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self.filterView];
    [self.filterView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.filterView.confirmBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.filterView.deleteBtn addTarget:self action:@selector(deleteBtn) forControlEvents:UIControlEventTouchUpInside];
    
    if (!self.coverFilterView) {
        self.coverFilterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, UI_SCREEN_HEIGHT-20)];
        self.coverFilterView.backgroundColor = [UIColor blackColor];
        self.coverFilterView.alpha = 0.5;
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverFilterView];
        [self bindTap:self.coverFilterView];
    }
    self.coverFilterView.hidden = btn.selected;
}

/** 筛选 返回 */
- (void)back {
    [self.filterView removeFromSuperview];
    self.coverFilterView.hidden = YES;
    [self dataFilters:self.filterView.attributes];
}

/** 筛选 确认 */
- (void)confirmBtn {
    [self.attributeView removeFromSuperview];
    NTGFilterCell *cell = [self.filterView.termListTable cellForRowAtIndexPath:self.index];
    cell.value.text = [self getSelectAttibuteOptions];
    [self.filterView.termListTable reloadData];
}

/** 筛选 删除 */
- (void)deleteBtn {
    NSArray *visibleCells = self.filterView.termListTable.visibleCells;
    for (int i=0;i<visibleCells.count;i++) {
        NTGFilterCell *cell = visibleCells[i];
        cell.value.text = @"";
        [self.filterView.termListTable reloadData];
    }
}

-(void)dataFilters:(NSArray *) attrs {
    for (int i = 0 ; i< attrs.count; i++) {
        NTGAttribute *aAttr = (NTGAttribute *)attrs[i];
        NSArray *visibleCells = self.filterView.termListTable.visibleCells;
        NTGFilterCell *cell = visibleCells[i];
        for (int j = 0 ; j< aAttr.option.count; j++) {
            NTGAttibuteOption *attibuteOption = aAttr.option[j];
            if (attibuteOption.tag) {
                if (cell.value.text) {
                    [self.reqParam setObject:attibuteOption.value forKey:cell.attribute.value];
                }
            }
        }
    }
    [self pageInitData:NTGPulRefreshInit];
}

/** 筛选分类选中代理方法 */
-(void)clickFilterViewIndexPathRow:(NTGAttribute *)attribute index:(NSIndexPath *)index {
    self.index = index;
    self.attributeView = [NTGAttributeView viewWithView];
    self.attributeView.frame = CGRectMake(0, 0, self.view.frame.size.width-80, self.view.frame.size.height-20);
    self.attributeView.attibuteOptions = attribute.option;
    self.attributeView.delegateAttribute = self;
    
    self.attributeView.lblTitle.text = attribute.name;
    [self.filterView addSubview:self.attributeView];
    [self.attributeView.backBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.attributeView.confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
}

/** 筛选分类属性选中代理方法 */
- (void)clickAttributeViewIndexPathRow:(NTGAttibuteOption *)attibuteOption index:(NSIndexPath *)index {
    NSArray *visibleCells = self.attributeView.attributeTable.visibleCells;
    NTGAttributeCell *attributeCell = [self.attributeView.attributeTable cellForRowAtIndexPath:index];
    attributeCell.chooseBtn.selected = !attributeCell.chooseBtn.selected;
    for (int i=0;i<visibleCells.count;i++) {
        NTGAttributeCell *otherCell = visibleCells[i];
        if (otherCell != attributeCell) {
            if (otherCell.chooseBtn.selected) {
                otherCell.chooseBtn.selected = !attributeCell.chooseBtn.selected;
                otherCell.attibuteOption.tag = !attributeCell.chooseBtn.selected;
                otherCell.name.textColor = [UIColor blackColor];
            }
        }else {
            attributeCell.attibuteOption.tag = attributeCell.chooseBtn.selected;
            attributeCell.name.textColor = [UIColor orangeColor];
        }
    }
    if (attributeCell.chooseBtn.selected) {
        attributeCell.name.textColor = [UIColor orangeColor];
    }else {
        attributeCell.name.textColor = [UIColor blackColor];
    }
}

- (NSString *)getSelectAttibuteOptions {
    NSString *delStr = @"";
    for (int j = 0; j < self.attributeView.attibuteOptions.count; j++) {
        NTGAttibuteOption *attibuteOption = self.attributeView.attibuteOptions[j];
        if (attibuteOption.tag) {
            delStr = attibuteOption.name;
        }
    }
    return delStr;
}

//按页查询数据
- (void) initDefaultFilter {
    NTGAttribute *defalutAttr = [[NTGAttribute alloc] init];
    defalutAttr.name = @"默认";
    defalutAttr.value = @"orderType";
    
    NSMutableArray *options = [NSMutableArray array];
    NTGAttibuteOption *defalutAttrOption = [[NTGAttibuteOption alloc] init];
    defalutAttrOption.name = @"默认";
    defalutAttrOption.value = @"theDefault";
    [options addObject:defalutAttrOption];
    
    NTGAttibuteOption *sentimentAttrOption = [[NTGAttibuteOption alloc] init];
    sentimentAttrOption.name = @"人气";
    sentimentAttrOption.value = @"sentiment";
    [options addObject:sentimentAttrOption];
    defalutAttr.option = options;
    
    _defaultAttrs = [NSMutableArray array];
    [_defaultAttrs addObject:defalutAttr];
}

- (void) initPriceFilter {
    NTGAttribute *defalutAttr = [[NTGAttribute alloc] init];
    defalutAttr.name = @"价格";
    defalutAttr.value = @"orderType";
    
    NSMutableArray *options = [NSMutableArray array];
    NTGAttibuteOption *defalutAttrOption = [[NTGAttibuteOption alloc] init];
    defalutAttrOption.name = @"价格由高到低";
    defalutAttrOption.value = @"priceDesc";
    [options addObject:defalutAttrOption];
    
    NTGAttibuteOption *sentimentAttrOption = [[NTGAttibuteOption alloc] init];
    sentimentAttrOption.name = @"价格由低到高";
    sentimentAttrOption.value = @"priceAsc";
    [options addObject:sentimentAttrOption];
    defalutAttr.option = options;
    
    _priceAttrs = [NSMutableArray array];
    [_priceAttrs addObject:defalutAttr];
}


@end
