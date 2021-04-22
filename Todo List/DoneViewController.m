//
//  DoneViewController.m
//  Todo List
//
//  Created by Donia Ashraf on 4/5/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import "DoneViewController.h"
#import "DoneDetailsViewController.h"
@interface DoneViewController ()

@end

@implementation DoneViewController{
    NSMutableArray *tasksArr;
    NSMutableArray *doneArr;
    NSDictionary   *dict;
    NSMutableArray *highArr;
    NSMutableArray *meduimArr;
    NSMutableArray *lowArr;

       BOOL isSorted;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.doneTable reloadData];

}

- (void)viewWillAppear:(BOOL)animated{
   // [super viewWillAppear:YES];
    isSorted=NO;

      NSUserDefaults *taskUserdefault=[NSUserDefaults standardUserDefaults];
        tasksArr =[[taskUserdefault objectForKey:@"tasks"]mutableCopy ];
        printf("%lu",(unsigned long)tasksArr.count);
        doneArr=[NSMutableArray new];
        highArr=[NSMutableArray new];
        meduimArr=[NSMutableArray new];
        lowArr=[NSMutableArray new];
       
      //inprogress arr
        for (NSUInteger i=0;i<tasksArr.count;i++) {
            NSDictionary *dic=[tasksArr objectAtIndex:i];
            if ([[dic objectForKey:@"status"] isEqual:@"Done"]) {
                [doneArr addObject:dic];

        }
        }
      /// high arr
      for (NSUInteger i=0;i<doneArr.count;i++) {
          NSDictionary *dic=[doneArr objectAtIndex:i];
          if ([[dic objectForKey:@"priority"] isEqual:@"high"]) {
              [highArr addObject:dic];

      }
      }
      ////
      /// meduim arr
      for (NSUInteger i=0  ;i<doneArr.count;i++) {
          NSDictionary *dic=[doneArr objectAtIndex:i];
          if ([[dic objectForKey:@"priority"] isEqual:@"medium"]) {
              [meduimArr addObject:dic];

      }
      }
      ////
      /// meduim arr
         for (NSUInteger i=0  ;i<doneArr.count;i++) {
             NSDictionary *dic=[doneArr objectAtIndex:i];
             if ([[dic objectForKey:@"priority"] isEqual:@"low"]) {
                 [lowArr addObject:dic];

         }
         }
         ///
      
      [self.doneTable reloadData];
       
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(isSorted==YES)
           return 3;
       return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
          case 0:{
              if(isSorted==YES)
              return highArr.count;
              else
                  return doneArr.count;
              break;
          }
          case 1:{
              return meduimArr.count;
              break;
          }
          case 2:{
              return lowArr.count;
              break;
          }
          default:{
              return doneArr.count;
              break;
          }
      }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell=[ tableView dequeueReusableCellWithIdentifier:@"done" forIndexPath:indexPath];
      UILabel *taskName=[cell viewWithTag:1];
         UILabel *priority=[cell viewWithTag:2];
         UIImageView *priortyImg=[cell viewWithTag:3];
      
      if (isSorted==NO) {
          
         dict=[doneArr objectAtIndex:indexPath.row];

         [taskName setText:[dict objectForKey:@"taskname"]];
         [priority setText:[dict objectForKey:@"priority"]];


         if ([[dict objectForKey:@"priority"] isEqual:@"high"]) {
                 [priortyImg setImage:[UIImage imageNamed:@"high"]];

         }else if ([[dict objectForKey:@"priority"] isEqual:@"low"]) {
                 [priortyImg setImage:[UIImage imageNamed:@"low2"]];

         }else if ([[dict objectForKey:@"priority"] isEqual:@"medium"]) {
                 [priortyImg setImage:[UIImage imageNamed:@"medium"]];

         }
      
      }else if(isSorted==YES){
          printf("%lu", (unsigned long)doneArr.count);
          if(indexPath.section==0){
              dict=[highArr objectAtIndex:indexPath.row];
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
                 
          if(indexPath.section==1){
              dict=[meduimArr objectAtIndex:indexPath.row];
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
          if(indexPath.section==2){
              dict=[lowArr objectAtIndex:indexPath.row];
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
      }
      

      return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(isSorted==YES){
           if(section==0)
           return @"High";
           else if (section==1)
               return @"Meduim";
           else if(section==2)
               return @"Low";
       }
       return @"Tasks";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoneDetailsViewController *taskDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"DoneDetailsViewController"];
       [taskDetails setTaskdicdone:[doneArr objectAtIndex:indexPath.row]];

       [taskDetails setIndexdone:indexPath.row];
       [self.navigationController pushViewController:taskDetails animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//   [inProgressArr removeObjectAtIndex:indexPath.row];
  if(isSorted==NO){
   [doneArr removeObjectAtIndex:indexPath.row];
   NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
              NSMutableArray *tasksarr =[[taskDefault objectForKey:@"tasks"]mutableCopy];
         
   [tasksarr removeObjectAtIndex:indexPath.row];
                   [taskDefault setObject:tasksarr forKey:@"tasks"];
                   [taskDefault synchronize];
   [_doneTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
   }else{
       switch (indexPath.section) {
           case 0:
               {
                   [highArr removeObjectAtIndex:indexPath.row];
                      NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
                                 NSMutableArray *tasksarr =[[taskDefault objectForKey:@"tasks"]mutableCopy];
                            
                      [tasksarr removeObjectAtIndex:indexPath.row];
                                      [taskDefault setObject:tasksarr forKey:@"tasks"];
                                      [taskDefault synchronize];
                      [_doneTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
               }
               break;
           case 1:{
               [meduimArr removeObjectAtIndex:indexPath.row];
                  NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
                             NSMutableArray *tasksarr =[[taskDefault objectForKey:@"tasks"]mutableCopy];
                        
                  [tasksarr removeObjectAtIndex:indexPath.row];
                                  [taskDefault setObject:tasksarr forKey:@"tasks"];
                                  [taskDefault synchronize];
                  [_doneTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

               break;
           }
               
           case 2:{
               [lowArr removeObjectAtIndex:indexPath.row];
                  NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
                             NSMutableArray *tasksarr =[[taskDefault objectForKey:@"tasks"]mutableCopy];
                        
                  [tasksarr removeObjectAtIndex:indexPath.row];
                                  [taskDefault setObject:tasksarr forKey:@"tasks"];
                                  [taskDefault synchronize];
                  [_doneTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
               break;
           }
               
           default:
               break;
       }
}
}
- (IBAction)sortAction:(id)sender {
    isSorted=YES;
       [self viewDidLoad];
}


@end
