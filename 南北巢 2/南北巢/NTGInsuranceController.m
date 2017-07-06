/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInsuranceController.h"
#import "NTGInsuranceTableView.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGProductSellerAttrWrapper.h"
#import "NTGMBProgressHUD.h"
#import <MJRefresh.h>
#import "NTGConstant.h"
#import "NTGAttibuteOption.h"
#import "NTGAttribute.h"
#import "NTGOrderType.h"
#import "EQPageCycleSize.h"
#import "NTGGestureRecognizer.h"
#import "NTGInsuranceDetailController.h"
#import "NTGFilterView.h"
#import "NTGAttributeView.h"
#import "NTGFilterCell.h"
#import "NTGAttributeCell.h"

/**
 * control - 养老保险
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInsuranceController ()<InsuranceTableViewDelegate,NTGOrderTypeDelegate,FilterViewDelegate,AttributeViewDelegate>

/** 列表 */
@property (weak, nonatomic) IBOutlet NTGInsuranceTableView *insuranceTable;

@property (nonatomic,strong) NSMutableArray *defaultAttrs;
@property (nonatomic,strong) NSMutableArray *priceAttrs;
@property (nonatomic,strong) NTGOrderType *orderType;
@property (nonatomic,strong) UIView *coverView;
@property (strong, nonatomic) NTGGestureRecognizer *customGestureRecognizer;
@property (nonatomic,strong) NSArray *attribute;
@property (nonatomic,strong) UIView *coverFilterView;
@property (nonatomic,strong) NTGFilterView *filterView;
@property (nonatomic,strong) NTGAttributeView *attributeView;
@property (nonatomic,strong) NSIndexPath *index;
@end

@implementation NTGInsuranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_reqParam ||![_reqParam isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *tempReqParam = [NSMutableDictionary dictionary];
        [tempReqParam addEntriesFromDictionary:_reqParam];
        _reqParam = tempReqParam;
    }
//    self.reqParam = [NSMutableDictionary dictionary];
    [self.reqParam setValue:@"1" forKey:@"pageNumber"];
    [self.reqParam setValue:@"10" forKey:@"pageSize"];
    self.insuranceTable.delegateIns = self;
    [self initData];
    [self initDefaultFilter];
    [self initPriceFilter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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


- (void) pageInitData :(NTGPullRefresh)action {
    if (action == NTGPulRefreshInit || action == NTGPulRefreshDown) {
        [self.reqParam setObject:@"1" forKey:@"pageNumber"];
    }
    [self initData:action];
}

/** 更新数据 */
- (void)initData {
    
    // 下拉刷新
    self.insuranceTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self pageInitData:NTGPulRefreshDown];
    }];
    
    // 上拉刷新
    self.insuranceTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshUp];
    }];
    
    [self pageInitData:NTGPulRefreshInit];
}

- (void) updateTableView:(NSArray *)sellers action:(NTGPullRefresh)action state:(BOOL) state {
    if (action == NTGPulRefreshDown || action == NTGPulRefreshInit) {//表示是下拉刷新
        if (state) {
            [self.insuranceTable clearSellers];
        }
        if (action == NTGPulRefreshDown) {
            [self.insuranceTable.mj_header endRefreshing];
        }
    }else {//上拉加载
        if (sellers.count == 0) {
            [self.insuranceTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.insuranceTable.mj_footer endRefreshing];
        }
    }
    if (state) {
        NSString *pageNumber = [self.reqParam valueForKey:@"pageNumber"];
        pageNumber = [NSString stringWithFormat:@"%d",([pageNumber intValue] + 1) ];
        [self.reqParam setValue:pageNumber forKey:@"pageNumber"];
        [self.insuranceTable addSellers:sellers];
    }
}

/** 请求数据 */
- (void)initData:(NTGPullRefresh)action {
    if (_categoryNav.name) {
        self.navigationItem.title = _categoryNav.name;
    }else {
        self.navigationItem.title = [self.reqParam valueForKey:@"_categoryNav_"];
    }
    
    NSString *appPath = _categoryNav.appPath;
    [self.reqParam setValue:@"19" forKey:@"id"];
    if ([appPath hasPrefix:@"http://"]) {
        [NTGSendRequest getInsurance:self.reqParam requestAddr:appPath success:^(NTGProductSellerAttrWrapper *productWrapper) {
            NTGPage *pgModel = productWrapper.page;
            self.attribute = productWrapper.attribute;
            if (pgModel.content.count == 0) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
                self.insuranceTable.tableFooterView = view;
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
                label.text = @"抱歉，没有找到合适的产品！";
                label.textAlignment = NSTextAlignmentCenter;
                [view addSubview:label];
            }else {
            [self updateTableView:pgModel.content action:action state:YES];
            }
        }];
    }else {

        [NTGSendRequest getInsurance:self.reqParam requestAddr:@"app/insurance/list.jhtml" success:^(NTGProductSellerAttrWrapper *productWrapper) {
            NTGPage *pgModel = productWrapper.page;
            self.attribute = productWrapper.attribute;
            if (pgModel.content.count == 0) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
                self.insuranceTable.tableFooterView = view;
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
                label.text = @"抱歉，没有找到合适的产品！";
                label.textAlignment = NSTextAlignmentCenter;
                [view addSubview:label];
            }else {
                [self updateTableView:pgModel.content action:action state:YES];
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
    if (tag == 100) {
        orderTypeView =  [self.orderType viewWithRect: CGRectMake(0, 110, self.view.frame.size.width, 80) attrs:_defaultAttrs];
    }else if(tag == 200) {
        orderTypeView =  [self.orderType viewWithRect: CGRectMake(0, 110, self.view.frame.size.width, 80) attrs:_priceAttrs];
    }
    orderTypeView.hidden = btn.selected;
    self.coverView.hidden = btn.selected;
    self.orderType.orderTypeDelegate = self;
    [self.view addSubview:orderTypeView];
}

/** 筛选 */
- (IBAction)filterBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.filterView = [NTGFilterView viewWithView];
    self.filterView.frame = CGRectMake(80, 20, self.view.frame.size.width-80, self.view.frame.size.height-20);
    self.filterView.attributes = self.attribute;
    self.filterView.delegateFilter = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self.filterView];
    [self.filterView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.filterView.confirmBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.filterView.deleteBtn addTarget:self action:@selector(deleteBtn) forControlEvents:UIControlEventTouchUpInside];
    
    if (!self.coverFilterView) {
        self.coverFilterView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 80, UI_SCREEN_HEIGHT-20)];
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

/** 选中代理方法 */
-(void)clickindexPathRow:(NTGInsuranceContent *)insuranceContent index:(int)index {
//    [NTGMBProgressHUD alertView:@"敬请期待!" view:self.view];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGInsuranceDetail" bundle:nil];
    NTGInsuranceDetailController *insuranceDetailController = [storyboard instantiateInitialViewController];
    insuranceDetailController.insuranceId = insuranceContent.id;
    [self.navigationController pushViewController:insuranceDetailController animated:YES];
}

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
    sentimentAttrOption.name = @"销量";
    sentimentAttrOption.value = @"salesDesc";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
