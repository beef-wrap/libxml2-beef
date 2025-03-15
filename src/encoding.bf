/*
 * Summary: interface for the encoding conversion functions
 * Description: interface for the encoding conversion functions needed for
 *              XML basic encoding and iconv() support.
 *
 * Related specs are
 * rfc2044        (UTF-8 and UTF-16) F. Yergeau Alis Technologies
 * [ISO-10646]    UTF-8 and UTF-16 in Annexes
 * [ISO-8859-1]   ISO Latin-1 characters codes.
 * [UNICODE]      The Unicode Consortium, "The Unicode Standard --
 *                Worldwide Character Encoding -- Version 1.0", Addison-
 *                Wesley, Volume 1, 1991, Volume 2, 1992.  UTF-8 is
 *                described in Unicode Technical Report #4.
 * [US-ASCII]     Coded Character Set--7-bit American Standard Code for
 *                Information Interchange, ANSI X3.4-1986.
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
	public enum xmlCharEncError
	{
		XML_ENC_ERR_SUCCESS     =  0,
		XML_ENC_ERR_INTERNAL    = -1,
		XML_ENC_ERR_INPUT       = -2,
		XML_ENC_ERR_SPACE       = -3,
		XML_ENC_ERR_MEMORY      = -4
	}

	/*
	* xmlCharEncoding:
	*
	* Predefined values for some standard encodings.
	*/
	public enum xmlCharEncoding
	{
		XML_CHAR_ENCODING_ERROR =   -1, /* No char encoding detected */
		XML_CHAR_ENCODING_NONE =	0, /* No char encoding detected */
		XML_CHAR_ENCODING_UTF8 =	1, /* UTF-8 */
		XML_CHAR_ENCODING_UTF16LE =	2, /* UTF-16 little endian */
		XML_CHAR_ENCODING_UTF16BE =	3, /* UTF-16 big endian */
		XML_CHAR_ENCODING_UCS4LE =	4, /* UCS-4 little endian */
		XML_CHAR_ENCODING_UCS4BE =	5, /* UCS-4 big endian */
		XML_CHAR_ENCODING_EBCDIC =	6, /* EBCDIC uh! */
		XML_CHAR_ENCODING_UCS4_2143 = 7, /* UCS-4 unusual ordering */
		XML_CHAR_ENCODING_UCS4_3412 = 8, /* UCS-4 unusual ordering */
		XML_CHAR_ENCODING_UCS2 =	9, /* UCS-2 */
		XML_CHAR_ENCODING_8859_1 =	10, /* ISO-8859-1 ISO Latin 1 */
		XML_CHAR_ENCODING_8859_2 =	11, /* ISO-8859-2 ISO Latin 2 */
		XML_CHAR_ENCODING_8859_3 =	12, /* ISO-8859-3 */
		XML_CHAR_ENCODING_8859_4 =	13, /* ISO-8859-4 */
		XML_CHAR_ENCODING_8859_5 =	14, /* ISO-8859-5 */
		XML_CHAR_ENCODING_8859_6 =	15, /* ISO-8859-6 */
		XML_CHAR_ENCODING_8859_7 =	16, /* ISO-8859-7 */
		XML_CHAR_ENCODING_8859_8 =	17, /* ISO-8859-8 */
		XML_CHAR_ENCODING_8859_9 =	18, /* ISO-8859-9 */
		XML_CHAR_ENCODING_2022_JP =  19, /* ISO-2022-JP */
		XML_CHAR_ENCODING_SHIFT_JIS = 20, /* Shift_JIS */
		XML_CHAR_ENCODING_EUC_JP =   21, /* EUC-JP */
		XML_CHAR_ENCODING_ASCII =    22, /* pure ASCII */
		/* Available since 2.14.0 */
		XML_CHAR_ENCODING_UTF16 =	23, /* UTF-16 native */
		XML_CHAR_ENCODING_HTML =	24, /* HTML (output only) */
		XML_CHAR_ENCODING_8859_10 =	25, /* ISO-8859-10 */
		XML_CHAR_ENCODING_8859_11 =	26, /* ISO-8859-11 */
		XML_CHAR_ENCODING_8859_13 =	27, /* ISO-8859-13 */
		XML_CHAR_ENCODING_8859_14 =	28, /* ISO-8859-14 */
		XML_CHAR_ENCODING_8859_15 =	29, /* ISO-8859-15 */
		XML_CHAR_ENCODING_8859_16 =	30 /* ISO-8859-16 */
	}

	/**
	* xmlCharEncodingInputFunc:
	* @out:  a pointer to an array of bytes to store the UTF-8 result
	* @outlen:  the length of @out
	* @in:  a pointer to an array of chars in the original encoding
	* @inlen:  the length of @in
	*
	* Convert characters to UTF-8.
	*
	* On success, the value of @inlen after return is the number of
	* bytes consumed and @outlen is the number of bytes produced.
	*
	* Returns the number of bytes written or an XML_ENC_ERR code.
	*/
	public function c_int xmlCharEncodingInputFunc(c_uchar* out_, c_int* outlen, c_uchar* in_, c_int* inlen);


	/**
	* xmlCharEncodingOutputFunc:
	* @out:  a pointer to an array of bytes to store the result
	* @outlen:  the length of @out
	* @in:  a pointer to an array of UTF-8 chars
	* @inlen:  the length of @in
	*
	* Convert characters from UTF-8.
	*
	* On success, the value of @inlen after return is the number of
	* bytes consumed and @outlen is the number of bytes produced.
	*
	* Returns the number of bytes written or an XML_ENC_ERR code.
	*/
	public function c_int xmlCharEncodingOutputFunc(c_uchar* out_, c_int* outlen, c_uchar* in_, c_int* inlen);


	/**
	* xmlCharEncConvFunc:
	* @vctxt:  conversion context
	* @out:  a pointer to an array of bytes to store the result
	* @outlen:  the length of @out
	* @in:  a pointer to an array of input bytes
	* @inlen:  the length of @in
	*
	* Convert between character encodings.
	*
	* On success, the value of @inlen after return is the number of
	* bytes consumed and @outlen is the number of bytes produced.
	*
	* Returns the number of bytes written or an XML_ENC_ERR code.
	*/
	public function int xmlCharEncConvFunc(c_uchar* out_, c_int* outlen, c_uchar* in_, c_int* inlen, void* vctxt);

	/**
	* xmlCharEncConvCtxtDtor:
	* @vctxt:  conversion context
	*
	* Free a conversion context.
	*/
	public function void xmlCharEncConvCtxtDtor(void* vctxt);

	[CRepr]
	public struct xmlCharEncConverter
	{
		xmlCharEncConvFunc input;
		xmlCharEncConvFunc output;
		xmlCharEncConvCtxtDtor ctxtDtor;
		void* inputCtxt;
		void* outputCtxt;
	}

	/**
	* xmlCharEncConvImpl:
	* vctxt:  user data
	* name:  encoding name
	* conv:  pointer to xmlCharEncConverter struct
	*
	* If this function returns XML_ERR_OK, it must fill the @conv struct
	* with a conversion function, and optional destructor and optional
	* input and output conversion contexts.
	*
	* Returns an xmlParserErrors code.
	*/
	public function int xmlCharEncConvImpl(void* vctxt, char* name, xmlCharEncConverter* conv);

	/*
	* Block defining the handlers for non UTF-8 encodings.
	*
	* This structure will be made private.
	*/
	public struct xmlCharEncodingHandler;

	typealias xmlCharEncodingHandlerPtr = xmlCharEncodingHandler*;

	struct _xmlCharEncodingHandler
	{
		char* name; /* XML_DEPRECATED_MEMBER */
		xmlCharEncodingInputFunc input; /* XML_DEPRECATED_MEMBER */
		xmlCharEncodingOutputFunc output; /* XML_DEPRECATED_MEMBER */
#if LIBXML_ICONV_ENABLED
		void* iconv_in; /* XML_DEPRECATED_MEMBER */
		void* iconv_out; /* XML_DEPRECATED_MEMBER */
#endif
		void* inputCtxt; /* XML_DEPRECATED_MEMBER */
		void* outputCtxt; /* XML_DEPRECATED_MEMBER */
		xmlCharEncConvCtxtDtor ctxtDtor; /* XML_DEPRECATED_MEMBER */
		c_int flags; /* XML_DEPRECATED_MEMBER */
	}

	/*
	* Interfaces for encoding handlers.
	*/
	[CLink, Obsolete("")] public static extern void xmlInitCharEncodingHandlers();
	[CLink, Obsolete("")] public static extern void xmlCleanupCharEncodingHandlers();
	[CLink] public static extern void xmlRegisterCharEncodingHandler(xmlCharEncodingHandlerPtr handler);
	[CLink] public static extern int xmlLookupCharEncodingHandler(xmlCharEncoding enc, xmlCharEncodingHandlerPtr* out_);
	[CLink] public static extern int xmlOpenCharEncodingHandler(char* name, c_int output, xmlCharEncodingHandlerPtr* out_);
	[CLink] public static extern int xmlCreateCharEncodingHandler(char* name, c_int output, xmlCharEncConvImpl impl, void* implCtxt, xmlCharEncodingHandlerPtr* out_);
	[CLink] public static extern xmlCharEncodingHandlerPtr xmlGetCharEncodingHandler(xmlCharEncoding enc);
	[CLink] public static extern xmlCharEncodingHandlerPtr xmlFindCharEncodingHandler(char* name);
	[CLink] public static extern xmlCharEncodingHandlerPtr xmlNewCharEncodingHandler(char* name, xmlCharEncodingInputFunc input, xmlCharEncodingOutputFunc output);

	/*
	* Interfaces for encoding names and aliases.
	*/
	[CLink] public static extern int xmlAddEncodingAlias(char* name, char* alias);
	[CLink] public static extern int xmlDelEncodingAlias(char* alias);
	[CLink] public static extern char* xmlGetEncodingAlias(char* alias);
	[CLink] public static extern void xmlCleanupEncodingAliases(void);
	[CLink] public static extern xmlCharEncoding xmlParseCharEncoding(char* name);
	[CLink] public static extern char* xmlGetCharEncodingName(xmlCharEncoding enc);

	/*
	* Interfaces directly used by the parsers.
	*/
	[CLink] public static extern xmlCharEncoding xmlDetectCharEncoding(c_uchar* in_, c_int len);

	/** DOC_DISABLE */
	public struct _xmlBuffer;
	/** DOC_ENABLE */
	[CLink] public static extern int xmlCharEncOutFunc(xmlCharEncodingHandler* handler, _xmlBuffer* out_, _xmlBuffer* in_);

	[CLink] public static extern int xmlCharEncInFunc(xmlCharEncodingHandler* handler, _xmlBuffer* out_, _xmlBuffer* in_);
	[CLink, Obsolete("")] public static extern int xmlCharEncFirstLine(xmlCharEncodingHandler* handler, _xmlBuffer* out_, _xmlBuffer* in_);
	[CLink] public static extern int xmlCharEncCloseFunc(xmlCharEncodingHandler* handler);

	/*
	* Export a few useful functions
	*/
#if LIBXML_OUTPUT_ENABLED
	[CLink] public static extern int UTF8Toisolat1(c_uchar* out_, c_int* outlen, c_uchar* in_, c_int* inlen);
#endif

	[CLink] public static extern int isolat1ToUTF8(c_uchar* out_, c_int* outlen, c_uchar* in_, c_int* inlen);
}