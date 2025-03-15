/*
 * Summary: interface for the I/O interfaces used by the parser
 * Description: interface for the I/O interfaces used by the parser
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

extension libxml2
{
	/*
	* Those are the functions and datatypes for the parser input
	* I/O structures.
	*/

	/**
	* xmlInputMatchCallback:
	* @filename: the filename or URI
	*
	* Callback used in the I/O Input API to detect if the current handler
	* can provide input functionality for this resource.
	*
	* Returns 1 if yes and 0 if another Input module should be used
	*/
	public function c_int xmlInputMatchCallback(char* filename);
	/**
	* xmlInputOpenCallback:
	* @filename: the filename or URI
	*
	* Callback used in the I/O Input API to open the resource
	*
	* Returns an Input context or NULL in case or error
	*/
	public function void* xmlInputOpenCallback(char* filename);
	/**
	* xmlInputReadCallback:
	* @context:  an Input context
	* @buffer:  the buffer to store data read
	* @len:  the length of the buffer in bytes
	*
	* Callback used in the I/O Input API to read the resource
	*
	* Returns the number of bytes read or -1 in case of error
	*/
	public function c_int xmlInputReadCallback(void* context, char* buffer, c_int len);
	/**
	* xmlInputCloseCallback:
	* @context:  an Input context
	*
	* Callback used in the I/O Input API to close the resource
	*
	* Returns 0 or -1 in case of error
	*/
	public function c_int xmlInputCloseCallback(void* context);

#if LIBXML_OUTPUT_ENABLED
	/*
	* Those are the functions and datatypes for the library output
	* I/O structures.
	*/

	/**
	* xmlOutputMatchCallback:
	* @filename: the filename or URI
	*
	* Callback used in the I/O Output API to detect if the current handler
	* can provide output functionality for this resource.
	*
	* Returns 1 if yes and 0 if another Output module should be used
	*/
	public function c_int xmlOutputMatchCallback(char* filename);
	/**
	* xmlOutputOpenCallback:
	* @filename: the filename or URI
	*
	* Callback used in the I/O Output API to open the resource
	*
	* Returns an Output context or NULL in case or error
	*/
	public function void* xmlOutputOpenCallback(char* filename);
	/**
	* xmlOutputWriteCallback:
	* @context:  an Output context
	* @buffer:  the buffer of data to write
	* @len:  the length of the buffer in bytes
	*
	* Callback used in the I/O Output API to write to the resource
	*
	* Returns the number of bytes written or -1 in case of error
	*/
	public function c_int xmlOutputWriteCallback(void* context, char* buffer, c_int len);
	/**
	* xmlOutputCloseCallback:
	* @context:  an Output context
	*
	* Callback used in the I/O Output API to close the resource
	*
	* Returns 0 or -1 in case of error
	*/
	public function c_int xmlOutputCloseCallback(void* context);
#endif /* LIBXML_OUTPUT_ENABLED */ 

	/**
	* xmlParserInputBufferCreateFilenameFunc:
	* @URI: the URI to read from
	* @enc: the requested source encoding
	*
	* Signature for the function doing the lookup for a suitable input method
	* corresponding to an URI.
	*
	* Returns the new xmlParserInputBufferPtr in case of success or NULL if no
	*         method was found.
	*/
	public function xmlParserInputBufferPtr xmlParserInputBufferCreateFilenameFunc(char *URI, xmlCharEncoding enc);

	/**
	* xmlOutputBufferCreateFilenameFunc:
	* @URI: the URI to write to
	* @enc: the requested target encoding
	*
	* Signature for the function doing the lookup for a suitable output method
	* corresponding to an URI.
	*
	* Returns the new xmlOutputBufferPtr in case of success or NULL if no
	*         method was found.
	*/
	public function xmlOutputBufferPtr xmlOutputBufferCreateFilenameFunc(char *URI, xmlCharEncodingHandlerPtr encoder, c_int compression);

	[CRepr]
	public struct xmlParserInputBuffer {
		void*                  context;
		xmlInputReadCallback   readcallback;
		xmlInputCloseCallback  closecallback;

		xmlCharEncodingHandlerPtr encoder; /* I18N conversions to UTF-8 */

		xmlBufPtr buffer;    /* Local buffer encoded in UTF-8 */
		xmlBufPtr raw;       /* if encoder != NULL buffer for raw input */
		c_int	compressed;	    /* -1=unknown, 0=not compressed, 1=compressed */
		c_int error;
		c_ulong rawconsumed;/* amount consumed from raw */
	}


#if LIBXML_OUTPUT_ENABLED
	[CRepr]
	public struct xmlOutputBuffer {
		void*                   context;
		xmlOutputWriteCallback  writecallback;
		xmlOutputCloseCallback  closecallback;

		xmlCharEncodingHandlerPtr encoder; /* I18N conversions to UTF-8 */

		xmlBufPtr buffer;    /* Local buffer encoded in UTF-8 or ISOLatin */
		xmlBufPtr conv;      /* if encoder != NULL buffer for output */
		c_int written;            /* total number of byte written */
		c_int error;
	}
#endif

	/** DOC_DISABLE */
	// #define XML_GLOBALS_IO XML_OP(xmlParserInputBufferCreateFilenameValue, xmlParserInputBufferCreateFilenameFunc, XML_DEPRECATED) XML_OP(xmlOutputBufferCreateFilenameValue, xmlOutputBufferCreateFilenameFunc, XML_DEPRECATED)

	// #define XML_OP XML_DECLARE_GLOBAL
	// XML_GLOBALS_IO
	// #undef XML_OP

// #if defined(LIBXML_THREAD_ENABLED) && !defined(XML_GLOBALS_NO_REDEFINITION)
// 	#define xmlParserInputBufferCreateFilenameValue XML_GLOBAL_MACRO(xmlParserInputBufferCreateFilenameValue)
// 	#define xmlOutputBufferCreateFilenameValue XML_GLOBAL_MACRO(xmlOutputBufferCreateFilenameValue)
// #endif

	/*
	* Interfaces for input
	*/
	[CLink] public static extern void xmlCleanupInputCallbacks();

	[CLink] public static extern c_int xmlPopInputCallback();

	[CLink] public static extern void xmlRegisterDefaultInputCallbacks();
	[CLink] public static extern xmlParserInputBufferPtr xmlAllocParserInputBuffer(xmlCharEncoding enc);

	[CLink] public static extern xmlParserInputBufferPtr xmlParserInputBufferCreateFilename(char *URI, xmlCharEncoding enc);
	
	[CLink, Obsolete("")] public static extern xmlParserInputBufferPtr xmlParserInputBufferCreateFile(FILE *file, xmlCharEncoding enc);
	[CLink] public static extern xmlParserInputBufferPtr xmlParserInputBufferCreateFd(c_int fd, xmlCharEncoding enc);
	[CLink] public static extern xmlParserInputBufferPtr xmlParserInputBufferCreateMem(char *mem, c_int size, xmlCharEncoding enc);
	[CLink] public static extern xmlParserInputBufferPtr xmlParserInputBufferCreateStatic(char *mem, c_int size, xmlCharEncoding enc);
	[CLink] public static extern xmlParserInputBufferPtr xmlParserInputBufferCreateIO(xmlInputReadCallback ioread, xmlInputCloseCallback  ioclose, void *ioctx, xmlCharEncoding enc);
	
	[CLink, Obsolete("")] public static extern c_int xmlParserInputBufferRead(xmlParserInputBufferPtr in_, c_int len);
	
	[CLink, Obsolete("")] public static extern c_int xmlParserInputBufferGrow(xmlParserInputBufferPtr in_, c_int len);
	
	[CLink, Obsolete("")] public static extern c_int xmlParserInputBufferPush(xmlParserInputBufferPtr in_, c_int len, 	char *buf);
	[CLink] public static extern void xmlFreeParserInputBuffer(xmlParserInputBufferPtr in_);
	[CLink] public static extern char * xmlParserGetDirector(char *filename);

	[CLink] public static extern c_int xmlRegisterInputCallbacks(xmlInputMatchCallback matchFunc, 	xmlInputOpenCallback openFunc, 	xmlInputReadCallback readFunc, 	xmlInputCloseCallback closeFunc);

	// xmlParserInputBufferPtr _xmlParserInputBufferCreateFilenam(char *URI, 	xmlCharEncoding enc);

#if LIBXML_OUTPUT_ENABLED
	/*
	* Interfaces for output
	*/
	[CLink] public static extern void xmlCleanupOutputCallbacks();
	[CLink] public static extern c_int xmlPopOutputCallback();
	[CLink] public static extern void xmlRegisterDefaultOutputCallback();
	[CLink] public static extern xmlOutputBufferPtr xmlAllocOutputBuffer(xmlCharEncodingHandlerPtr encoder);

	[CLink] public static extern xmlOutputBufferPtr xmlOutputBufferCreateFilename(char *URI, xmlCharEncodingHandlerPtr encoder, c_int compression);

	[CLink] public static extern xmlOutputBufferPtr xmlOutputBufferCreateFile(FILE *file, xmlCharEncodingHandlerPtr encoder);

	[CLink] public static extern xmlOutputBufferPtr xmlOutputBufferCreateBuffer(xmlBufferPtr buffer, xmlCharEncodingHandlerPtr encoder);

	[CLink] public static extern xmlOutputBufferPtr xmlOutputBufferCreateFd(c_int fd, xmlCharEncodingHandlerPtr encoder);

	[CLink] public static extern xmlOutputBufferPtr xmlOutputBufferCreateIO(xmlOutputWriteCallback   iowrite, xmlOutputCloseCallback  ioclose, void *ioctx, xmlCharEncodingHandlerPtr encoder);

	/* Couple of APIs to get the output without digging into the buffers */
	[CLink] public static extern xmlChar * xmlOutputBufferGetContent(xmlOutputBufferPtr out_);
	[CLink] public static extern size_t xmlOutputBufferGetSize(xmlOutputBufferPtr out_);

	[CLink] public static extern c_int xmlOutputBufferWrite(xmlOutputBufferPtr out_, c_int len, char *buf);
	[CLink] public static extern c_int xmlOutputBufferWriteString(xmlOutputBufferPtr out_, char *str);
	[CLink] public static extern c_int xmlOutputBufferWriteEscape(xmlOutputBufferPtr out_, xmlChar *str, xmlCharEncodingOutputFunc escaping);

	[CLink] public static extern c_int xmlOutputBufferFlush(xmlOutputBufferPtr out_);
	[CLink] public static extern c_int xmlOutputBufferClose(xmlOutputBufferPtr out_);

	[CLink] public static extern c_int xmlRegisterOutputCallbacks(xmlOutputMatchCallback matchFunc, xmlOutputOpenCallback openFunc, xmlOutputWriteCallback writeFunc, xmlOutputCloseCallback closeFunc);

	// xmlOutputBufferPtr _xmlOutputBufferCreateFilename(char *URI, 		xmlCharEncodingHandlerPtr encoder, 		c_int compression);

#if LIBXML_HTTP_ENABLED
	/*  This function only exists if HTTP support built into the library  */
	
	[CLink, Obsolete("")] public static extern void xmlRegisterHTTPPostCallbacks(void );
#endif /* LIBXML_HTTP_ENABLED */

#endif /* LIBXML_OUTPUT_ENABLED */

	[CLink, Obsolete("")] public static extern xmlParserInputPtr xmlCheckHTTPInput(xmlParserCtxtPtr ctxt, xmlParserInputPtr ret);

	/*
	* A predefined entity loader disabling network accesses
	*/
	[CLink] public static extern xmlParserInputPtr xmlNoNetExternalEntityLoader(char *URL, char *ID, xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar * xmlNormalizeWindowsPath(xmlChar *path);
	[CLink, Obsolete("")] public static extern c_int xmlCheckFilename(char *path);

	/**
	* Default 'file://' protocol callbacks
	*/
	
	[CLink, Obsolete("")] public static extern c_int xmlFileMatc(char *filename);
	[CLink, Obsolete("")] public static extern void* xmlFileOpe(char *filename);
	[CLink, Obsolete("")] public static extern c_int xmlFileRea(void* context, char * buffer, c_int len);
	[CLink, Obsolete("")] public static extern c_int xmlFileClos(void* context);

	/**
	* Default 'http://' protocol callbacks
	*/
#if LIBXML_HTTP_ENABLED
	[CLink, Obsolete("")] public static extern c_int xmlIOHTTPMatch(char *filename);
	[CLink, Obsolete("")] public static extern void* xmlIOHTTPOpen(char *filename);

#if LIBXML_OUTPUT_ENABLED
	[CLink, Obsolete("")] public static extern void* xmlIOHTTPOpenW(char * post_uri, c_int   compression );
#endif /* LIBXML_OUTPUT_ENABLED */
	
	[CLink, Obsolete("")] public static extern c_int xmlIOHTTPRead(void* context, char * buffer, c_int len);
	[CLink, Obsolete("")] public static extern c_int xmlIOHTTPClose(void* context);
#endif /* LIBXML_HTTP_ENABLED */

	[CLink] public static extern xmlParserInputBufferCreateFilenameFunc xmlParserInputBufferCreateFilenameDefault( xmlParserInputBufferCreateFilenameFunc func);
	[CLink] public static extern xmlOutputBufferCreateFilenameFunc xmlOutputBufferCreateFilenameDefault( xmlOutputBufferCreateFilenameFunc func);
	
	[CLink, Obsolete("")] public static extern xmlOutputBufferCreateFilenameFunc xmlThrDefOutputBufferCreateFilenameDefault(xmlOutputBufferCreateFilenameFunc func);
	
	[CLink, Obsolete("")] public static extern xmlParserInputBufferCreateFilenameFunc xmlThrDefParserInputBufferCreateFilenameDefault( xmlParserInputBufferCreateFilenameFunc func);
}