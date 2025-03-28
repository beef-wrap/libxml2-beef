/*
 * Summary: interface for an HTML 4.0 non-verifying parser
 * Description: this module implements an HTML 4.0 non-verifying parser
 *              with API compatible with the XML parser ones. It should
 *              be able to parse "real world" HTML, even if severely
 *              broken from a specification point of view.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_HTML_ENABLED

extension libxml2
{
	/*
	 * Most of the back-end structures from XML and HTML are shared.
	 */
	typealias htmlParserCtxt = xmlParserCtxt;
	typealias htmlParserCtxtPtr = xmlParserCtxtPtr;
	typealias htmlParserNodeInfo = xmlParserNodeInfo;
	typealias htmlSAXHandler = xmlSAXHandler;
	typealias htmlSAXHandlerPtr = xmlSAXHandlerPtr;
	typealias htmlParserInput = xmlParserInput;
	typealias htmlParserInputPtr = xmlParserInputPtr;
	typealias htmlDocPtr = xmlDocPtr;
	typealias htmlNodePtr = xmlNodePtr;

	/*
	 * Internal description of an HTML element, representing HTML 4.01
	 * and XHTML 1.0 (which share the same structure).
	 */
	typealias htmlElemDescPtr = htmlElemDesc*;

	[CRepr]
	public struct htmlElemDesc
	{
		char* name; /* The tag name */
		char startTag; /* unused */
		char endTag; /* Whether the end tag can be implied */
		char saveEndTag; /* Whether the end tag should be saved */
		char empty; /* Is this an empty element ? */
		char depr; /* unused */
		char dtd; /* unused */
		char isinline; /* is this a block 0 or inline 1 element */
		char* desc; /* the description */

		char** subelts; /* XML_DEPRECATED_MEMBER */
		char* defaultsubelt; /* XML_DEPRECATED_MEMBER */
		char** attrs_opt; /* XML_DEPRECATED_MEMBER */
		char** attrs_depr; /* XML_DEPRECATED_MEMBER */
		char** attrs_req; /* XML_DEPRECATED_MEMBER */

		c_int dataMode;
	}

	/*
	 * Internal description of an HTML entity.
	 */
	typealias htmlEntityDescPtr = htmlEntityDesc*;

	[CRepr]
	public struct htmlEntityDesc
	{
		c_uint value; /* the UNICODE value for the character */
		char* name; /* The entity name */
		char* desc; /* the description */
	}

#if LIBXML_SAX1_ENABLED

	// XML_DEPRECATED XMLPUBVAR xmlSAXHandlerV1 htmlDefaultSAXHandler;

#if LIBXML_THREAD_ENABLED
	[CLink, Obsolete("")] public static extern xmlSAXHandlerV1* __htmlDefaultSAXHandler();
#endif

#endif
	
	/*
	 * There is only few public functions.
	 */
	[CLink, Obsolete("")] public static extern void htmlInitAutoClose();
	[CLink] public static extern htmlElemDesc * htmlTagLookup(xmlChar *tag);
	[CLink] public static extern htmlEntityDesc * htmlEntityLookup(xmlChar *name);
	[CLink] public static extern htmlEntityDesc * htmlEntityValueLookup(c_uint value);
	
	[CLink, Obsolete("")] public static extern int htmlIsAutoClosed(htmlDocPtr doc, htmlNodePtr elem);
	[CLink, Obsolete("")] public static extern int htmlAutoCloseTag(htmlDocPtr doc, xmlChar *name, htmlNodePtr elem);
	[CLink, Obsolete("")] public static extern htmlEntityDesc * htmlParseEntityRef(htmlParserCtxtPtr ctxt, xmlChar **str);
	[CLink, Obsolete("")] public static extern int htmlParseCharRef(htmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern void htmlParseElement(htmlParserCtxtPtr ctxt);
	
	[CLink] public static extern htmlParserCtxtPtr htmlNewParserCtxt();
	[CLink] public static extern htmlParserCtxtPtr htmlNewSAXParserCtxt(htmlSAXHandler *sax, void *userData);
	
	[CLink] public static extern htmlParserCtxtPtr htmlCreateMemoryParserCtxt(char* buffer, c_int size);
	
	[CLink] public static extern int htmlParseDocument(htmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern htmlDocPtr htmlSAXParseDoc(xmlChar *cur, char* encoding, htmlSAXHandlerPtr sax, void *userData);
	[CLink] public static extern htmlDocPtr htmlParseDoc(xmlChar *cur, char* encoding);
	[CLink] public static extern htmlParserCtxtPtr htmlCreateFileParserCtxt(char* filename, char* encoding);
	[CLink, Obsolete("")] public static extern htmlDocPtr htmlSAXParseFile(char* filename, char* encoding, htmlSAXHandlerPtr sax, void *userData);
	[CLink] public static extern htmlDocPtr htmlParseFile(char* filename, char* encoding);
	[CLink] public static extern int UTF8ToHtml(c_uchar* out_, c_int* outlen, c_uchar* in_, c_int* inlen);
	[CLink] public static extern int htmlEncodeEntities(c_uchar* out_, c_int* outlen, c_uchar* in_, c_int* inlen, c_int quoteChar);
	[CLink] public static extern int htmlIsScriptAttribute(xmlChar *name);
	[CLink, Obsolete("")] public static extern int htmlHandleOmittedElem(c_int val);
	
	#if LIBXML_PUSH_ENABLED
		/**
		* Interfaces for the Push mode.
		*/
		[CLink] public static extern htmlParserCtxtPtr htmlCreatePushParserCtxt(htmlSAXHandlerPtr sax, void *user_data, char* chunk, c_int size, char* filename, xmlCharEncoding enc);
		[CLink] public static extern int htmlParseChunk(htmlParserCtxtPtr ctxt, char* chunk, c_int size, c_int terminate);
	#endif /* LIBXML_PUSH_ENABLED */
	
	[CLink] public static extern void htmlFreeParserCtxt(htmlParserCtxtPtr ctxt);
	
	/*
	 * New set of simpler/more flexible APIs
	 */
	/**
	 * xmlParserOption:
	 *
	 * This is the set of XML parser options that can be passed down
	 * to the xmlReadDoc() and similar calls.
	 */
	public enum htmlParserOption  : c_int
	{
	    HTML_PARSE_RECOVER  = 1<<0, /* No effect */
	    HTML_PARSE_HTML5    = 1<<1, /* HTML5 support */
	    HTML_PARSE_NODEFDTD = 1<<2, /* do not default a doctype if not found */
	    HTML_PARSE_NOERROR	= 1<<5,	/* suppress error reports */
	    HTML_PARSE_NOWARNING= 1<<6,	/* suppress warning reports */
	    HTML_PARSE_PEDANTIC	= 1<<7,	/* No effect */
	    HTML_PARSE_NOBLANKS	= 1<<8,	/* remove blank nodes */
	    HTML_PARSE_NONET	= 1<<11,/* No effect */
	    HTML_PARSE_NOIMPLIED= 1<<13,/* Do not add implied html/body... elements */
	    HTML_PARSE_COMPACT  = 1<<16,/* compact small text nodes */
	    HTML_PARSE_HUGE     = 1<<19,/* relax any hardcoded limit from the parser */
	    HTML_PARSE_IGNORE_ENC=1<<21,/* ignore internal document encoding hint */
	    HTML_PARSE_BIG_LINES= 1<<22 /* Store big lines numbers in text PSVI field */
	}
	
	[CLink] public static extern void htmlCtxtReset(htmlParserCtxtPtr ctxt);
	[CLink] public static extern int htmlCtxtSetOptions(htmlParserCtxtPtr ctxt, c_int options);
	[CLink] public static extern int htmlCtxtUseOptions(htmlParserCtxtPtr ctxt, c_int options);
	[CLink] public static extern htmlDocPtr htmlReadDoc(xmlChar *cur, char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlReadFile(char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlReadMemory(char* buffer, c_int size, char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlReadFd(c_int fd, char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlReadIO(xmlInputReadCallback ioread, xmlInputCloseCallback ioclose, void *ioctx, char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlCtxtParseDocument(htmlParserCtxtPtr ctxt, xmlParserInputPtr input);
	[CLink] public static extern htmlDocPtr htmlCtxtReadDoc(xmlParserCtxtPtr ctxt, xmlChar *cur, char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlCtxtReadFile(xmlParserCtxtPtr ctxt, char* filename, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlCtxtReadMemory(xmlParserCtxtPtr ctxt, char* buffer, c_int size, char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlCtxtReadFd(xmlParserCtxtPtr ctxt, c_int fd, char* URL, char* encoding, c_int options);
	[CLink] public static extern htmlDocPtr htmlCtxtReadIO(xmlParserCtxtPtr ctxt, xmlInputReadCallback ioread, xmlInputCloseCallback ioclose, void *ioctx, char* URL, char* encoding, c_int options);
	
	/* deprecated content model
	 */
	public enum htmlStatus  : c_int
	{
	  HTML_NA = 0 ,		/* something we don't check at all */
	  HTML_INVALID = 0x1 ,
	  HTML_DEPRECATED = 0x2 ,
	  HTML_VALID = 0x4 ,
	  HTML_REQUIRED = 0xc /* VALID bit set so ( & HTML_VALID ) is TRUE */
	}
	
	/* Using htmlElemDesc rather than name here, to emphasise the fact
	   that otherwise there's a lookup overhead
	*/
	[CLink, Obsolete("")] public static extern htmlStatus htmlAttrAllowed(htmlElemDesc*, xmlChar*, int);
	[CLink, Obsolete("")] public static extern c_int htmlElementAllowedHere(htmlElemDesc*, xmlChar*);
	[CLink, Obsolete("")] public static extern htmlStatus htmlElementStatusHere(htmlElemDesc*, htmlElemDesc*);
	[CLink, Obsolete("")] public static extern htmlStatus htmlNodeStatus(htmlNodePtr, int);
	
	/**
	 * htmlDefaultSubelement:
	 * @elt: HTML element
	 *
	 * Returns the default subelement for this element
	 */
	// #define htmlDefaultSubelement(elt) elt->defaultsubelt
	/**
	 * htmlElementAllowedHereDesc:
	 * @parent: HTML parent element
	 * @elt: HTML element
	 *
	 * Checks whether an HTML element description may be a
	 * direct child of the specified element.
	 *
	 * Returns 1 if allowed; 0 otherwise.
	 */
	// #define htmlElementAllowedHereDesc(parent,elt) \
	// 	htmlElementAllowedHere((parent), (elt)->name)
	/**
	 * htmlRequiredAttrs:
	 * @elt: HTML element
	 *
	 * Returns the attributes required for the specified element.
	 */
	// #define htmlRequiredAttrs(elt) (elt)->attrs_req
}

#endif /* LIBXML_HTML_ENABLED */

