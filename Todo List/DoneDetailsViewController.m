//
//  DoneDetailsViewController.m
//  Todo List
//
//  Created by Donia Ashraf on 4/7/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import "DoneDetailsViewController.h"

@interface DoneDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDesc;
@property (weak, nonatomic) IBOutlet UIButton *highBtn;
@property (weak, nonatomic) IBOutlet UIButton *mediumBtn;
@property (weak, nonatomic) IBOutlet UIButton *lowBtn;
@property (weak, nonatomic) IBOutlet UILabel *priority;
@property (weak, nonatomic) IBOutlet UILabel *dateOfCreation;

@property (nonatomic) NSString *getPriority;
@property (nonatomic) NSString *getStatus;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminder;

@end
@implementation DoneDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
         _taskName.enabled=NO;
         _taskDesc.enabled=NO;
         _reminder.enabled=NO;
         _highBtn.enabled=NO;
         _lowBtn.enabled=NO;
         _mediumBtn.enabled=NO;
         
         [_taskName setText:[ _taskdicdone objectForKey:@"taskname"]];
         [_taskDesc setText:[_taskdicdone objectForKey:@"Desc"]];
         [_priority setText:[_taskdicdone objectForKey:@"priority"]];

         _getPriority=[_taskdicdone objectForKey:@"priority"];
         _getStatus=[_taskdicdone objectForKey:@"status"];

         self.reminder.datePickerMode=UIDatePickerModeTime;

         NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"hh:mm a"];
         NSDate *date=[formatter dateFromString:[_taskdicdone objectForKey:@"reminder"]];
          [_reminder setDate:date];
         [_dateOfCreation setText:[_taskdicdone objectForKey:@"current"]];
    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
- (IBAction)editAction:(id)sender {
        // pup
                        [self.navigationController popViewControllerAnimated:YES];
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
