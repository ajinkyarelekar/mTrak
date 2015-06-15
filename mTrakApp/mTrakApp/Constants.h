//
//  Constants.h
//  mTrakApp
//
//  Created by Nanostuffs's Macbook on 29/04/14.
//  Copyright (c) 2014 Nanostuffs. All rights reserved.
//

#ifndef mTrakApp_Constants_h
#define mTrakApp_Constants_h

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define Adjust_Height  (SYSTEM_VERSION_GREATER_THAN(@"6.8")? 20.0f:0.0f )

#define FONT ([UIFont fontWithName:@"MYRIADPRO-REGULAR" size:13])

#define BOLDFONT ([UIFont fontWithName:@"MYRIADPRO-REGULAR" size:13])

#endif
