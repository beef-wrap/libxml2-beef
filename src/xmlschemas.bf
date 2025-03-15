/*
 * Summary: incomplete XML Schemas structure implementation
 * Description: interface to the XML Schemas handling and schema validity
 *              checking, it is incomplete right now.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */


using System;
using System.Interop;

namespace libxml2;

#if LIBXML_SCHEMAS_ENABLED

extension libxml2
{
	/**
	* This error codes are obsolete; not used any more.
	*/
	public enum xmlSchemaValidError
	{
		XML_SCHEMAS_ERR_OK		= 0,
		XML_SCHEMAS_ERR_NOROOT	= 1,
		XML_SCHEMAS_ERR_UNDECLAREDELEM,
		XML_SCHEMAS_ERR_NOTTOPLEVEL,
		XML_SCHEMAS_ERR_MISSING,
		XML_SCHEMAS_ERR_WRONGELEM,
		XML_SCHEMAS_ERR_NOTYPE,
		XML_SCHEMAS_ERR_NOROLLBACK,
		XML_SCHEMAS_ERR_ISABSTRACT,
		XML_SCHEMAS_ERR_NOTEMPTY,
		XML_SCHEMAS_ERR_ELEMCONT,
		XML_SCHEMAS_ERR_HAVEDEFAULT,
		XML_SCHEMAS_ERR_NOTNILLABLE,
		XML_SCHEMAS_ERR_EXTRACONTENT,
		XML_SCHEMAS_ERR_INVALIDATTR,
		XML_SCHEMAS_ERR_INVALIDELEM,
		XML_SCHEMAS_ERR_NOTDETERMINIST,
		XML_SCHEMAS_ERR_CONSTRUCT,
		XML_SCHEMAS_ERR_INTERNAL,
		XML_SCHEMAS_ERR_NOTSIMPLE,
		XML_SCHEMAS_ERR_ATTRUNKNOWN,
		XML_SCHEMAS_ERR_ATTRINVALID,
		XML_SCHEMAS_ERR_VALUE,
		XML_SCHEMAS_ERR_FACET,
		XML_SCHEMAS_ERR_,
		XML_SCHEMAS_ERR_XXX
	}

	/*
	* ATTENTION: Change xmlSchemaSetValidOptions's check
	* for invalid values, if adding to the validation
	* options below.
	*/
	/**
	* xmlSchemaValidOption:
	*
	* This is the set of XML Schema validation options.
	*/
	public enum xmlSchemaValidOption
	{
		XML_SCHEMA_VAL_VC_I_CREATE			= 1 << 0
		/* Default/fixed: create an attribute node
		* or an element's text node on the instance.
		*/
	}

	/*
		XML_SCHEMA_VAL_XSI_ASSEMBLE			= 1<<1,
		* assemble schemata using
		* xsi:schemaLocation and
		* xsi:noNamespaceSchemaLocation
	*/

	/**
	* The schemas related types are kept internal
	*/
	typealias xmlSchemaPtr = xmlSchema*;

	/**
	* xmlSchemaValidityErrorFunc:
	* @ctx: the validation context
	* @msg: the message
	* @...: extra arguments
	*
	* Signature of an error callback from an XSD validation
	*/
	public function void xmlSchemaValidityErrorFunc(void* ctx, char* msg, ...);

	/**
	* xmlSchemaValidityWarningFunc:
	* @ctx: the validation context
	* @msg: the message
	* @...: extra arguments
	*
	* Signature of a warning callback from an XSD validation
	*/
	public function void xmlSchemaValidityWarningFunc(void* ctx, char* msg, ...);

	/**
	* A schemas validation context
	*/
	public struct xmlSchemaParserCtxt;
	typealias xmlSchemaParserCtxtPtr = xmlSchemaParserCtxt*;

	public struct xmlSchemaValidCtxt;
	typealias xmlSchemaValidCtxtPtr = xmlSchemaValidCtxt*;

	/**
	* xmlSchemaValidityLocatorFunc:
	* @ctx: user provided context
	* @file: returned file information
	* @line: returned line information
	*
	* A schemas validation locator, a callback called by the validator.
	* This is used when file or node information are not available
	* to find out what file and line number are affected
	*
	* Returns: 0 in case of success and -1 in case of error
	*/

	public function c_int xmlSchemaValidityLocatorFunc(void* ctx, char** file, c_ulong* line);

	/*
	* Interfaces for parsing.
	*/
	[CLink] public static extern xmlSchemaParserCtxtPtr xmlSchemaNewParserCtxt(char* URL);
	[CLink] public static extern xmlSchemaParserCtxtPtr xmlSchemaNewMemParserCtxt(char* buffer, c_int size);
	[CLink] public static extern xmlSchemaParserCtxtPtr xmlSchemaNewDocParserCtxt(xmlDocPtr doc);
	[CLink] public static extern void xmlSchemaFreeParserCtxt(xmlSchemaParserCtxtPtr ctxt);
	[CLink] public static extern void xmlSchemaSetParserErrors(xmlSchemaParserCtxtPtr ctxt, xmlSchemaValidityErrorFunc err, xmlSchemaValidityWarningFunc warn, void* ctx);
	[CLink] public static extern void xmlSchemaSetParserStructuredErrors(xmlSchemaParserCtxtPtr ctxt, xmlStructuredErrorFunc serror, void* ctx);
	[CLink] public static extern int xmlSchemaGetParserErrors(xmlSchemaParserCtxtPtr ctxt, xmlSchemaValidityErrorFunc* err, xmlSchemaValidityWarningFunc* warn, void** ctx);
	[CLink] public static extern void xmlSchemaSetResourceLoader(xmlSchemaParserCtxtPtr ctxt, xmlResourceLoader loader, void* data);
	[CLink] public static extern int xmlSchemaIsValid(xmlSchemaValidCtxtPtr ctxt);

	[CLink] public static extern xmlSchemaPtr xmlSchemaParse(xmlSchemaParserCtxtPtr ctxt);
	[CLink] public static extern void xmlSchemaFree(xmlSchemaPtr schema);

#if LIBXML_OUTPUT_ENABLED
	[CLink] public static extern void xmlSchemaDump(FILE* output, xmlSchemaPtr schema);
#endif

	/*
	* Interfaces for validating
	*/
	[CLink] public static extern void xmlSchemaSetValidErrors(xmlSchemaValidCtxtPtr ctxt, xmlSchemaValidityErrorFunc err, xmlSchemaValidityWarningFunc warn, void* ctx);
	[CLink] public static extern void xmlSchemaSetValidStructuredErrors(xmlSchemaValidCtxtPtr ctxt, xmlStructuredErrorFunc serror, void* ctx);
	[CLink] public static extern int xmlSchemaGetValidErrors(xmlSchemaValidCtxtPtr ctxt, xmlSchemaValidityErrorFunc* err, xmlSchemaValidityWarningFunc* warn, void** ctx);
	[CLink] public static extern int xmlSchemaSetValidOptions(xmlSchemaValidCtxtPtr ctxt, c_int options);
	[CLink] public static extern void xmlSchemaValidateSetFilename(xmlSchemaValidCtxtPtr vctxt, char* filename);
	[CLink] public static extern int xmlSchemaValidCtxtGetOptions(xmlSchemaValidCtxtPtr ctxt);

	[CLink] public static extern xmlSchemaValidCtxtPtr xmlSchemaNewValidCtxt(xmlSchemaPtr schema);
	[CLink] public static extern void xmlSchemaFreeValidCtxt(xmlSchemaValidCtxtPtr ctxt);
	[CLink] public static extern int xmlSchemaValidateDoc(xmlSchemaValidCtxtPtr ctxt, xmlDocPtr instance);
	[CLink] public static extern int xmlSchemaValidateOneElement(xmlSchemaValidCtxtPtr ctxt, xmlNodePtr elem);
	[CLink] public static extern int xmlSchemaValidateStream(xmlSchemaValidCtxtPtr ctxt, xmlParserInputBufferPtr input, xmlCharEncoding enc, xmlSAXHandler* sax, void* user_data);
	[CLink] public static extern int xmlSchemaValidateFile(xmlSchemaValidCtxtPtr ctxt, char*  filename, c_int options);

	[CLink] public static extern xmlParserCtxtPtr xmlSchemaValidCtxtGetParserCtxt(xmlSchemaValidCtxtPtr ctxt);

	/*
	* Interface to insert Schemas SAX validation in a SAX stream
	*/
	public struct xmlSchemaSAXPlugStruct;
	typealias xmlSchemaSAXPlugPtr = xmlSchemaSAXPlugStruct*;

	[CLink] public static extern xmlSchemaSAXPlugPtr xmlSchemaSAXPlug(xmlSchemaValidCtxtPtr ctxt, xmlSAXHandlerPtr* sax, void** user_data);
	[CLink] public static extern int xmlSchemaSAXUnplug(xmlSchemaSAXPlugPtr plug);

	[CLink] public static extern void xmlSchemaValidateSetLocator(xmlSchemaValidCtxtPtr vctxt, xmlSchemaValidityLocatorFunc f, void* ctxt);
}

#endif /* LIBXML_SCHEMAS_ENABLED */ 