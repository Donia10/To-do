//
//  AddTaskViewController.m
//  Todo List
//
//  Created by Donia Ashraf on 4/5/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import "AddTaskViewController.h"
#import "ViewController.h"

@interface AddTaskViewController ()
{
    NSArray *radiobtns;
}
@property (weak, nonatomic) IBOutlet UIButton *highBtn;
@property (weak, nonatomic) IBOutlet UIButton *mediumBtn;
@property (weak, nonatomic) IBOutlet UIButton *lowBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDesc;
@property (nonatomic) NSString *priority;
@end

BOOL isGrantNotificationAccess;
@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Notification
         isGrantNotificationAccess=false;
    
    // Do any additional setup after loading the view.
    radiobtns=[[NSArray alloc] initWithObjects:_highBtn,_mediumBtn,_lowBtn, nil];
    //date time picker
    self.datePicker.datePickerMode=UIDatePickerModeTime;
    [_datePicker addTarget:self action:@selector(getTimeChanged) forControlEvents:UIControlEventValueChanged];
 
    _priority=@"high";
   
       //Notification
       isGrantNotificationAccess=false;
       UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
       UNAuthorizationOptions options = UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
       [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
           isGrantNotificationAccess=granted;
           
       }];

}
- (IBAction)radioBtnPressed:(id)sender {
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==1) {
        printf("high");
        _priority=@"high";
    }if (btn.tag==2) {
        printf("medium");
        _priority=@"medium";

    }if (btn.tag==3) {
        printf("low\n");
        _priority=@"low";

    }
    
}
-(NSString*)getTimeChanged{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *selectedTime=[formatter stringFromDate:self.datePicker.date];
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
- (IBAction)addTaskActionBtn:(id)sender {
    if(![[_taskName text ] isEqual:@""]){
        
        NSString *taskName=[_taskName text];
        NSString *taskDesc=[_taskDesc text];
//        NSString *timechosen=[NSString stringWithFormat:@"%li",(long)(self.datePicker.datePickerMode=UIDatePickerModeTime)];
        NSString *timechosen=[self getTimeChanged];
        printf("time is ");
        
    //  printf(@"%@", timechosen);
        [_datePicker addTarget:self action:@selector(getTimeChanged) forControlEvents:UIControlEventValueChanged];
    NSString *currentTime=[NSString stringWithFormat:@"%@",[self getCurrentTime]];
    

//          NSArray objects[]={taskName,taskDesc,time,currentTime};
//          NSArray keys[]={@"name",@"desc",@"time",@"currentTime"};
        NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
        NSMutableArray *tasksarr =[[taskDefault objectForKey:@"tasks"]mutableCopy];

        NSDictionary *dict = @{@"taskname":taskName,
                               @"Desc":taskDesc,
                               @"priority":_priority,
                               @"reminder":timechosen,
                               @"current":currentTime,
                               @"status":@"Todo"
        };
    

        [tasksarr addObject:dict];
        [taskDefault setObject:tasksarr forKey:@"tasks"];
        [taskDefault synchronize];

        printf("\n addtask  ");
        printf("%i",tasksarr.count);
        //before array added
//        NSUserDefaults *taskDefault=[NSUserDefaults standardUserDefaults];
//        [taskDefault setObject:dict forKey:@"name"];


        [self setNotfication:taskName];
        
        // pup
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        
    }
  
}
-(void)setNotfication :(NSString*)taskname{
    if (isGrantNotificationAccess) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc]init];
        content.title=taskname;
      //  content.subtitle=@"subtitle";
        content.body=[[@"Time of doing the  " stringByAppendingFormat:taskname]stringByAppendingFormat:@"is now"];
        content.sound=[UNNotificationSound defaultSound];
    
        
        
//        UNTimeIntervalNotificationTrigger *trigger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
        
        NSDate *date=self.datePicker.date;

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

@end
