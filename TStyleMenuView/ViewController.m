//
//  ViewController.m
//  TStyleMenuView
//
//  Created by Sen on 15/6/17.
//  Copyright (c) 2015年 Sen. All rights reserved.
//

#import "ViewController.h"

#import "LSSelectMenuView.h"

@interface ViewController ()
<LSSelectMenuViewDelegate,LSSelectMenuViewDataSource,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController
{
    LSSelectMenuView* menuView;
    NSArray* menuInfo;
    
    UITableView* mytableview;
    
    
    
    UILabel *label;
    UILabel *numlabel;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    self.hotCityArray = [NSArray arrayWithObjects:@"北京",@"上海",@"广州",@"深圳",@"成都",@"西安",@"杭州",@"武汉",@"重庆",@"天津",@"哈尔滨",@"昆明",@"郑州",nil];
    
    
    
    
    
    
    
    self.title = @"T型展开菜单";
    
    //
//    mytableview = [[UITableView alloc] initWithFrame:self.view.bounds];
//    mytableview.delegate = self;
//    mytableview.dataSource = self;
//    [self.view addSubview:mytableview];
//    mytableview.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);

    //
    menuInfo = @[@"附近",@"设备",@"综合排序",@"筛选"];
    
    menuView = [[LSSelectMenuView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    menuView.backgroundColor = [UIColor colorWithRed:0.973 green:0.973 blue:0.973 alpha:1];
    menuView.delegate = self;
    menuView.dataSource = self;
    [self.view addSubview:menuView];
    
    UIView* showView = [[UIView alloc] initWithFrame:CGRectMake(0, menuView.frame.origin.y+menuView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-64-44)];
    showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];
    [self.view addSubview:showView];
    
    menuView.showView = showView;
    
   
    
}

- (UIColor *)randomColor {
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        (time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark - LSSelectMenuViewDataSource

- (NSInteger)numberOfItemsInMenuView:(LSSelectMenuView *)menuview{
    return menuInfo.count;
}
- (NSString*)menuView:(LSSelectMenuView *)menuview titleForItemAtIndex:(NSInteger)index{
    return menuInfo[index];
}
- (CGFloat)menuView:(LSSelectMenuView *)menuview heightForCurrViewAtIndex:(NSInteger)index{
    return self.view.bounds.size.height - 44 - 64 - 49;
}

// 处理每个标题对应的视图View
- (UIView*)menuView:(LSSelectMenuView *)menuview currViewAtIndex:(NSInteger)index{
//    UIView* vv = [[UIView alloc] initWithFrame:CGRectZero];
    
//    vv.backgroundColor = [self randomColor];
    
    // 处理tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height ) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
//    [self.view addSubview:tableView];
    
    return tableView;
}
#pragma mark - LSSelectMenuViewDelegate

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didSelectAtIndex:(NSInteger)index{
    NSLog(@"show row = %ld",(long)index);
    
}

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didRemoveAtIndex:(NSInteger)index{
    NSLog(@"remove row = %ld",(long)index);
}

#pragma mark - UITableDataSource &&UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 44;
            break;
        default:
            break;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 1:
            return @"附近";
            break;
        case 2:
            return @"目的地";
            break;
        case 3:
            return @"热门城市";
            break;
        default:
            break;
    }
  
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 100;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 40;
            break;
        case 3:
            return 200;
            break;
        default:
            break;
    }
    return 100;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"testCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
//    解决单元格重用
    [[cell  viewWithTag:100] removeFromSuperview];
    [[cell viewWithTag:101] removeFromSuperview];
    
    if (indexPath.section==0)
    {
        
        NSArray *array = [NSArray arrayWithObjects:@"20",@"50",@"100",@"150",@"250",@"350",@"500", nil];
        // 上方label
        NSMutableAttributedString *topStr = [[NSMutableAttributedString alloc] initWithString:@"查看20公里内充电点"];
        NSRange  range = [[topStr string] rangeOfString:@"20公里"];
        [topStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
      
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
        label.tag = 101;
        //    label.backgroundColor = [UIColor grayColor];
        [label setAttributedText:topStr];
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
//        滑动条
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 34, 300, 20)];
        slider.minimumValue = 0.0;
        slider.maximumValue = 60.0;
        //    slider.continuous = NO;
        //    slider.backgroundColor = [UIColor redColor];
        
        //    [slider setValue:0 animated:YES];
        
        //    slider.backgroundColor = [UIColor redColor];
        [slider  addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
        slider.tag = 100;
        [cell addSubview:slider];
//        下方label
        NSLog(@"array.count==%lu",(unsigned long)array.count);
        for (int i = 0; i < array.count; ++i) {
            
            numlabel = [[UILabel alloc] initWithFrame:CGRectMake(10+ i*(307/array.count), 64, 300/array.count, 20)];
            
            //        numlabel.backgroundColor = [UIColor colorWithRed:(arc4random()%255/255.0) green:(arc4random()%200/255.0 + 0.5)  blue:(arc4random()%150/255.0+ 0.2)  alpha:1];
            numlabel.textAlignment = NSTextAlignmentCenter;
            numlabel.tag = i + 10;
            numlabel.text = array[i];
            numlabel.tintColor = [UIColor lightGrayColor];
            numlabel.font = [UIFont systemFontOfSize:15];
            numlabel.textColor = [UIColor lightGrayColor];
           
            [cell addSubview:numlabel];
            
        }
        

        
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"广州市珠海区江海街道江贝安定里";
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else if (indexPath.section == 2)
    {
        
    }else if (indexPath.section == 3)
    {
        
        for (int i = 0; i<self.hotCityArray.count; i ++) {
            
            UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeSystem];
            cityButton.frame = CGRectMake(16+(60+16)*(i%4), 0 + (10+40)*(i/4), 60, 40);
//            cityButton.backgroundColor = [UIColor redColor];
             NSLog(@"self,hotCityArray==%lu",(unsigned long)self.hotCityArray.count);
            [cityButton setTitle:[self.hotCityArray objectAtIndex:i] forState:UIControlStateNormal];
            cityButton.tintColor = [UIColor lightGrayColor];
            [cell addSubview:cityButton];
            
            
        }
        
     
        
    }
    
    
    
    
    return cell;
}
- (void)updateValue:(id)sender
{
    
    UISlider *slider = (UISlider*)sender;
    NSLog(@"---%f",slider.value);
    
    //    slider.value = numlabel.center.x;
      int i = slider.value/10;
    int num = slider.value/10;
    switch (i) {
        case 0:
        {
            i = 20;
            num = 0;
        }
            break;
        case 1:
        {
            i = 50;
            num = 10;
        }
            
            break;
        case 2:
        {
            i = 100;
            num = 20;
            
        }
            
            break;
        case 3:
        {
            i = 150;
            num = 30;
            
        }break;
        case 4:
        {
            i = 250;
            num =  40;
        }
            break;
        case 5:
        {
            i = 350;
            num = 50;
            
        }
            break;
        case 6:
        {
            i = 500;
            num =  60;
            
        }
            break;
        default:
            break;
    }
    
    [slider setValue:num animated:YES];
    NSLog(@"endLocation==%f",slider.value);
    
    NSMutableAttributedString *topStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"查看%d公里内充电点",i]];
    NSRange  range = [[topStr string] rangeOfString:[NSString stringWithFormat:@"%d公里",i]];
    [topStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    [label setAttributedText:topStr];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
