//
//  HYCustomNotifiSender.h
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NTESNotifyID        @"id"
#define NTESCustomContent   @"content"
#define NTESTeamMeetingMembers   @"members"
#define NTESTeamMeetingTeamId    @"teamId"
#define NTESTeamMeetingTeamName  @"teamName"
#define NTESTeamMeetingName      @"room"

#define NTESCommandTyping   (1)
#define NTESCustom          (2)
#define NTESTeamMeetingCall (3)

@interface HYCustomNotifiSender : NSObject

- (void)sendCustomContent:(NSString *)content toSession:(NIMSession *)session;

- (void)sendTypingState:(NIMSession *)session;

- (void)sendCallNotification:(NSString *)teamId
                    roomName:(NSString *)roomName
                     members:(NSArray *)members;

@end
