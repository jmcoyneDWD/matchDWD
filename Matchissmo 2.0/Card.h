//
//  Card.h
//  Matchissmo 2.0
//
//  Created by Joan Coyne on 6/6/14.
//  Copyright (c) 2014 Dorado Web Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;




- (int)match:(NSArray *)otherCards;
@end
