//
//  ViewController.m
//  Todo List
//
//  Created by Donia Ashraf on 4/5/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *priority;
@property (weak, nonatomic) IBOutlet UIImageView *priorityImg;

@end

@implementation ViewController{
    NSArray *allKeys;
    NSDictionary *taskname;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
     taskname=[taskDefault objectForKey:@"name"];

//    allKeys=[NSArray new];
//
//     allKeys=[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]allKeys];
//
//    printf("%i", allKeys.count);
//    for (NSString* key in allKeys) {
/////code get data
//    }
       
    
    self.mytableView.dataSource=self;
    self.mytableView.delegate=self;

}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allKeys.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"todoCell"
                           forIndexPath:indexPath];
    
    [cell.textLabel setText:[taskname objectForKey:@"taskname"]];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


@end
