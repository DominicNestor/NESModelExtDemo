//
//  NESMainViewController.m
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import "NESMainViewController.h"
#import "NESDateHandler.h"
#import "NESDemoModel.h"
#import "NESModelExt.h"

@interface NESMainViewController ()

@property (nonatomic,retain) NSDictionary *fakeData;

@end

@implementation NESMainViewController

+(void)load
{
    [NESModelFormat setModelPrefix:@"NES"];
}

-(NSDictionary *)fakeData
{
    return @{@"name":@"jack",
             @"id":@"123",
             @"code":@"4567890-",
             @"other":@{@"attr1":@"value1",@"attr2":@"150",@"attr3":@"0.8"},
             @"test":@"3",
             @"d":@"4.5",
             @"l":@"3456789",
             @"f":@"123.123",
             @"b":@"1",
             @"date1":@"13567890456",
             @"date2":@"2015-4-3 11:18:24",
             @"arr":@[
                        @{@"attr1":@"value1",@"attr2":@"150",@"attr3":@"0.8"},
                        @{@"attr1":@"value1",@"attr2":@"150",@"attr3":@"0.8"}],
             @"path":@{
                     @"third":@{@"name":@"rose",@"age":@"123"},
                     @"3rd":@{@"name":@"rose",@"age":@"123"},
                     @"sub":@{
                             @"fourth":@{@"name":@"rose",@"age":@"123"},
                             @"4th":@{@"name":@"rose",@"age":@"123"}}
                     }
             };
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NESBaseModelDemo";
    
    NESDemoModel *model = [NESDemoModel mappingWithObject:self.fakeData];
    
    NSLog(@"%s-[%s]:%@",__func__,__TIME__,model._path_sub_4th.name);
    
    NSLog(@"%s-[%s]:%@",__func__,__TIME__,model.jsonString);
    
    NSLog(@"%s-[%s]:%@",__func__,__TIME__,model.foundationModel);
    
    NSArray *arr = [NESDemoModel mappingWithObject:@[self.fakeData,self.fakeData,self.fakeData,self.fakeData]];
    NSLog(@"%s-[%s]:%@",__func__,__TIME__,arr.foundationModel);
    
    
    // Do any additional setup after loading the view.
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

@end
