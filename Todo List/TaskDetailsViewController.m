//
//  TaskDetailsViewController.m
//  Todo List
//
//  Created by Donia Ashraf on 4/5/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import "TaskDetailsViewController.h"

@interface TaskDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDesc;
@property (weak, nonatomic) IBOutlet UILabel *priority;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminder;

@property (weak, nonatomic) IBOutlet UILabel *dateOfCreation;
@property (weak, nonatomic) IBOutlet UIButton *inProgress;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UIButton *highPriority;
@property (weak, nonatomic) IBOutlet UIButton *meduimPriority;
@property (weak, nonatomic) IBOutlet UIButton *lowPriority;

@property (weak, nonatomic) IBOutlet UIButton *savebtn;
@property (nonatomic) NSString *getPriority;
@property (nonatomic) NSString *getStatus;

@end
BOOL isGrantNotificationAccess2;
@implementation TaskDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _taskName.enabled=NO;
    _taskDesc.enabled=NO;
    _reminder.enabled=NO;
    _inProgress.enabled=NO;
    _done.enabled=NO;
    _highPriority.enabled=NO;
    _lowPriority.enabled=NO;
    _meduimPriority.enabled=NO;
    _savebtn.enabled=NO;
    
    [_taskName setText:[_taskdic objectForKey:@"taskname"]];
    [_taskDesc setText:[_taskdic objectForKey:@"Desc"]];
    [_priority setText:[_taskdic objectForKey:@"priority"]];

    _getPriority=[_taskdic objectForKey:@"priority"];
    _getStatus=[_taskdic objectForKey:@"status"];

    self.reminder.datePickerMode=UIDatePickerModeTime;

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
       [formatter setDateFormat:@"hh:mm a"];
    NSDate *date=[formatter dateFromString:[_taskdic objectForKey:@"reminder"]];
     [_reminder setDate:date];
    [_dateOfCreation setText:[_taskdic objectForKey:@"current"]];
    
    //Notification
          isGrantNotificationAccess2=false;
          UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
          UNAuthorizationOptions options = UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
          [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
              isGrantNotificationAccess2=granted;
              
          }];
    

}
-(void)setNotfication :(NSString*)taskname{
    if (isGrantNotificationAccess2) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc]init];
        content.title=taskname;
      //  content.subtitle=@"subtitle";
        content.body=[[@"Time of doing the  " stringByAppendingFormat:taskname]stringByAppendingFormat:@"is now"];
        content.sound=[UNNotificationSound defaultSound];
    
        
        
//        UNTimeIntervalNotificationTrigger *trigger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
        
        NSDate *date=self.reminder.date;

        NSDateComponents *dateCom=[[NSCalendar currentCalendar]components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date] ;
    
        
        UNCalendarNotificationTrigger *trigger=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateCom repeats:NO];
        //settingRequest for notification
        UNNotificationRequest *request=[UNNotificationRequest requestWithIdentifier:taskname content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
        
    }
}
- (IBAction)getPriority:(id)sender {
    UIButton *btn=(UIButton*)sender;
       if (btn.tag==1) {
           printf("high");
           _getPriority=@"high";
       }if (btn.tag==2) {
           printf("medium");
           _getPriority=@"medium";

       }if (btn.tag==3) {
           printf("low\n");
           _getPriority=@"low";

       }
}
- (IBAction)getStatus:(id)sender {
    UIButton *btn=(UIButton*)sender;
         if (btn.tag==1) {
             printf("InProgress");
             _getStatus=@"InProgress";
         }if (btn.tag==2) {
             printf("Done");
             _getStatus=@"Done";

         }
}

- (IBAction)editTask:(id)sender {
    _taskName.enabled=YES;
    _taskDesc.enabled=YES;
    _reminder.enabled=YES;
    _inProgress.enabled=YES;
    _done.enabled=YES;
    _highPriority.enabled=YES;
    _lowPriority.enabled=YES;
    _meduimPriority.enabled=YES;
    _savebtn.enabled=YES;

    
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSArray *arr=[NSArray arrayWithObjects:[_taskName text],nil];
    [center removePendingNotificationRequestsWithIdentifiers:arr];

    
}
-(NSString*)getTimeChanged{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *selectedTime=[formatter stringFromDate:self.reminder.date];
    printf("\n");

    NSLog(@"%@",selectedTime);
    return selectedTime;
}
-(NSString*)getCurrentTime{
    NSDate *current=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *dateString=[dateFormatter stringFromDate:current];
    NSLog(@"%@",dateString);

    return dateString;
    
}

- (IBAction)doneTask:(id)sender {
      if(![[_taskName text ] isEqual:@""]){
    NSString *taskName=[_taskName text];
    NSString *taskDesc=[_taskDesc text];
    NSString *timechosen=[self getTimeChanged];
    NSString *currentTime=[NSString stringWithFormat:@"%@",[self getCurrentTime]];
    NSDictionary *dict = @{       @"taskname":taskName,
                                  @"Desc":taskDesc,
                                  @"priority":_getPriority,
                                  @"reminder":timechosen,
                                  @"current":currentTime,
                                  @"status":_getStatus
           };
       

            NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
            NSMutableArray *tasksarr =[[taskDefault objectForKey:@"tasks"]mutableCopy];
          [tasksarr replaceObjectAtIndex:_index withObject:dict];
          printf("details\n");
          printf("index");
          printf("%ld", (long)_index);

          printf("\n");
          printf("%lu",(unsigned long)tasksarr.count);


                 [taskDefault setObject:tasksarr forKey:@"tasks"];
          
    //      printf(tasksarr.count);
                 [taskDefault synchronize];

          //notification
          [self setNotfication:taskName];

           // pup
          [self.navigationController popViewControllerAnimated:YES];
          
      }else{
          
      }
    
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
