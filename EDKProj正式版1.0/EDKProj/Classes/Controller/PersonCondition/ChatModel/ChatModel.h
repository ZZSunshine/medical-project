//
//  ChatModel.h
//  UUChatTableView
//
//  Created by 晓飞 on 15/1/6.


#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic) BOOL isGroupChat;

- (void)populateRandomDataSource;

- (void)addRandomItemsToDataSource:(NSInteger)number;

- (void)addSpecifiedItem:(NSDictionary *)dic;

@end
