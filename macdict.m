#import <Foundation/Foundation.h>

int main(int argc, const char *argv[])
{
    @autoreleasepool {
        if (argc < 2) {
            printf("Usage: %s <words>\n", argv[0]);
            return -1;
        }
        NSString *search = [NSString stringWithCString: argv[1] encoding: NSUTF8StringEncoding];
        CFStringRef def =  DCSCopyTextDefinition(NULL,(CFStringRef)search,CFRangeMake(0, [search length]));
        NSString *output = [NSString stringWithFormat: @"Definitions of <%@>\n%@\n", search, (NSString *)def];
        printf("%s", [output UTF8String]);
    }
    return 0;
}