//
//  DBSELog.h
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#ifndef tripsygo_DBSELog_h
#define tripsygo_DBSELog_h

#ifndef DLog
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#endif

#endif