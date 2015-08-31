//
//  MyFile.m
//  DeeploveProgram
//
//  Created by deeplove on 2011/3/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyFile.h"


@implementation MyFile

+(NSArray*)getFilesUnderDirectoryUnderDocByDirName:(NSString*)dirName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], dirName];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    return array;
}

+(BOOL)removeDirectoryUnderDoc:(NSString*)dirName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *removePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], dirName];
    return [[NSFileManager defaultManager] removeItemAtPath:removePath error:nil];
}

+(void)renameOldPath:(NSString*)oldPath withNewDirName:(NSString*)newDirectoryName
{
    NSString *newPath = [[oldPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:newDirectoryName];
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtPath:oldPath toPath:newPath error:&error];
    if (error) {
        // handle error
    }
}

+(BOOL)createDirectoryUnderDoc:(NSString*)dirName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *newDirectory = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], dirName];
    BOOL result = NO;
    
    // Check if the directory already exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:newDirectory]) {
        // Directory does not exist so create it
        result = [[NSFileManager defaultManager] createDirectoryAtPath:newDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return result;
}


+(void)deleteFileUnderDocDir:(NSString*)name typeLength:(int)typeLength
{
    NSString *path = [MyFile filePath:name isProjectFile:NO];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:NULL];
}

+(NSString*)localFilePath:(NSString*)name 
{	
    
    NSString *path;
    /*
    if([UIScreen mainScreen].scale > 1)
    {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x.%@", name, fileType] ofType:nil];
    }
    if(path == nil)
    {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%@", name, fileType] ofType:nil ];
    }
    */
    path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", name] ofType:nil ];
    
    return path;
}


+(NSString*)filePath:(NSString*)name isProjectFile:(BOOL)isProjectFile
{	
	
    if(isProjectFile)
	{
		NSArray *stringArray = [name componentsSeparatedByString:@"/"];
		
		if([stringArray count] == 2)
		{
			return [[NSBundle mainBundle]
					pathForResource:stringArray[1]
					ofType:nil
					inDirectory:stringArray[0]];
			
		}
		else
		{
            return [[NSBundle mainBundle]
					pathForResource:name
					ofType:nil];
			
		}
	}
	else
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
															 NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		return [documentsDirectory 
				stringByAppendingPathComponent:name];	
		
	}
}



@end
