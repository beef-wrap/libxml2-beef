/*
 * Summary: minimal HTTP implementation
 * Description: minimal HTTP implementation allowing to fetch resources
 *              like external subset.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_HTTP_ENABLED

extension libxml2
{
	[CLink, Obsolete("")] public static extern void xmlNanoHTTPInit(void);
	[CLink, Obsolete("")] public static extern void xmlNanoHTTPCleanup(void);
	[CLink, Obsolete("")] public static extern void xmlNanoHTTPScanProxy(char* URL);
	[CLink, Obsolete("")] public static extern int xmlNanoHTTPFetch(char* URL, char* filename, char** contentType);
	[CLink, Obsolete("")] public static extern void* xmlNanoHTTPMethod(char* URL, char* method, char* input, char** contentType, char* headers, c_int ilen);
	[CLink, Obsolete("")] public static extern void* xmlNanoHTTPMethodRedir(char* URL, char* method, char* input, char** contentType, char** redir, char* headers, c_int ilen);
	[CLink, Obsolete("")] public static extern void* xmlNanoHTTPOpen(char* URL, char** contentType);
	[CLink, Obsolete("")] public static extern void* xmlNanoHTTPOpenRedir(char* URL, char** contentType, char** redir);
	[CLink, Obsolete("")] public static extern int xmlNanoHTTPReturnCode(void* ctx);
	[CLink, Obsolete("")] public static extern char* xmlNanoHTTPAuthHeader(void* ctx);
	[CLink, Obsolete("")] public static extern char* xmlNanoHTTPRedir(void* ctx);
	[CLink, Obsolete("")] public static extern int xmlNanoHTTPContentLength(void* ctx);
	[CLink, Obsolete("")] public static extern char* xmlNanoHTTPEncoding(void* ctx);
	[CLink, Obsolete("")] public static extern char* xmlNanoHTTPMimeType(void* ctx);
	[CLink, Obsolete("")] public static extern int xmlNanoHTTPRead(void* ctx, void* dest, c_int len);
	
#if LIBXML_OUTPUT_ENABLED
	[CLink, Obsolete("")] public static extern int xmlNanoHTTPSave(void* ctxt, char* filename);
#endif

	[CLink, Obsolete("")] public static extern void xmlNanoHTTPClose(void* ctx);
}

#endif /* LIBXML_HTTP_ENABLED */ 

