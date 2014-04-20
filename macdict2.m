#import <Foundation/Foundation.h>

/**
 * References:
 * http://nshipster.com/dictionary-services/
 * https://github.com/mattt/DictionaryKit
 */
extern DCSDictionaryRef DCSDictionaryCreate(CFURLRef url);
extern DCSDictionaryRef DCSRecordGetSubDictionary(CFTypeRef record);
extern CFDictionaryRef DCSCopyDefinitionMarkup(DCSDictionaryRef dictionary, CFStringRef record);
extern CFStringRef DCSDictionaryGetName(DCSDictionaryRef dictionary);
extern CFStringRef DCSDictionaryGetShortName(DCSDictionaryRef dictionary);
extern CFArrayRef DCSCopyAvailableDictionaries();
extern CFArrayRef DCSCopyRecordsForSearchString(DCSDictionaryRef dictionary, CFStringRef string, void *, void *);
extern CFStringRef DCSRecordCopyData(CFTypeRef record);
extern CFStringRef DCSRecordCopyDataURL(CFTypeRef record);
extern CFStringRef DCSRecordGetAnchor(CFTypeRef record);
extern CFStringRef DCSRecordGetAssociatedObj(CFTypeRef record);
extern CFStringRef DCSRecordGetHeadword(CFTypeRef record);
extern CFStringRef DCSRecordGetRawHeadword(CFTypeRef record);
extern CFStringRef DCSRecordGetString(CFTypeRef record);
extern CFStringRef DCSRecordGetTitle(CFTypeRef record);

void NSPrint(NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat: format arguments: args];
    va_end(args);
    fprintf(stdout, "%s\n", [string UTF8String]);
    [string release];
}

void NSPrintErr(NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat: format arguments: args];
    va_end(args);
    fprintf(stderr, "%s\n", [string UTF8String]);
    [string release];
}

NSString *gProgramName;
void showHelpInformation()
{
<<<<<<< HEAD
    NSPrint(@"Usage: %@ [-h] [-l] [-d <dictionary> <words>", gProgramName);
    NSPrint(@"  -h    Display this help message.");
    NSPrint(@"  -l    Show indexed list of names of all available dictionaries.");
    NSPrint(@"  -d    Specify dictionary indexes to search in, using ',' to separate them");
=======
    NSPrint(@"Usage: %@ [-h] [-l] [-d <dictionary name>]... [-i <dictionary indexes>]... [word]...", gProgramName);
    NSPrint(@"  -h    Display this help message.");
    NSPrint(@"  -l    Show indexed list of names of all available dictionaries.");
    NSPrint(@"  -d    Specify a dictionary to search in.");
>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
    NSPrint(@"        Use 'all' to select all available dictionaries.");
    NSPrint(@"        If no dictionary is specified, it will look up the word or phrase in all available dictionaries and only return the first definition found.");
    NSPrint(@"  -i    Specify dictionary indexes to search in, using ',' as delimiters.");
    NSPrint(@"        If indexes contain 0 then all available dictionaries are selected.");
}

<<<<<<< HEAD
NSMapTable *availableDictionariesKeyedByName = nil;
NSArray *availableDictionariesArray;
=======
NSMapTable *gAvailableDictionariesKeyedByName = NULL;
NSArray *gAvailableDictionariesKeyedByIndex = NULL;

>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
int setupSystemInformation()
{
    gAvailableDictionariesKeyedByName = [NSMapTable
        mapTableWithKeyOptions: NSPointerFunctionsCopyIn
        valueOptions: NSPointerFunctionsObjectPointerPersonality];
<<<<<<< HEAD
    NSSet *availableDictionaries = [(NSSet *)DCSCopyAvailableDictionaries() autorelease];
    NSMutableArray *arrM = [NSMutableArray array];
    for (id dictionary in availableDictionaries) {
        NSString *name = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)dictionary);
        [availableDictionariesKeyedByName setObject: dictionary forKey: name];
	[arrM addObject:dictionary];
    }
    availableDictionariesArray = [arrM sortedArrayUsingComparator:^(id obj1, id obj2){
	NSString *str1 = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)obj1);
	NSString *str2 = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)obj2);
	return [str1 compare:str2];	   
=======
    NSMutableArray *availableDictionaryArray = [[NSMutableArray array] autorelease];
    NSSet *availableDictionarySet = [(NSSet *)DCSCopyAvailableDictionaries() autorelease];
    for (id dictionary in availableDictionarySet) {
        NSString *name = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)dictionary);
        [gAvailableDictionariesKeyedByName setObject: dictionary forKey: name];
        [availableDictionaryArray addObject: dictionary];
    }
    gAvailableDictionariesKeyedByIndex = [availableDictionaryArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
        NSString *str1 = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)obj1);
        NSString *str2 = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)obj2);
        return [str1 compare: str2];	   
>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
    }];
    return 0;
}

void showDictionaryList()
{
<<<<<<< HEAD
    @autoreleasepool {
        //for (NSString *name in availableDictionariesKeyedByName) {
        //    NSPrint(@"%@", name);
        //}

	for(int i=0; i<availableDictionariesArray.count; i++){
	    NSPrint(@"%d) %@", i+1, (NSString *)DCSDictionaryGetName((DCSDictionaryRef)(availableDictionariesArray[i])));
	}
=======
    for (int i = 0; i < gAvailableDictionariesKeyedByIndex.count; i++) {
        DCSDictionaryRef dictionary = (DCSDictionaryRef)gAvailableDictionariesKeyedByIndex[i];
        NSPrint(@"[%d] %@", i + 1, (NSString *)DCSDictionaryGetName(dictionary));
>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
    }
}

bool gToSearchInAllDictionaries = false;
bool gToShowDictionaryList = false;
bool gToShowHelpInformation = false;

<<<<<<< HEAD
int ch;
char *acceptedArgs = "d:lh";
int setupParameters_mod(const int argc, char *const argv[], const NSMutableArray *words, const NSMutableSet *dicts)
{
    while((ch = getopt(argc, argv, acceptedArgs)) != -1){
        switch(ch){
            case 'h':
                gToShowHelpInformation = true;
                return 0;
            case 'd':
                    if(strcmp(optarg, "all") != 0){
                        NSString *dictName = nil;
			const int len = strlen(optarg);
			char buffer[len+1];
		       	strcpy(buffer, optarg);
			char *p = strtok(buffer, ",");
			while(p != NULL){
			    int index;
			    sscanf(p,"%d",&index);
			    dictName = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)availableDictionariesArray[index-1]);
			    if(dictName){
			        [dicts addObject:dictName];
			    }
			    p = strtok(NULL, ",");
			}
                    }else{
                        gToSearchInAllDictionaries = true;
                    }
                break;
            case 'l':
                gToShowDictionaryList = true;
                return 0;
            case '?':
            default:
                exit(-1);
        }
    }
    
    //the last parameter is the searching word
    if(argv[optind] != NULL){
        NSString *param = [NSString stringWithCString:argv[optind] encoding:NSUTF8StringEncoding];
        [words addObject:param];
    }else{
        printf("Please provide a word for searching.\n");
        exit(-1);
    }
    return 0;
}

int setupParameters(const int argc, const char *argv[], const NSMutableArray *words, const NSMutableSet *dicts)
=======
int setupParameters(const int argc, char *const argv[], const NSMutableArray *words, const NSMutableSet *dicts)
>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
{
    NSString *param = NULL;
    NSString *indexes = NULL;
    char *acceptedArgs = "+d:i:lh";
    int i, ch;
    while ((ch = getopt(argc, argv, acceptedArgs)) != -1) {
        switch (ch) {
            case 'h':
                gToShowHelpInformation = true;
                return 0;
            case 'l':
                gToShowDictionaryList = true;
                return 0;
            case 'd':
                param = [NSString stringWithCString: optarg encoding: NSUTF8StringEncoding];
                if (!gToSearchInAllDictionaries) {
                    if ([param isEqualToString: @"all"]) {
                        gToSearchInAllDictionaries = true;
                        [dicts removeAllObjects];
                        break;
                    }
                    if ([gAvailableDictionariesKeyedByName objectForKey: param]) {
                        [dicts addObject: param];
                    }
                }
                break;
            case 'i':
                indexes = [NSString stringWithCString: optarg encoding: NSUTF8StringEncoding];
                if (!gToSearchInAllDictionaries) {
                    for (NSString *index in [indexes componentsSeparatedByString: @","]) {
                        if (index.intValue == 0) {
                            gToSearchInAllDictionaries = true;
                            [dicts removeAllObjects];
                            break;
                        }
                        param = (NSString *)DCSDictionaryGetName((DCSDictionaryRef)gAvailableDictionariesKeyedByIndex[index.intValue-1]);
                        if (param) {
                            [dicts addObject: param];
                        }
                    }
                }
                break;
            case '?':
            default:
                return -1;
        }
    }
    
    //the rest parameters are the searching words
    if (argv[optind] != NULL) {
        for (i = optind; argv[i] != NULL; i++) {
            [words addObject: [NSString stringWithCString: argv[i] encoding: NSUTF8StringEncoding]];
        }
    } else {
        if (!(gToShowHelpInformation || gToShowDictionaryList)) {
            NSPrintErr(@"Error:\n  Please provide a word for searching.");
            return -1;
        }
    }
    return 0;
}

int searchDictionary(const NSString *phrase, const NSMutableSet *dicts)
{
    if (!gToSearchInAllDictionaries && (dicts.count < 1)) {
        CFRange range = DCSGetTermRangeInString(NULL, (CFStringRef)phrase, 0);
        CFStringRef definition = DCSCopyTextDefinition(NULL, (CFStringRef)phrase, range);
        if (definition) {
            NSPrint(@"Definitions of <%@>\n\n%@", phrase, (NSString *)definition);
            CFRelease(definition);
        } else {
            NSPrint(@"Definitions of <%@>\n\n%@", phrase, @"(none)");
        }
    } else {
        int totalDefinitions = 0;
        for (id dictionaryName in (gToSearchInAllDictionaries ? gAvailableDictionariesKeyedByName : dicts)) {
            DCSDictionaryRef dictionary = (DCSDictionaryRef)[gAvailableDictionariesKeyedByName objectForKey: dictionaryName];
            CFRange range = DCSGetTermRangeInString(dictionary, (CFStringRef)phrase, 0);
            CFStringRef definition = DCSCopyTextDefinition(dictionary, (CFStringRef)phrase, range);
<<<<<<< HEAD
            if (definition) {
                NSPrint(@"Definitions of <%@>\n%@", phrase, (NSString *)definition);
	    	CFRelease(definition);
            } else {
                NSPrint(@"Definitions of <%@>\n%@", phrase, @"(none)");
=======
            if (range.location == kCFNotFound) {
                continue;
>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
            }
            CFStringRef term = (CFStringRef)[phrase substringWithRange: NSMakeRange(range.location, range.length)];

<<<<<<< HEAD
                if (definition) {
                    if (totalDefinitions > 0) {
                        NSPrint(@"\n");
                    }
                    NSPrint(@"Definitions of <%@> in {%@}\n%@", (NSString *)term, dictionaryName, (NSString *)definition);
                    totalDefinitions++;
		    CFRelease(definition);
                }

                /*// alternate mode?
                 *NSArray *records = (NSArray *)DCSCopyRecordsForSearchString(dictionary, term, NULL, NULL);
                 *if (records) {
                 *    for (id record in records) {
                 *        CFStringRef headword = DCSRecordGetHeadword((CFTypeRef)record);
                 *        if (headword) {
                 *            CFRange range = DCSGetTermRangeInString(dictionary, headword, 0);
                 *            CFStringRef definition = DCSCopyTextDefinition(dictionary, headword, range);
                 *            if (definition) {
                 *                if (totalDefinitions > 0) {
                 *                    NSPrint(@"\n");
                 *                }
                 *                NSPrint(@"Definitions of <%@> in {%@}\n%@", (NSString *)headword, dictionaryName, (NSString *)definition);
                 *                totalDefinitions++;
                 *            }
                 *        }
                 *    }
                 *}
                 */
            }
            if (totalDefinitions < 1) {
		    if(!gToSearchInAllDictionaries){
			    NSPrint(@"Definitions of <%@> in {%@}\n%@", phrase, [[dicts allObjects] componentsJoinedByString:@""], @"(none)");
		    }else{
                	NSPrint(@"Definitions of <%@> in {all}\n%@", phrase, @"(none)");
		    }
=======
            if (definition) {
                if (totalDefinitions > 0) {
                    NSPrint(@"%%");
                }
                NSPrint(@"Definitions of <%@> in {%@}\n\n%@", (NSString *)term, dictionaryName, (NSString *)definition);
                totalDefinitions++;
                CFRelease(definition);
>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
            }
        }
        if (totalDefinitions < 1) {
            NSPrint(@"Definitions of <%@>\n\n%@", phrase, @"(none)");
        }
    }
    return 0;
}

int main(int argc, char *argv[])
{
    gProgramName = [NSString stringWithCString: argv[0] encoding: NSUTF8StringEncoding];
    if (argc < 2) {
        showHelpInformation();
        exit(-1);
    }
    NSMutableArray *words = [[NSMutableArray array] autorelease];
    NSMutableSet *dicts = [[NSMutableSet set] autorelease];
    int exitCode = 0;
    if ((exitCode = setupSystemInformation())) {
<<<<<<< HEAD
      exit(exitCode);
    }
    if ((exitCode = setupParameters_mod(argc, (void *)argv, words, dicts))) {
      exit(exitCode);
=======
        exit(exitCode);
    }
    if ((exitCode = setupParameters(argc, (void *)argv, words, dicts))) {
        showHelpInformation();
        exit(exitCode);
>>>>>>> 78019659dc6a8b76f7c382729249241d6bea8e39
    }
    if (gToShowHelpInformation) {
        showHelpInformation();
        exit(0);
    }
    if (gToShowDictionaryList) {
        showDictionaryList();
        exit(0);
    }
    NSString *phrase = [words componentsJoinedByString: @" "];
    if ((exitCode = searchDictionary(phrase, dicts))) {
        exit(exitCode);
    }
    exit(0);
}
