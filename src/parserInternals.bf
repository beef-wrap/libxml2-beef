/*
 * Summary: internals routines and limits exported by the parser.
 * Description: this module exports a number of internal parsing routines
 *              they are not really all intended for applications but
 *              can prove useful doing low level processing.
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
	/**
	* xmlParserMaxDepth:
	*
	* DEPRECATED: has no effect
	*
	* arbitrary depth limit for the XML documents that we allow to
	* process. This is not a limitation of the parser but a safety
	* boundary feature, use XML_PARSE_HUGE option to override it.
	*/

	// XMLPUBVAR c_uint xmlParserMaxDepth;

	/**
	* XML_MAX_TEXT_LENGTH:
	*
	* Maximum size allowed for a single text node when building a tree.
	* This is not a limitation of the parser but a safety boundary feature,
	* use XML_PARSE_HUGE option to override it.
	* Introduced in 2.9.0
	*/
	const c_int XML_MAX_TEXT_LENGTH = 10000000;

	/**
	* XML_MAX_HUGE_LENGTH:
	*
	* Maximum size allowed when XML_PARSE_HUGE is set.
	*/
	const c_int XML_MAX_HUGE_LENGTH = 1000000000;

	/**
	* XML_MAX_NAME_LENGTH:
	*
	* Maximum size allowed for a markup identifier.
	* This is not a limitation of the parser but a safety boundary feature,
	* use XML_PARSE_HUGE option to override it.
	* Note that with the use of parsing dictionaries overriding the limit
	* may result in more runtime memory usage in face of "unfriendly' content
	* Introduced in 2.9.0
	*/
	const c_int XML_MAX_NAME_LENGTH = 50000;

	/**
	* XML_MAX_DICTIONARY_LIMIT:
	*
	* Maximum size allowed by the parser for a dictionary by default
	* This is not a limitation of the parser but a safety boundary feature,
	* use XML_PARSE_HUGE option to override it.
	* Introduced in 2.9.0
	*/
	const c_int XML_MAX_DICTIONARY_LIMIT = 100000000;

	/**
	* XML_MAX_LOOKUP_LIMIT:
	*
	* Maximum size allowed by the parser for ahead lookup
	* This is an upper boundary enforced by the parser to avoid bad
	* behaviour on "unfriendly' content
	* Introduced in 2.9.0
	*/
	const c_int XML_MAX_LOOKUP_LIMIT = 10000000;

	/**
	* XML_MAX_NAMELEN:
	*
	* Identifiers can be longer, but this will be more costly
	* at runtime.
	*/
	const c_int XML_MAX_NAMELEN = 100;

	/************************************************************************
	*									*
	* UNICODE version of the macros.					*
	*									*
	************************************************************************/
	/**
	* IS_BYTE_CHAR:
	* @c:  an byte value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	* [2] Char ::= #x9 | #xA | #xD | [#x20...]
	* any byte character in the accepted range
	*/
	// #define IS_BYTE_CHAR(c)	 xmlIsChar_ch(c)

	/**
	* IS_CHAR:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	* [2] Char ::= #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD]
	*                  | [#x10000-#x10FFFF]
	* any Unicode character, excluding the surrogate blocks, FFFE, and FFFF.
	*/
	// #define IS_CHAR(c)   xmlIsCharQ(c)

	/**
	* IS_CHAR_CH:
	* @c: an xmlChar (usually an c_uchar)
	*
	* Behaves like IS_CHAR on single-byte value
	*/
	// #define IS_CHAR_CH(c)  xmlIsChar_ch(c)

	/**
	* IS_BLANK:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	* [3] S ::= (#x20 | #x9 | #xD | #xA)+
	*/
	// #define IS_BLANK(c)  xmlIsBlankQ(c)

	/**
	* IS_BLANK_CH:
	* @c:  an xmlChar value (normally c_uchar)
	*
	* Behaviour same as IS_BLANK
	*/
	// #define IS_BLANK_CH(c)  xmlIsBlank_ch(c)

	/**
	* IS_BASECHAR:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	* [85] BaseChar ::= ... long list see REC ...
	*/
	// #define IS_BASECHAR(c) xmlIsBaseCharQ(c)

	/**
	* IS_DIGIT:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	* [88] Digit ::= ... long list see REC ...
	*/
	// #define IS_DIGIT(c) xmlIsDigitQ(c)

	/**
	* IS_DIGIT_CH:
	* @c:  an xmlChar value (usually an c_uchar)
	*
	* Behaves like IS_DIGIT but with a single byte argument
	*/
	// #define IS_DIGIT_CH(c)  xmlIsDigit_ch(c)

	/**
	* IS_COMBINING:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	* [87] CombiningChar ::= ... long list see REC ...
	*/
	// #define IS_COMBINING(c) xmlIsCombiningQ(c)

	/**
	* IS_COMBINING_CH:
	* @c:  an xmlChar (usually an c_uchar)
	*
	* Always false (all combining chars > 0xff)
	*/
	// #define IS_COMBINING_CH(c) 0

	/**
	* IS_EXTENDER:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	*
	* [89] Extender ::= #x00B7 | #x02D0 | #x02D1 | #x0387 | #x0640 |
	*                   #x0E46 | #x0EC6 | #x3005 | [#x3031-#x3035] |
	*                   [#x309D-#x309E] | [#x30FC-#x30FE]
	*/
	// #define IS_EXTENDER(c) xmlIsExtenderQ(c)

	/**
	* IS_EXTENDER_CH:
	* @c:  an xmlChar value (usually an c_uchar)
	*
	* Behaves like IS_EXTENDER but with a single-byte argument
	*/
	// #define IS_EXTENDER_CH(c)  xmlIsExtender_ch(c)

	/**
	* IS_IDEOGRAPHIC:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	*
	* [86] Ideographic ::= [#x4E00-#x9FA5] | #x3007 | [#x3021-#x3029]
	*/
	// #define IS_IDEOGRAPHIC(c) xmlIsIdeographicQ(c)

	/**
	* IS_LETTER:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	*
	* [84] Letter ::= BaseChar | Ideographic
	*/
	// #define IS_LETTER(c) (IS_BASECHAR(c) || IS_IDEOGRAPHIC(c))

	/**
	* IS_LETTER_CH:
	* @c:  an xmlChar value (normally c_uchar)
	*
	* Macro behaves like IS_LETTER, but only check base chars
	*
	*/
	// #define IS_LETTER_CH(c) xmlIsBaseChar_ch(c)

	/**
	* IS_ASCII_LETTER:
	* @c: an xmlChar value
	*
	* Macro to check [a-zA-Z]
	*
	*/
	// #define IS_ASCII_LETTER(c)	((0x61 <= ((c) | 0x20)) && \
									//  (((c) | 0x20) <= 0x7a))

	/**
	* IS_ASCII_DIGIT:
	* @c: an xmlChar value
	*
	* Macro to check [0-9]
	*
	*/
	// #define IS_ASCII_DIGIT(c)	((0x30 <= (c)) && ((c) <= 0x39))

	/**
	* IS_PUBIDCHAR:
	* @c:  an UNICODE value (c_int)
	*
	* Macro to check the following production in the XML spec:
	*
	*
	* [13] PubidChar ::= #x20 | #xD | #xA | [a-zA-Z0-9] | [-'()+,./:=?;!*#@$_%]
	*/
	// #define IS_PUBIDCHAR(c)	xmlIsPubidCharQ(c)

	/**
	* IS_PUBIDCHAR_CH:
	* @c:  an xmlChar value (normally c_uchar)
	*
	* Same as IS_PUBIDCHAR but for single-byte value
	*/
	// #define IS_PUBIDCHAR_CH(c) xmlIsPubidChar_ch(c)

	/**
	* Global variables used for predefined strings.
	*/
	// XMLPUBVAR xmlChar xmlStringText[];
	// XMLPUBVAR xmlChar xmlStringTextNoenc[];
	// XMLPUBVAR xmlChar xmlStringComment[];

	[CLink, Obsolete("")] public static extern c_int xmlIsLetter(c_int c);

	/**
	* Parser context.
	*/
	[CLink] public static extern xmlParserCtxtPtr xmlCreateFileParserCtxt(char* filename);
	[CLink] public static extern xmlParserCtxtPtr xmlCreateURLParserCtxt(char* filename, c_int options);
	[CLink] public static extern xmlParserCtxtPtr xmlCreateMemoryParserCtxt(char* buffer, c_int size);

	[CLink, Obsolete("")] public static extern xmlParserCtxtPtr xmlCreateEntityParserCtxt(xmlChar* URL, xmlChar* ID, xmlChar* base_);

	[CLink] public static extern void xmlCtxtErrMemory(xmlParserCtxtPtr ctxt);
	[CLink] public static extern c_int xmlSwitchEncoding(xmlParserCtxtPtr ctxt, xmlCharEncoding enc);
	[CLink] public static extern c_int xmlSwitchEncodingName(xmlParserCtxtPtr ctxt, char* encoding);
	[CLink] public static extern c_int xmlSwitchToEncoding(xmlParserCtxtPtr ctxt, xmlCharEncodingHandlerPtr handler);

	[CLink, Obsolete("")] public static extern c_int xmlSwitchInputEncoding(xmlParserCtxtPtr ctxt, xmlParserInputPtr input, xmlCharEncodingHandlerPtr handler);

	/**
	* Input Streams.
	*/
	[CLink] public static extern xmlParserInputPtr xmlNewStringInputStream(xmlParserCtxtPtr ctxt, xmlChar* buffer);

	[CLink, Obsolete("")] public static extern xmlParserInputPtr xmlNewEntityInputStream(xmlParserCtxtPtr ctxt, xmlEntityPtr entity);
	[CLink] public static extern c_int xmlCtxtPushInput(xmlParserCtxtPtr ctxt, xmlParserInputPtr input);
	[CLink] public static extern xmlParserInputPtr xmlCtxtPopInput(xmlParserCtxtPtr ctxt);

	[CLink, Obsolete("")] public static extern c_int xmlPushInput(xmlParserCtxtPtr ctxt, xmlParserInputPtr input);

	[CLink, Obsolete("")] public static extern xmlChar xmlPopInput(xmlParserCtxtPtr ctxt);
	[CLink] public static extern void xmlFreeInputStream(xmlParserInputPtr input);
	[CLink] public static extern xmlParserInputPtr xmlNewInputFromFile(xmlParserCtxtPtr ctxt, char* filename);
	[CLink] public static extern xmlParserInputPtr xmlNewInputStream(xmlParserCtxtPtr ctxt);

	/**
	* Namespaces.
	*/
	[CLink] public static extern xmlChar* xmlSplitQName(xmlParserCtxtPtr ctxt, xmlChar* name, xmlChar** prefix);

	/**
	* Generic production rules.
	*/

	[CLink, Obsolete("")] public static extern xmlChar* xmlParseName(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseNmtoken(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseEntityValue(xmlParserCtxtPtr ctxt, xmlChar** orig);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseAttValue(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseSystemLiteral(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParsePubidLiteral(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseCharData(xmlParserCtxtPtr ctxt, c_int cdata);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseExternalID(xmlParserCtxtPtr ctxt, xmlChar** publicID, c_int strict);
	[CLink, Obsolete("")] public static extern void xmlParseComment(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParsePITarget(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParsePI(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseNotationDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseEntityDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlParseDefaultDecl(xmlParserCtxtPtr ctxt, xmlChar** value);
	[CLink, Obsolete("")] public static extern xmlEnumerationPtr xmlParseNotationType(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlEnumerationPtr xmlParseEnumerationType(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlParseEnumeratedType(xmlParserCtxtPtr ctxt, xmlEnumerationPtr* tree);
	[CLink, Obsolete("")] public static extern c_int xmlParseAttributeType(xmlParserCtxtPtr ctxt, xmlEnumerationPtr* tree);
	[CLink, Obsolete("")] public static extern void xmlParseAttributeListDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlElementContentPtr xmlParseElementMixedContentDecl(xmlParserCtxtPtr ctxt, c_int inputchk);
	[CLink, Obsolete("")] public static extern xmlElementContentPtr xmlParseElementChildrenContentDecl(xmlParserCtxtPtr ctxt, c_int inputchk);
	[CLink, Obsolete("")] public static extern c_int xmlParseElementContentDecl(xmlParserCtxtPtr ctxt, xmlChar* name, xmlElementContentPtr* result);
	[CLink, Obsolete("")] public static extern c_int xmlParseElementDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseMarkupDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlParseCharRef(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlEntityPtr xmlParseEntityRef(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseReference(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParsePEReference(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseDocTypeDecl(xmlParserCtxtPtr ctxt);

#if LIBXML_SAX1_ENABLED
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseAttribute(xmlParserCtxtPtr ctxt, xmlChar** value);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseStartTag(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseEndTag(xmlParserCtxtPtr ctxt);
#endif

	[CLink, Obsolete("")] public static extern void xmlParseCDSect(xmlParserCtxtPtr ctxt);

	[CLink] public static extern void xmlParseContent(xmlParserCtxtPtr ctxt);

	[CLink, Obsolete("")] public static extern void xmlParseElement(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseVersionNum(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseVersionInfo(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseEncName(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern xmlChar* xmlParseEncodingDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlParseSDDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseXMLDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseTextDecl(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseMisc(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParseExternalSubset(xmlParserCtxtPtr ctxt, xmlChar* ExternalID, xmlChar* SystemID);

	/**
	 * XML_SUBSTITUTE_NONE:
	 *
	 * If no entities need to be substituted.
	 */
	const c_int XML_SUBSTITUTE_NONE	= 0;
	/**
	 * XML_SUBSTITUTE_REF:
	 *
	 * Whether general entities need to be substituted.
	 */
	const c_int XML_SUBSTITUTE_REF	= 1;
	/**
	 * XML_SUBSTITUTE_PEREF:
	 *
	 * Whether parameter entities need to be substituted.
	 */
	const c_int XML_SUBSTITUTE_PEREF	= 2;
	/**
	 * XML_SUBSTITUTE_BOTH:
	 *
	 * Both general and parameter entities need to be substituted.
	 */
	const c_int XML_SUBSTITUTE_BOTH	= 3;


	[CLink, Obsolete("")] public static extern xmlChar* xmlStringDecodeEntities(xmlParserCtxtPtr ctxt, xmlChar* str, c_int what, xmlChar end, xmlChar  end2, xmlChar end3);
	[CLink, Obsolete("")] public static extern xmlChar* xmlStringLenDecodeEntities(xmlParserCtxtPtr ctxt, xmlChar* str, c_int len, c_int what, xmlChar end, xmlChar  end2, xmlChar end3);

	/*
	 * Generated by MACROS on top of parser.c c.f. PUSH_AND_POP.
	 */

	[CLink, Obsolete("")] public static extern c_int nodePush(xmlParserCtxtPtr ctxt, xmlNodePtr value);
	[CLink, Obsolete("")] public static extern xmlNodePtr nodePop(xmlParserCtxtPtr ctxt);

	[CLink] public static extern c_int inputPush(xmlParserCtxtPtr ctxt, xmlParserInputPtr value);
	[CLink] public static extern xmlParserInputPtr	inputPop(xmlParserCtxtPtr ctxt);

	[CLink, Obsolete("")] public static extern xmlChar*  namePop(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int namePush(xmlParserCtxtPtr ctxt, xmlChar* value);

	/*
	 * other commodities shared between parser.c and parserInternals.
	 */

	[CLink, Obsolete("")] public static extern c_int xmlSkipBlankChars(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlStringCurrentChar(xmlParserCtxtPtr ctxt, xmlChar* cur, c_int* len);
	[CLink, Obsolete("")] public static extern void xmlParserHandlePEReference(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlCheckLanguageID(xmlChar* lang);

	/*
	 * Really core function shared with HTML parser.
	 */

	[CLink, Obsolete("")] public static extern c_int xmlCurrentChar(xmlParserCtxtPtr ctxt, c_int* len);
	[CLink, Obsolete("")] public static extern c_int xmlCopyCharMultiByte(xmlChar* out_, c_int val);
	[CLink, Obsolete("")] public static extern c_int xmlCopyChar(c_int len, xmlChar* out_, c_int val);
	[CLink, Obsolete("")] public static extern void xmlNextChar(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void xmlParserInputShrink(xmlParserInputPtr in_);
}