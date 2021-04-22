//
//  InProgressDetailsViewController.m
//  Todo List
//
//  Created by Donia Ashraf on 4/7/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import "InProgressDetailsViewController.h"

@interface InProgressDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UIButton *lowbtn;
@property (weak, nonatomic) IBOutlet UITextField *taskDesc;
@property (weak, nonatomic) IBOutlet UIButton *mediumBtn;
@property (weak, nonatomic) IBOutlet UIButton *highBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminder;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UILabel *priority;
@property (weak, nonatomic) IBOutlet UILabel *dateOfCeation;

@property (nonatomic) NSString *getPriority;
@property (nonatomic) NSString *getStatus;

@end
BOOL isGrantNotificationAccess3;
@implementation InProgressDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      _taskName.enabled=NO;
      _taskDesc.enabled=NO;
      _reminder.enabled=NO;
      _doneBtn.enabled=NO;
      _highBtn.enabled=NO;
      _lowbtn.enabled=NO;
      _mediumBtn.enabled=NO;
      _saveBtn.enabled=NO;
      
      [_taskName setText:[ _taskdicInprogress objectForKey:@"taskname"]];
      [_taskDesc setText:[_taskdicInprogress objectForKey:@"Desc"]];
      [_priority setText:[_taskdicInprogress objectForKey:@"priority"]];

      _getPriority=[_taskdicInprogress objectForKey:@"priority"];
      _getStatus=[_taskdicInprogress objectForKey:@"status"];

      self.reminder.datePickerMode=UIDatePickerModeTime;

      NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
         [formatter setDateFormat:@"hh:mm a"];
      NSDate *date=[formatter dateFromString:[_taskdicInprogress objectForKey:@"reminder"]];
       [_reminder setDate:date];
      [_dateOfCeation setText:[_taskdicInprogress objectForKey:@"current"]];
    
    //Notification
            isGrantNotificationAccess3=false;
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            UNAuthorizationOptions options = UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
            [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
                isGrantNotificationAccess3=granted;
                
            }];
}
-(void)setNotfication :(NSString*)taskname{
    if (isGrantNotificationAccess3) {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editAction:(id)sender {
        _taskName.enabled=YES;
        _taskDesc.enabled=YES;
        _reminder.enabled=YES;
        _doneBtn.enabled=YES;
        _highBtn.enabled=YES;
        _lowbtn.enabled=YES;
        _mediumBtn.enabled=YES;
        _saveBtn.enabled=YES;
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
       NSArray *arr=[NSArray arrayWithObjects:[_taskName text],nil];
       [center removePendingNotificationRequestsWithIdentifiers:arr];
}

- (IBAction)saveAction:(id)sender {
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
        
             [tasksarr replaceObjectAtIndex:_indexInprogress withObject:dict];
                  [taskDefault setObject:tasksarr forKey:@"tasks"];
                  [taskDefault synchronize];

        //notification
                [self setNotfication:taskName];

            // pup
           [self.navigationController popViewControllerAnimated:YES];
           
       }else{
           
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

@end
