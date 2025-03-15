/*
 * Summary: text writing API for XML
 * Description: text writing API for XML
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Alfred Mickautsch <alfred@mickautsch.de>
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_WRITER_ENABLED

extension libxml2
{
	[CRepr]
	public struct xmlTextWriter;
	typealias xmlTextWriterPtr = xmlTextWriter*;

	/*
	* Constructors & Destructor
	*/
	[CLink] public static extern xmlTextWriterPtr xmlNewTextWriter(xmlOutputBufferPtr out_);
	[CLink] public static extern xmlTextWriterPtr xmlNewTextWriterFilename(char* uri, c_int compression);
	[CLink] public static extern xmlTextWriterPtr xmlNewTextWriterMemory(xmlBufferPtr buf, c_int compression);
	[CLink] public static extern xmlTextWriterPtr xmlNewTextWriterPushParser(xmlParserCtxtPtr ctxt, c_int compression);
	[CLink] public static extern xmlTextWriterPtr xmlNewTextWriterDoc(xmlDocPtr* doc, c_int compression);
	[CLink] public static extern xmlTextWriterPtr xmlNewTextWriterTree(xmlDocPtr doc, xmlNodePtr node, c_int compression);
	[CLink] public static extern void xmlFreeTextWriter(xmlTextWriterPtr writer);

	/*
	* Functions
	*/

	/*
	* Document
	*/
	[CLink] public static extern c_int xmlTextWriterStartDocument(xmlTextWriterPtr writer, char* version, char* encoding, char* standalone);
	[CLink] public static extern c_int xmlTextWriterEndDocument(xmlTextWriterPtr writer);

	/*
	* Comments
	*/
	[CLink] public static extern c_int xmlTextWriterStartComment(xmlTextWriterPtr writer);
	[CLink] public static extern c_int xmlTextWriterEndComment(xmlTextWriterPtr writer);
	[CLink] public static extern c_int xmlTextWriterWriteFormatComment(xmlTextWriterPtr writer, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatComment(xmlTextWriterPtr writer, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteComment(xmlTextWriterPtr writer, xmlChar* content);

	/*
	* Elements
	*/
	[CLink] public static extern c_int xmlTextWriterStartElement(xmlTextWriterPtr writer, xmlChar* name);
	[CLink] public static extern c_int xmlTextWriterStartElementNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI);
	[CLink] public static extern c_int xmlTextWriterEndElement(xmlTextWriterPtr writer);
	[CLink] public static extern c_int xmlTextWriterFullEndElement(xmlTextWriterPtr writer);

	/*
	* Elements conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatElement(xmlTextWriterPtr writer, xmlChar* name, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatElement(xmlTextWriterPtr writer, xmlChar* name, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteElement(xmlTextWriterPtr writer, xmlChar* name, xmlChar* content);
	[CLink] public static extern c_int xmlTextWriterWriteFormatElementNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatElementNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteElementNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI, xmlChar* content);

	/*
	* Text
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatRaw(xmlTextWriterPtr writer, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatRaw(xmlTextWriterPtr writer, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteRawLen(xmlTextWriterPtr writer, xmlChar* content, c_int len);
	[CLink] public static extern c_int xmlTextWriterWriteRaw(xmlTextWriterPtr writer, xmlChar* content);
	[CLink] public static extern c_int xmlTextWriterWriteFormatString(xmlTextWriterPtr writer, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatString(xmlTextWriterPtr writer, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteString(xmlTextWriterPtr writer, xmlChar* content);
	[CLink] public static extern c_int xmlTextWriterWriteBase64(xmlTextWriterPtr writer, char* data, c_int start, c_int len);
	[CLink] public static extern c_int xmlTextWriterWriteBinHex(xmlTextWriterPtr writer, char* data, c_int start, c_int len);

	/*
	* Attributes
	*/
	[CLink] public static extern c_int xmlTextWriterStartAttribute(xmlTextWriterPtr writer, xmlChar* name);
	[CLink] public static extern c_int xmlTextWriterStartAttributeNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI);
	[CLink] public static extern c_int xmlTextWriterEndAttribute(xmlTextWriterPtr writer);

	/*
	* Attributes conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatAttribute(xmlTextWriterPtr writer, xmlChar* name, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatAttribute(xmlTextWriterPtr writer, xmlChar* name, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteAttribute(xmlTextWriterPtr writer, xmlChar* name, xmlChar* content);
	[CLink] public static extern c_int xmlTextWriterWriteFormatAttributeNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatAttributeNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteAttributeNS(xmlTextWriterPtr writer, xmlChar* prefix, xmlChar* name, xmlChar* namespaceURI, xmlChar* content);

	/*
	* PI's
	*/
	[CLink] public static extern c_int xmlTextWriterStartPI(xmlTextWriterPtr writer, xmlChar* target);
	[CLink] public static extern c_int xmlTextWriterEndPI(xmlTextWriterPtr writer);

	/*
	* PI conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatPI(xmlTextWriterPtr writer, xmlChar* target, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatPI(xmlTextWriterPtr writer, xmlChar* target, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWritePI(xmlTextWriterPtr writer, xmlChar* target, xmlChar* content);

	/**
	* xmlTextWriterWriteProcessingInstruction:
	*
	* This macro maps to xmlTextWriterWritePI
	*/

	//#define xmlTextWriterWriteProcessingInstruction xmlTextWriterWritePI

	[LinkName("xmlTextWriterWritePI")]
	[CLink] public static extern c_int xmlTextWriterWriteProcessingInstruction(xmlTextWriterPtr writer, xmlChar* target, xmlChar* content);

	/*
	* CDATA
	*/
	[CLink] public static extern c_int xmlTextWriterStartCDATA(xmlTextWriterPtr writer);
	[CLink] public static extern c_int xmlTextWriterEndCDATA(xmlTextWriterPtr writer);

	/*
	* CDATA conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatCDATA(xmlTextWriterPtr writer, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatCDATA(xmlTextWriterPtr writer, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteCDATA(xmlTextWriterPtr writer, xmlChar* content);

	/*
	* DTD
	*/
	[CLink] public static extern c_int xmlTextWriterStartDTD(xmlTextWriterPtr writer, xmlChar* name, xmlChar* pubid, xmlChar* sysid);
	[CLink] public static extern c_int xmlTextWriterEndDTD(xmlTextWriterPtr writer);

	/*
	* DTD conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatDTD(xmlTextWriterPtr writer, xmlChar* name, xmlChar* pubid, xmlChar* sysid, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatDTD(xmlTextWriterPtr writer, xmlChar* name, xmlChar* pubid, xmlChar* sysid, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteDTD(xmlTextWriterPtr writer, xmlChar* name, xmlChar* pubid, xmlChar* sysid, xmlChar* subset);

	/**
	* xmlTextWriterWriteDocType:
	*
	* this macro maps to xmlTextWriterWriteDTD
	*/
	// #define xmlTextWriterWriteDocType xmlTextWriterWriteDTD

	/*
	* DTD element definition
	*/
	[CLink] public static extern c_int xmlTextWriterStartDTDElement(xmlTextWriterPtr writer, xmlChar* name);
	[CLink] public static extern c_int xmlTextWriterEndDTDElement(xmlTextWriterPtr writer);

	/*
	* DTD element definition conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatDTDElement(xmlTextWriterPtr writer, xmlChar* name, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatDTDElement(xmlTextWriterPtr writer, xmlChar* name, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteDTDElement(xmlTextWriterPtr writer, xmlChar* name, xmlChar* content);

	/*
	* DTD attribute list definition
	*/
	[CLink] public static extern c_int xmlTextWriterStartDTDAttlist(xmlTextWriterPtr writer, xmlChar* name);
	[CLink] public static extern c_int xmlTextWriterEndDTDAttlist(xmlTextWriterPtr writer);

	/*
	* DTD attribute list definition conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatDTDAttlist(xmlTextWriterPtr writer, xmlChar* name, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatDTDAttlist(xmlTextWriterPtr writer, xmlChar* name, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteDTDAttlist(xmlTextWriterPtr writer, xmlChar* name, xmlChar* content);

	/*
	* DTD entity definition
	*/
	[CLink] public static extern c_int xmlTextWriterStartDTDEntity(xmlTextWriterPtr writer, c_int pe, xmlChar* name);
	[CLink] public static extern c_int xmlTextWriterEndDTDEntity(xmlTextWriterPtr writer);

	/*
	* DTD entity definition conveniency functions
	*/
	[CLink] public static extern c_int xmlTextWriterWriteFormatDTDInternalEntity(xmlTextWriterPtr writer, c_int pe, xmlChar* name, char* format, ...);
	[CLink] public static extern c_int xmlTextWriterWriteVFormatDTDInternalEntity(xmlTextWriterPtr writer, c_int pe, xmlChar* name, char* format, va_list argptr);
	[CLink] public static extern c_int xmlTextWriterWriteDTDInternalEntity(xmlTextWriterPtr writer, c_int pe, xmlChar* name, xmlChar* content);
	[CLink] public static extern c_int xmlTextWriterWriteDTDExternalEntity(xmlTextWriterPtr writer, c_int pe, xmlChar* name, xmlChar* pubid, xmlChar* sysid, xmlChar* ndataid);
	[CLink] public static extern c_int xmlTextWriterWriteDTDExternalEntityContents(xmlTextWriterPtr writer, xmlChar* pubid, xmlChar* sysid, xmlChar* ndataid);
	[CLink] public static extern c_int xmlTextWriterWriteDTDEntity(xmlTextWriterPtr writer, c_int pe, xmlChar* name, xmlChar* pubid, xmlChar* sysid, xmlChar* ndataid, xmlChar* content);

	/*
	* DTD notation definition
	*/
	[CLink] public static extern c_int xmlTextWriterWriteDTDNotation(xmlTextWriterPtr writer, xmlChar* name, xmlChar* pubid, xmlChar* sysid);

	/*
	* Indentation
	*/
	[CLink] public static extern c_int xmlTextWriterSetIndent(xmlTextWriterPtr writer, c_int indent);
	[CLink] public static extern c_int xmlTextWriterSetIndentString(xmlTextWriterPtr writer, xmlChar* str);

	[CLink] public static extern c_int xmlTextWriterSetQuoteChar(xmlTextWriterPtr writer, xmlChar quotechar);

	/*
	* misc
	*/
	[CLink] public static extern c_int xmlTextWriterFlush(xmlTextWriterPtr writer);
	[CLink] public static extern c_int xmlTextWriterClose(xmlTextWriterPtr writer);
}

#endif /* LIBXML_WRITER_ENABLED */ 