//
//  TodoViewController.m
//  Todo List
//
//  Created by Donia Ashraf on 4/5/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import "TodoViewController.h"
#import "TaskDetailsViewController.h"
@interface TodoViewController (){
    NSMutableArray *tasksArr;
    NSMutableArray *todoArr;
    NSMutableArray *filterArr;
    BOOL isFiltered;
}



@end
@implementation TodoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    printf("view did load\n");
    // Do any additional setup after loading the view.
    isFiltered=false;
    self.seacrhbar.delegate=self;
   
      [self.tableView reloadData];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length==0) {
        isFiltered=false;
    }else{
        isFiltered=true;
        filterArr=[[NSMutableArray alloc] init];
        for (NSDictionary *dic in todoArr) {
            NSRange namerange=[[dic objectForKey:@"taskname"]rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (namerange.location != NSNotFound) {
                [filterArr addObject:dic];
            }
        }
    }
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{

   [super viewWillAppear:YES];
    printf("view will load\n");

    
    NSUserDefaults *taskUserdefault=[NSUserDefaults standardUserDefaults];
    tasksArr =[[taskUserdefault objectForKey:@"tasks"]mutableCopy ];
    printf("tasksarr count  ");
    printf("%lu",(unsigned long)tasksArr.count);
    todoArr=[NSMutableArray new];
    //todoArr=tasksArr;

//    for (NSUInteger i=0 ;i<tasksArr.count;i++) {
//        NSDictionary *dic=[tasksArr objectAtIndex:i];
//        if ([[dic objectForKey:@"status"] isEqual:@"Todo"]) {
//            [todoArr addObject:dic];
//
//    }
//    }
    for (NSDictionary *dic in tasksArr) {
        if ([[dic objectForKey:@"status"] isEqual:@"Todo"]) {
            [todoArr addObject:dic];

    }
    }
    printf("todosarr count  ");

    printf("%lu",(unsigned long)todoArr.count);
    [self.tableView reloadData];
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isFiltered==true) {
        return filterArr.count;
    }
    return [todoArr count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict;

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"todoCell" forIndexPath:indexPath];
    UILabel *taskName=[cell viewWithTag:1];
    UILabel *priority=[cell viewWithTag:2];
    UIImageView *priortyImg=[cell viewWithTag:3];
 

    if (isFiltered==true) {
        dict=[filterArr objectAtIndex:indexPath.row];
            [taskName setText:[dict objectForKey:@"taskname"]];
              [priority setText:[dict objectForKey:@"priority"]];
              
             
              
              if ([[dict objectForKey:@"priority"] isEqual:@"high"]) {
                      [priortyImg setImage:[UIImage imageNamed:@"high"]];

              }else if ([[dict objectForKey:@"priority"] isEqual:@"low"]) {
                      [priortyImg setImage:[UIImage imageNamed:@"low"]];

              }else if ([[dict objectForKey:@"priority"] isEqual:@"medium"]) {
                      [priortyImg setImage:[UIImage imageNamed:@"medium"]];

              }

    }else{
        dict=[todoArr objectAtIndex:indexPath.row];

    [taskName setText:[dict objectForKey:@"taskname"]];
    [priority setText:[dict objectForKey:@"priority"]];
    
   
    
    if ([[dict objectForKey:@"priority"] isEqual:@"high"]) {
            [priortyImg setImage:[UIImage imageNamed:@"high"]];

    }else if ([[dict objectForKey:@"priority"] isEqual:@"low"]) {
            [priortyImg setImage:[UIImage imageNamed:@"low2"]];

    }else if ([[dict objectForKey:@"priority"] isEqual:@"medium"]) {
            [priortyImg setImage:[UIImage imageNamed:@"medium"]];

    }
    }
     
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskDetailsViewController *taskDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"TaskDetailsViewController"];
    
    [taskDetails setTaskdic:[todoArr objectAtIndex:indexPath.row]];
    [taskDetails setIndex:indexPath.row];
    printf("object select index  ");
    printf("%ld", (long)indexPath.row);
    
    [self.navigationController pushViewController:taskDetails animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 //   [inProgressArr removeObjectAtIndex:indexPath.row];
    [todoArr removeObjectAtIndex:indexPath.row];


    NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
               NSMutableArray *tasksarr =[[taskDefault objectForKey:@"tasks"]mutableCopy];
          
    [tasksarr removeObjectAtIndex:indexPath.row];
    [taskDefault setObject:tasksarr forKey:@"tasks"];
                    [taskDefault synchronize];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
    [self viewWillAppear:YES];
    
}
@end
