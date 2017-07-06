/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */


#import "NTGShoppingCartController.h"
#import "NTGShoppingCartCell.h"
#import "NTGSendRequest.h"
#import "NTGCart.h"
#import "NTGCartView.h"
#import "EQPageCycleSize.h"
#import "NTGCartItem.h"
#import "NTGProductDetailController.h"
#import "NTGLoginController.h"
#import "NTGOrderInfoController.h"

/**
 * control - 购物车
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGShoppingCartController ()<UITableViewDataSource,NTGShopCartOperateDelegate,NTGCartViewOperateDeleagate, UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *allSelect;
/** 购物车商品列表 */
@property (weak, nonatomic) IBOutlet UITableView *shopTable;
/** 全选 */
@property (weak, nonatomic) IBOutlet UIButton *selectAll;
/** 编辑 */
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
/** 删除 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 返回按钮 */
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic,strong) NTGCartView *cartView;
@property (nonatomic,strong) NSArray *cartItems;
@property (nonatomic,strong) NSMutableArray *productIds;
@end

@implementation NTGShoppingCartController

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setCartItems:(NSArray *)cartItems {
    _cartItems = cartItems;
    [self.shopTable reloadData];
    //处理选中
    [self processAllSelect];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//    
//    statusBarView.backgroundColor=[UIColor blackColor];
//    
//    [self.view addSubview:statusBarView];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.shopTable.dataSource = self;
    self.shopTable.delegate = self;
    [self addCartView];
    [self.view bringSubviewToFront:self.cartView];
    self.cartView.lblCol.hidden = YES;
    //[self initDataList];
    self.shopTable.separatorColor = [UIColor lightGrayColor];
    self.shopTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.selectAll setSelected:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

/** 添加购物车视图 */
- (void)addCartView {
    self.cartView = [NTGCartView viewWithView];
    self.cartView.delegateShop = self;
    self.cartView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    [self.view addSubview:self.cartView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.backBtn.hidden = !self.hidesBottomBarWhenPushed;
    [self initDataList];
}


/** 添加购物车列表 */
- (void)initDataList {
    [NTGSendRequest getCartList:nil success:^(NTGCart *cart) {
        self.cartItems = cart.cartItems;
        if ([self.deleteBtn.titleLabel.text isEqualToString:@"去结算"]) {
            //所有商品总价
            float allPrice = 0;
            for (int i=0; i<self.cartItems.count; i++) {
                NTGCartItem *cartItem = self.cartItems[i];
                cartItem.flag = YES;
                float subtotal = 0;
                if (cartItem.flag) {
                    subtotal = [cartItem.subtotal floatValue];
                }
                allPrice = allPrice +subtotal;
            }
            self.selectAll.selected = YES;
            self.deleteBtn.backgroundColor = [UIColor orangeColor];
            self.deleteBtn.enabled = YES;
            //赋值总价
            self.lblPrice.text = [NSString stringWithFormat:@"￥%.2f(不含运费)",allPrice];
        }
        //判断用户登录(稍后处理)
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [userDefaults valueForKey:@"isLogin"];
        if([isLogin isEqualToString:@"0"]) {
            self.cartView.lblCol.hidden = YES;
            self.cartView.lblCollect.hidden = NO;
//            UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//            
//            statusBarView.backgroundColor=[UIColor blackColor];
//            
//            [self.cartView addSubview:statusBarView];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
            self.cartView.lblDes.text = @"您购物车内没有任何商品，是否立即登录？";
            [self.view bringSubviewToFront:self.cartView];
        }else if ([isLogin isEqualToString:@"1"]){
            if (self.cartItems != nil && self.cartItems.count > 0) {
//                self.cartView.lblCollect.hidden = YES;
//                self.cartView.lblCol.hidden = NO;
                [self.view sendSubviewToBack:self.cartView];
            }else {
                self.cartView.lblCollect.hidden = YES;
                self.cartView.lblCol.hidden = NO;
                
//                UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//                statusBarView.backgroundColor=[UIColor blackColor];
//                [self.cartView addSubview:statusBarView];
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
                self.cartView.lblDes.text = @"您购物车内没有任何商品，快去装满它！";
                [self.view bringSubviewToFront:self.cartView];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cartItems.count;
}

- (NTGShoppingCartCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.cartItem = self.cartItems[indexPath.row];
    cell.delegateShop = self;
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductDetail" bundle:nil];
    NTGProductDetailController *productDetailController = [storyboard instantiateInitialViewController];
    NTGCartItem *carItem = self.cartItems[indexPath.row];
    productDetailController.product = carItem.product;
    productDetailController.count = carItem.quantity;
    [self.navigationController pushViewController:productDetailController animated:YES];
}

/** 点击加号减号编辑购物车商品数量 */
- (void)plusminis:(UIButton *)btn label:(UILabel *)label cartItem:(NTGCartItem *)cartItem {
    if (btn.tag == 100) {
        NSDictionary *dict = @{
                               @"cartItemId":cartItem.id,
                               @"quantity":[NSString stringWithFormat:@"%d",(cartItem.quantity - 1)]
                               };
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess = ^(NTGCart *cart) {
            [self replaceCartItems:cart.cartItems];
        };
        [NTGSendRequest getEditCart:dict success:result];
    }
    
    if (btn.tag == 200) {
        NSDictionary *dict = @{
                               @"cartItemId":cartItem.id,
                               @"quantity":[NSString stringWithFormat:@"%d",(cartItem.quantity +1)]
                               };
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess = ^(NTGCart *cart) {
            [self replaceCartItems:cart.cartItems];
        };
        [NTGSendRequest getEditCart:dict success:result];
    }
}

/** CELL的选中按钮事件 */
- (void)selectProductId:(long)productId flag:(BOOL)flag {
    //    [self updateCart:productId flag:flag];
    for (int i = 0; i < self.cartItems.count; i++) {
        NTGCartItem *cartItem = self.cartItems[i];
        NTGProductContent *product = cartItem.product;
        if (product.id == productId) {
            cartItem.flag = flag;
        }
    }
    [self setCartItems:self.cartItems];
}

/** 全选按钮 */
- (IBAction)selectBtn:(id)sender {
    self.selectAll.selected = !self.selectAll.selected;
    [self updateCartWithFlag:self.selectAll.selected];
}

/** 编辑按钮 */
- (IBAction)editBtn:(id)sender {
    [self updateCartWithFlag:self.editBtn.selected];
    self.editBtn.selected = !self.editBtn.selected;
    if (self.editBtn.selected) {
        self.lblPrice.text = [NSString stringWithFormat:@""];
        self.allSelect.text = @"全选";
        [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setBackgroundColor:[UIColor orangeColor]];
        self.editBtn.selected = YES;
    }else {
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.deleteBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [self.deleteBtn setImage:nil forState:UIControlStateNormal];
        self.deleteBtn.backgroundColor = [UIColor orangeColor];
        self.editBtn.selected = NO;
    }
}

/** 获取购物车中选中的购物车项目的ID */
- (NSString *)getAllSelectCartItemIds {
    NSString *delStr = @"";
    for (int j = 0; j < self.cartItems.count; j++) {
        NTGCartItem *newCartItem = self.cartItems[j];
        if (newCartItem.flag) {
            //NSString* cid =[NSString stringWithFormat:@"%ld", newCartItem.id];
            delStr = [delStr stringByAppendingString:newCartItem.id];
            delStr = [delStr stringByAppendingString:@","];
        }
    }
    return delStr;
}

/** 获取购物车中选中的购物车产品的ID */
- (NSString *) getAllSelectProductIds {
    NSString *delStr = @"";
    self.productIds = [NSMutableArray array];
    for (int j = 0; j < self.cartItems.count; j++) {
        NTGCartItem *newCartItem = self.cartItems[j];
        if (newCartItem.flag) {
            delStr = [delStr stringByAppendingString:[NSString stringWithFormat:@"%ld", newCartItem.product.id]];
            [self.productIds addObject:delStr];
            delStr = [delStr stringByAppendingString:@","];
        }
    }
    return delStr;
}

/** 删除按钮 */
- (IBAction)deleteBtn:(id)sender {
    //去删除
    if(self.editBtn.selected) {
        NSString *mess = @"您确认要从购物车中删除选中的商品吗？";
        UIAlertView *genderPicker = [[UIAlertView alloc]initWithTitle:@"提示" message:mess delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
        [genderPicker show];
        
        
    }else { //提交订单
        NSString * selectProductIds = [self getAllSelectProductIds];
        if (selectProductIds.length < 1) {
            return;
        }
        //判断用户登录(稍后处理)
        NSDictionary *param = @{
                                @"ids" : selectProductIds
                                };
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [userDefaults valueForKey:@"isLogin"];
        //        BOOL islogin  = YES;
        if([isLogin isEqualToString:@"0"]) {
        
            [self popToLogin];
        }else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGOrderInfo" bundle:nil];
            NTGOrderInfoController *cartInfoController = [storyboard instantiateInitialViewController];
            cartInfoController.dict = param;
            cartInfoController.ids = self.productIds;
            [self.navigationController pushViewController:cartInfoController animated:YES];
        }
    }
}

/** 弹框 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString * selectCartItemids = [self getAllSelectCartItemIds];
        if (selectCartItemids.length < 1) {
            //提示使用户没有选中购物车中的商品
            return;
        }
        NSDictionary *param = @{
                                @"cartItemIds":selectCartItemids
                                };
        [NTGSendRequest getDeleteCart:param success:^(NTGCart *cart) {
            [self initDataList];
        }];
    }
}

/** 记录购物车商品的选中状态 */
-(void)updateCartWithFlag:(BOOL)flag {
    for (int j = 0; j < self.cartItems.count; j++) {
        NTGCartItem *newCartItem = self.cartItems[j];
        newCartItem.flag =  flag ;
    }
    [self setCartItems:self.cartItems];
}

/** 更新新购物车中商品的选中状态 */
- (void)replaceCartItems:(NSArray *)newCartItems {
    NSMutableArray *sortCartItems = [NSMutableArray array];
    //更新新购物车项的选中FLAG(排序)
    for (int i = 0; i < self.cartItems.count; i++) {
        NTGCartItem *cartItem = self.cartItems[i];
        NTGProductContent *product = cartItem.product;
        long productId = product.id;
        for (int j = 0; j < newCartItems.count; j++) {
            NTGCartItem *newCartItem = newCartItems[j];
            NTGProductContent *newProduct = newCartItem.product;
            long newProductId = newProduct.id;
            if (newProductId == productId) {
                newCartItem.flag = cartItem.flag;
                [sortCartItems addObject:newCartItem];
            }
        }
    }
    
    //可能在其他地方又向购物车种添加或者删除过商品
    for (int j = 0; j < newCartItems.count; j++) {
        NTGCartItem *newCartItem = newCartItems[j];
        NTGProductContent *newProduct = newCartItem.product;
        long newProductId = newProduct.id;
        BOOL isExsitCartItem = NO;
        for (int i = 0; i < self.cartItems.count; i++) {
            NTGCartItem *cartItem = self.cartItems[i];
            NTGProductContent *product = cartItem.product;
            long productId = product.id;
            if (newProductId == productId) {
                isExsitCartItem = YES;
            }
        }
        if (!isExsitCartItem) {
            [sortCartItems addObject:newCartItem];
        }
    }
    [self setCartItems:sortCartItems];
}

/** 处理全部选中 或者 全部取消选中 */
-(void) processAllSelect {
    //所有单元格都被选中
    BOOL allSelect = YES;
    //没有元素单元格被选中
    BOOL hasAtLeastOneSelect = NO;
    //所有商品总价
    float allPrice = 0;
    for (int i = 0; i < self.cartItems.count; i++) {
        NTGCartItem *cartItem = self.cartItems[i];
        allSelect = allSelect && cartItem.flag;
        hasAtLeastOneSelect = hasAtLeastOneSelect || cartItem.flag;
        //如果购物车中有选中的商品，并且当前按钮是不可用状态，则将按钮变成可用
        if (!self.deleteBtn.enabled && cartItem.flag) {
            self.deleteBtn.backgroundColor = [UIColor orangeColor];
            self.deleteBtn.enabled = YES;
        }
        
        //计算购物车中选中商品总价
        float subtotal = 0;
        if (cartItem.flag) {
            subtotal = [cartItem.subtotal floatValue];
        }
        allPrice = allPrice +subtotal;
        
    }
    //控制全选图标的状态
    self.selectAll.selected = allSelect;
    
    //控制去结算按钮是否可用
    if (!hasAtLeastOneSelect) {
        self.deleteBtn.backgroundColor = [UIColor lightGrayColor];
        self.deleteBtn.enabled = NO;
    }
    //赋值总价
    self.lblPrice.text = [NSString stringWithFormat:@"%.2f(不含运费)",allPrice];
    
}

- (void)popToLogin{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGLogin" bundle:nil];
    NTGLoginController *loginController = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:loginController animated:YES];
    
}

-(void)popToRootTableBar {
    UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSArray *childControllers = [tabbarController childViewControllers];
    tabbarController.selectedViewController = childControllers[0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
