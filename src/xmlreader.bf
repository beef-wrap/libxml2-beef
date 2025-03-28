/*
 * Summary: the XMLReader implementation
 * Description: API of the XML streaming API based on C# interfaces.
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
	 * xmlParserSeverities:
	 *
	 * How severe an error callback is when the per-reader error callback API
	 * is used.
	 */
	public enum xmlParserSeverities : c_int
	{
		XML_PARSER_SEVERITY_VALIDITY_WARNING = 1,
		XML_PARSER_SEVERITY_VALIDITY_ERROR = 2,
		XML_PARSER_SEVERITY_WARNING = 3,
		XML_PARSER_SEVERITY_ERROR = 4
	}

#if LIBXML_READER_ENABLED

	/**
	 * xmlTextReaderMode:
	 *
	 * Internal state values for the reader.
	 */
	public enum xmlTextReaderMode : c_int
	{
		XML_TEXTREADER_MODE_INITIAL = 0,
		XML_TEXTREADER_MODE_INTERACTIVE = 1,
		XML_TEXTREADER_MODE_ERROR = 2,
		XML_TEXTREADER_MODE_EOF = 3,
		XML_TEXTREADER_MODE_CLOSED = 4,
		XML_TEXTREADER_MODE_READING = 5
	}

	/**
	 * xmlParserProperties:
	 *
	 * Some common options to use with xmlTextReaderSetParserProp, but it
	 * is better to use xmlParserOption and the xmlReaderNewxxx and
	 * xmlReaderForxxx APIs now.
	 */
	public enum xmlParserProperties : c_int
	{
		XML_PARSER_LOADDTD = 1,
		XML_PARSER_DEFAULTATTRS = 2,
		XML_PARSER_VALIDATE = 3,
		XML_PARSER_SUBST_ENTITIES = 4
	}

	/**
	 * xmlReaderTypes:
	 *
	 * Predefined constants for the different types of nodes.
	 */
	public enum xmlReaderTypes : c_int
	{
		XML_READER_TYPE_NONE = 0,
		XML_READER_TYPE_ELEMENT = 1,
		XML_READER_TYPE_ATTRIBUTE = 2,
		XML_READER_TYPE_TEXT = 3,
		XML_READER_TYPE_CDATA = 4,
		XML_READER_TYPE_ENTITY_REFERENCE = 5,
		XML_READER_TYPE_ENTITY = 6,
		XML_READER_TYPE_PROCESSING_INSTRUCTION = 7,
		XML_READER_TYPE_COMMENT = 8,
		XML_READER_TYPE_DOCUMENT = 9,
		XML_READER_TYPE_DOCUMENT_TYPE = 10,
		XML_READER_TYPE_DOCUMENT_FRAGMENT = 11,
		XML_READER_TYPE_NOTATION = 12,
		XML_READER_TYPE_WHITESPACE = 13,
		XML_READER_TYPE_SIGNIFICANT_WHITESPACE = 14,
		XML_READER_TYPE_END_ELEMENT = 15,
		XML_READER_TYPE_END_ENTITY = 16,
		XML_READER_TYPE_XML_DECLARATION = 17
	}

	/**
	 * xmlTextReader:
	 *
	 * Structure for an xmlReader context.
	 */
	[CRepr]
	public struct xmlTextReader;

	/**
	 * xmlTextReaderPtr:
	 *
	 * Pointer to an xmlReader context.
	 */
	public typealias xmlTextReaderPtr = xmlTextReader*;

	/*
	 * Constructors & Destructor
	 */
	[CLink] public static extern xmlTextReaderPtr xmlNewTextReader(xmlParserInputBufferPtr input, char* URI);
	[CLink] public static extern xmlTextReaderPtr xmlNewTextReaderFilename(char* URI);

	[CLink] public static extern void xmlFreeTextReader(xmlTextReaderPtr reader);

	[CLink] public static extern c_int xmlTextReaderSetup(xmlTextReaderPtr reader, xmlParserInputBufferPtr input, char* URL, char* encoding, c_int options);
	[CLink] public static extern void xmlTextReaderSetMaxAmplification(xmlTextReaderPtr reader, c_uint maxAmpl);
	[CLink] public static extern xmlError* xmlTextReaderGetLastError(xmlTextReaderPtr reader);

	/*
	 * Iterators
	 */
	[CLink] public static extern c_int xmlTextReaderRead(xmlTextReaderPtr reader);

#if LIBXML_WRITER_ENABLED
	[CLink] public static extern xmlChar* xmlTextReaderReadInnerXml(xmlTextReaderPtr reader);

	[CLink] public static extern xmlChar* xmlTextReaderReadOuterXml(xmlTextReaderPtr reader);
#endif

	[CLink] public static extern xmlChar* xmlTextReaderReadString(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderReadAttributeValue(xmlTextReaderPtr reader);

	/*
	 * Attributes of the node
	 */
	[CLink] public static extern c_int xmlTextReaderAttributeCount(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderDepth(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderHasAttributes(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderHasValue(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderIsDefault(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderIsEmptyElement(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderNodeType(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderQuoteChar(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderReadState(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderIsNamespaceDecl(xmlTextReaderPtr reader);

	[CLink] public static extern xmlChar* xmlTextReaderConstBaseUri(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderConstLocalName(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderConstName(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderConstNamespaceUri(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderConstPrefix(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderConstXmlLang(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderConstString(xmlTextReaderPtr reader, xmlChar* str);
	[CLink] public static extern xmlChar* xmlTextReaderConstValue(xmlTextReaderPtr reader);

	/*
	 * use the version of the routine for
	 * better performance and simpler code
	 */
	[CLink] public static extern xmlChar* xmlTextReaderBaseUri(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderLocalName(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderName(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderNamespaceUri(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderPrefix(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderXmlLang(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderValue(xmlTextReaderPtr reader);

	/*
	 * Methods of the XmlTextReader
	 */
	[CLink] public static extern c_int xmlTextReaderClose(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderGetAttributeNo(xmlTextReaderPtr reader, c_int no);
	[CLink] public static extern xmlChar* xmlTextReaderGetAttribute(xmlTextReaderPtr reader, xmlChar* name);
	[CLink] public static extern xmlChar* xmlTextReaderGetAttributeNs(xmlTextReaderPtr reader, xmlChar* localName, xmlChar* namespaceURI);
	[CLink] public static extern xmlParserInputBufferPtr xmlTextReaderGetRemainder(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderLookupNamespace(xmlTextReaderPtr reader, xmlChar* prefix);
	[CLink] public static extern c_int xmlTextReaderMoveToAttributeNo(xmlTextReaderPtr reader, c_int no);
	[CLink] public static extern c_int xmlTextReaderMoveToAttribute(xmlTextReaderPtr reader, xmlChar* name);
	[CLink] public static extern c_int xmlTextReaderMoveToAttributeNs(xmlTextReaderPtr reader, xmlChar* localName, xmlChar* namespaceURI);
	[CLink] public static extern c_int xmlTextReaderMoveToFirstAttribute(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderMoveToNextAttribute(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderMoveToElement(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderNormalization(xmlTextReaderPtr reader);
	[CLink] public static extern xmlChar* xmlTextReaderConstEncoding  (xmlTextReaderPtr reader);

	/*
	 * Extensions
	 */
	[CLink] public static extern c_int xmlTextReaderSetParserProp(xmlTextReaderPtr reader, c_int prop, c_int value);
	[CLink] public static extern c_int xmlTextReaderGetParserProp(xmlTextReaderPtr reader, c_int prop);
	[CLink] public static extern xmlNodePtr xmlTextReaderCurrentNode(xmlTextReaderPtr reader);

	[CLink] public static extern c_int xmlTextReaderGetParserLineNumber(xmlTextReaderPtr reader);

	[CLink] public static extern c_int xmlTextReaderGetParserColumnNumber(xmlTextReaderPtr reader);

	[CLink] public static extern xmlNodePtr xmlTextReaderPreserve(xmlTextReaderPtr reader);

#if LIBXML_PATTERN_ENABLED
	[CLink] public static extern c_int xmlTextReaderPreservePattern(xmlTextReaderPtr reader, xmlChar* pattern, xmlChar** namespaces);
#endif /* LIBXML_PATTERN_ENABLED */ 

	[CLink] public static extern xmlDocPtr xmlTextReaderCurrentDoc(xmlTextReaderPtr reader);
	[CLink] public static extern xmlNodePtr xmlTextReaderExpand(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderNext(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderNextSibling(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderIsValid(xmlTextReaderPtr reader);

#if LIBXML_SCHEMAS_ENABLED
	[CLink] public static extern c_int xmlTextReaderRelaxNGValidate(xmlTextReaderPtr reader, char *rng);
	[CLink] public static extern c_int xmlTextReaderRelaxNGValidateCtxt(xmlTextReaderPtr reader, xmlRelaxNGValidCtxtPtr ctxt, c_int options);
	
	[CLink] public static extern c_int xmlTextReaderRelaxNGSetSchema(xmlTextReaderPtr reader, xmlRelaxNGPtr schema);
	[CLink] public static extern c_int xmlTextReaderSchemaValidate(xmlTextReaderPtr reader, char *xsd);
	[CLink] public static extern c_int xmlTextReaderSchemaValidateCtxt(xmlTextReaderPtr reader, xmlSchemaValidCtxtPtr ctxt, c_int options);
	[CLink] public static extern c_int xmlTextReaderSetSchema(xmlTextReaderPtr reader, xmlSchemaPtr schema);
#endif

	[CLink] public static extern xmlChar * xmlTextReaderConstXmlVersion(xmlTextReaderPtr reader);
	[CLink] public static extern c_int xmlTextReaderStandalone(xmlTextReaderPtr reader);
	
	/*
	 * Index lookup
	 */
	[CLink] public static extern c_long xmlTextReaderByteConsumed(xmlTextReaderPtr reader);
	
	/*
	 * New more complete APIs for simpler creation and reuse of readers
	 */
	[CLink] public static extern xmlTextReaderPtr xmlReaderWalker(xmlDocPtr doc);
	[CLink] public static extern xmlTextReaderPtr xmlReaderForDoc(xmlChar * cur, char *URL, char *encoding, c_int options);
	[CLink] public static extern xmlTextReaderPtr xmlReaderForFile(char *filename, char *encoding, c_int options);
	[CLink] public static extern xmlTextReaderPtr xmlReaderForMemory(char *buffer, c_int size, char *URL, char *encoding, c_int options);
	[CLink] public static extern xmlTextReaderPtr xmlReaderForFd(c_int fd, char *URL, char *encoding, c_int options);
	[CLink] public static extern xmlTextReaderPtr xmlReaderForIO(xmlInputReadCallback ioread, xmlInputCloseCallback ioclose, void *ioctx, char *URL, char *encoding, c_int options);
	
	[CLink] public static extern c_int xmlReaderNewWalker(xmlTextReaderPtr reader, xmlDocPtr doc);
	[CLink] public static extern c_int xmlReaderNewDoc(xmlTextReaderPtr reader, xmlChar * cur, char *URL, char *encoding, c_int options);
	[CLink] public static extern c_int xmlReaderNewFile(xmlTextReaderPtr reader, char *filename, char *encoding, c_int options);
	[CLink] public static extern c_int xmlReaderNewMemory(xmlTextReaderPtr reader, char *buffer, c_int size, char *URL, char *encoding, c_int options);
	[CLink] public static extern c_int xmlReaderNewFd(xmlTextReaderPtr reader, c_int fd, char *URL, char *encoding, c_int options);
	[CLink] public static extern c_int xmlReaderNewIO(xmlTextReaderPtr reader, xmlInputReadCallback ioread, xmlInputCloseCallback ioclose, void *ioctx, char *URL, char *encoding, c_int options);
	/*
	 * Error handling extensions
	 */
	typealias xmlTextReaderLocatorPtr = void *  ;
	
	/**
	 * xmlTextReaderErrorFunc:
	 * @arg: the user argument
	 * @msg: the message
	 * @severity: the severity of the error
	 * @locator: a locator indicating where the error occurred
	 *
	 * Signature of an error callback from a reader parser
	 */
	public function void xmlTextReaderErrorFunc(void *arg, char *msg, xmlParserSeverities severity, xmlTextReaderLocatorPtr locator);

	[CLink] public static extern c_int xmlTextReaderLocatorLineNumber(xmlTextReaderLocatorPtr locator);
	[CLink] public static extern xmlChar * xmlTextReaderLocatorBaseURI (xmlTextReaderLocatorPtr locator);
	[CLink] public static extern void xmlTextReaderSetErrorHandler(xmlTextReaderPtr reader, xmlTextReaderErrorFunc f, void *arg);
	[CLink] public static extern void xmlTextReaderSetStructuredErrorHandler(xmlTextReaderPtr reader, xmlStructuredErrorFunc f, void *arg);
	[CLink] public static extern void xmlTextReaderGetErrorHandler(xmlTextReaderPtr reader, xmlTextReaderErrorFunc *f, void **arg);
	
	[CLink] public static extern void xmlTextReaderSetResourceLoader(xmlTextReaderPtr reader,   xmlResourceLoader loader,   void *data);

#endif /* LIBXML_READER_ENABLED */
}