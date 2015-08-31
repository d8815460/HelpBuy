//
//  MyFile.h
//  DeeploveProgram
//
//  Created by deeplove on 2011/3/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyFile : NSObject {
    
}
+(NSString*)filePath:(NSString*)name isProjectFile:(BOOL)isProjectFile;
+(void)deleteFileUnderDocDir:(NSString*)name typeLength:(int)typeLength;
+(BOOL)createDirectoryUnderDoc:(NSString*)dirName;
+(void)renameOldPath:(NSString*)oldPath withNewDirName:(NSString*)newDirectoryName;
+(BOOL)removeDirectoryUnderDoc:(NSString*)dirName;
+(NSArray*)getFilesUnderDirectoryUnderDocByDirName:(NSString*)dirName;
+(NSString*)localFilePath:(NSString*)name;

@end
