//
//  InProgressDetailsViewController.h
//  Todo List
//
//  Created by Donia Ashraf on 4/7/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface InProgressDetailsViewController : UIViewController
@property (nonatomic) NSDictionary *taskdicInprogress;
@property (nonatomic) NSUInteger *indexInprogress;
@end

NS_ASSUME_NONNULL_END
