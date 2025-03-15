/*
 * Summary: the XML document serializer
 * Description: API to save document or subtree of document
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_OUTPUT_ENABLED

extension libxml2
{
	/**
	* xmlSaveOption:
	*
	* This is the set of XML save options that can be passed down
	* to the xmlSaveToFd() and similar calls.
	*/
	public enum xmlSaveOption
	{
		XML_SAVE_FORMAT = 1 << 0, /* format save output */
		XML_SAVE_NO_DECL = 1 << 1, /* drop the xml declaration */
		XML_SAVE_NO_EMPTY = 1 << 2, /* no empty tags */
		XML_SAVE_NO_XHTML = 1 << 3, /* disable XHTML1 specific rules */
		XML_SAVE_XHTML = 1 << 4, /* force XHTML1 specific rules */
		XML_SAVE_AS_XML = 1 << 5, /* force XML serialization on HTML doc */
		XML_SAVE_AS_HTML = 1 << 6, /* force HTML serialization on XML doc */
		XML_SAVE_WSNONSIG = 1 << 7, /* format with non-significant whitespace */
		/* Available since 2.14.0 */
		XML_SAVE_EMPTY = 1 << 8, /* force empty tags, overriding global */
		XML_SAVE_NO_INDENT = 1 << 9, /* disable indenting */
		XML_SAVE_INDENT = 1 << 10 /* force indenting, overriding global */
	}

	[CRepr]
	public struct xmlSaveCtxt;

	typealias xmlSaveCtxtPtr = xmlSaveCtxt*;

	[CLink] public static extern xmlSaveCtxtPtr xmlSaveToFd(c_int fd, char* encoding, c_int options);
	[CLink] public static extern xmlSaveCtxtPtr xmlSaveToFilename	(char* filename, char* encoding, c_int options);

	[CLink] public static extern xmlSaveCtxtPtr xmlSaveToBuffer(xmlBufferPtr buffer, char* encoding, c_int options);

	[CLink] public static extern xmlSaveCtxtPtr xmlSaveToIO(xmlOutputWriteCallback iowrite, xmlOutputCloseCallback ioclose, void* ioctx, char* encoding, c_int options);

	[CLink] public static extern c_long xmlSaveDoc(xmlSaveCtxtPtr ctxt, xmlDocPtr doc);
	[CLink] public static extern c_long xmlSaveTree(xmlSaveCtxtPtr ctxt, xmlNodePtr node);

	[CLink] public static extern int xmlSaveFlush(xmlSaveCtxtPtr ctxt);
	[CLink] public static extern int xmlSaveClose(xmlSaveCtxtPtr ctxt);
	[CLink] public static extern int xmlSaveFinish(xmlSaveCtxtPtr ctxt);
	[CLink] public static extern int xmlSaveSetIndentString	(xmlSaveCtxtPtr ctxt, char* indent);

	[CLink, Obsolete("")] public static extern int xmlSaveSetEscape	(xmlSaveCtxtPtr ctxt, xmlCharEncodingOutputFunc escape);

	[CLink, Obsolete("")] public static extern int xmlSaveSetAttrEscape	(xmlSaveCtxtPtr ctxt, xmlCharEncodingOutputFunc escape);

	[CLink, Obsolete("")] public static extern int xmlThrDefIndentTreeOutput(c_int v);

	[CLink, Obsolete("")] public static extern char* xmlThrDefTreeIndentString(char* v);

	[CLink, Obsolete("")] public static extern int xmlThrDefSaveNoEmptyTags(c_int v);
}

#endif /* LIBXML_OUTPUT_ENABLED */ 