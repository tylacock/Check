//
//  ChecklistItem.h
//  Checklists
//
//  Created by Lacock, Ty on 1/16/14.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;

@end
