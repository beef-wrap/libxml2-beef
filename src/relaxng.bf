/*
 * Summary: implementation of the Relax-NG validation
 * Description: implementation of the Relax-NG validation
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */
 
using System;
using System.Interop;

#if LIBXML_SCHEMAS_ENABLED

namespace libxml2;

extension libxml2
{
	public struct xmlRelaxNG;
	typealias xmlRelaxNGPtr = xmlRelaxNG*;

	/**
	 * xmlRelaxNGValidityErrorFunc:
	 * @ctx: the validation context
	 * @msg: the message
	 * @...: extra arguments
	 *
	 * Signature of an error callback from a Relax-NG validation
	 */
	public function void xmlRelaxNGValidityErrorFunc(void* ctx, char* msg, ...);

	/**
	 * xmlRelaxNGValidityWarningFunc:
	 * @ctx: the validation context
	 * @msg: the message
	 * @...: extra arguments
	 *
	 * Signature of a warning callback from a Relax-NG validation
	 */
	public function void xmlRelaxNGValidityWarningFunc(void* ctx, char* msg, ...);

	/**
	 * A schemas validation context
	 */
	public struct xmlRelaxNGParserCtxt;
	typealias xmlRelaxNGParserCtxtPtr = xmlRelaxNGParserCtxt*;

	public struct xmlRelaxNGValidCtxt;
	typealias xmlRelaxNGValidCtxtPtr = xmlRelaxNGValidCtxt*;

	/*
	 * xmlRelaxNGValidErr:
	 *
	 * List of possible Relax NG validation errors
	 */
	public enum xmlRelaxNGValidErr : c_int
	{
		XML_RELAXNG_OK = 0,
		XML_RELAXNG_ERR_MEMORY,
		XML_RELAXNG_ERR_TYPE,
		XML_RELAXNG_ERR_TYPEVAL,
		XML_RELAXNG_ERR_DUPID,
		XML_RELAXNG_ERR_TYPECMP,
		XML_RELAXNG_ERR_NOSTATE,
		XML_RELAXNG_ERR_NODEFINE,
		XML_RELAXNG_ERR_LISTEXTRA,
		XML_RELAXNG_ERR_LISTEMPTY,
		XML_RELAXNG_ERR_INTERNODATA,
		XML_RELAXNG_ERR_INTERSEQ,
		XML_RELAXNG_ERR_INTEREXTRA,
		XML_RELAXNG_ERR_ELEMNAME,
		XML_RELAXNG_ERR_ATTRNAME,
		XML_RELAXNG_ERR_ELEMNONS,
		XML_RELAXNG_ERR_ATTRNONS,
		XML_RELAXNG_ERR_ELEMWRONGNS,
		XML_RELAXNG_ERR_ATTRWRONGNS,
		XML_RELAXNG_ERR_ELEMEXTRANS,
		XML_RELAXNG_ERR_ATTREXTRANS,
		XML_RELAXNG_ERR_ELEMNOTEMPTY,
		XML_RELAXNG_ERR_NOELEM,
		XML_RELAXNG_ERR_NOTELEM,
		XML_RELAXNG_ERR_ATTRVALID,
		XML_RELAXNG_ERR_CONTENTVALID,
		XML_RELAXNG_ERR_EXTRACONTENT,
		XML_RELAXNG_ERR_INVALIDATTR,
		XML_RELAXNG_ERR_DATAELEM,
		XML_RELAXNG_ERR_VALELEM,
		XML_RELAXNG_ERR_LISTELEM,
		XML_RELAXNG_ERR_DATATYPE,
		XML_RELAXNG_ERR_VALUE,
		XML_RELAXNG_ERR_LIST,
		XML_RELAXNG_ERR_NOGRAMMAR,
		XML_RELAXNG_ERR_EXTRADATA,
		XML_RELAXNG_ERR_LACKDATA,
		XML_RELAXNG_ERR_INTERNAL,
		XML_RELAXNG_ERR_ELEMWRONG,
		XML_RELAXNG_ERR_TEXTWRONG
	}

	/*
	 * xmlRelaxNGParserFlags:
	 *
	 * List of possible Relax NG Parser flags
	 */
	public enum xmlRelaxNGParserFlag : c_int
	{
		XML_RELAXNGP_NONE = 0,
		XML_RELAXNGP_FREE_DOC = 1,
		XML_RELAXNGP_CRNG = 2
	}

	[CLink] public static extern int xmlRelaxNGInitTypes(void);

	[CLink, Obsolete("")] public static extern void xmlRelaxNGCleanupTypes(void);

	/*
	 * Interfaces for parsing.
	 */
	[CLink] public static extern xmlRelaxNGParserCtxtPtr xmlRelaxNGNewParserCtxt(char* URL);
	[CLink] public static extern xmlRelaxNGParserCtxtPtr xmlRelaxNGNewMemParserCtxt(char* buffer, c_int size);
	[CLink] public static extern xmlRelaxNGParserCtxtPtr xmlRelaxNGNewDocParserCtxt(xmlDocPtr doc);

	[CLink] public static extern int xmlRelaxParserSetFlag(xmlRelaxNGParserCtxtPtr ctxt, c_int flag);

	[CLink] public static extern void xmlRelaxNGFreeParserCtxt(xmlRelaxNGParserCtxtPtr ctxt);
	[CLink] public static extern void xmlRelaxNGSetParserError(xmlRelaxNGParserCtxtPtr ctxt, xmlRelaxNGValidityErrorFunc err, xmlRelaxNGValidityWarningFunc warn, void* ctx);
	[CLink] public static extern int xmlRelaxNGGetParserError(xmlRelaxNGParserCtxtPtr ctxt, xmlRelaxNGValidityErrorFunc* err, xmlRelaxNGValidityWarningFunc* warn, void** ctx);
	[CLink] public static extern void xmlRelaxNGSetParserStructuredError(xmlRelaxNGParserCtxtPtr ctxt, xmlStructuredErrorFunc serror, void* ctx);
	[CLink] public static extern void xmlRelaxNGSetResourceLoader(xmlRelaxNGParserCtxtPtr ctxt, xmlResourceLoader loader, void* vctxt);
	[CLink] public static extern xmlRelaxNGPtr xmlRelaxNGParse(xmlRelaxNGParserCtxtPtr ctxt);
	[CLink] public static extern void xmlRelaxNGFree(xmlRelaxNGPtr schema);

#if LIBXML_OUTPUT_ENABLED
		[CLink] public static extern void xmlRelaxNGDump(FILE *output, xmlRelaxNGPtr schema);
		[CLink] public static extern void xmlRelaxNGDumpTree(FILE * output, xmlRelaxNGPtr schema);
#endif /* LIBXML_OUTPUT_ENABLED */

	/*
	 * Interfaces for validating
	 */
	[CLink] public static extern void xmlRelaxNGSetValidError(xmlRelaxNGValidCtxtPtr ctxt, xmlRelaxNGValidityErrorFunc err, xmlRelaxNGValidityWarningFunc warn, void* ctx);
	[CLink] public static extern int xmlRelaxNGGetValidError(xmlRelaxNGValidCtxtPtr ctxt, xmlRelaxNGValidityErrorFunc* err, xmlRelaxNGValidityWarningFunc* warn, void** ctx);
	[CLink] public static extern void xmlRelaxNGSetValidStructuredError(xmlRelaxNGValidCtxtPtr ctxt,  xmlStructuredErrorFunc serror, void* ctx);
	[CLink] public static extern xmlRelaxNGValidCtxtPtr xmlRelaxNGNewValidCtxt(xmlRelaxNGPtr schema);
	[CLink] public static extern void xmlRelaxNGFreeValidCtxt(xmlRelaxNGValidCtxtPtr ctxt);
	[CLink] public static extern int xmlRelaxNGValidateDoc(xmlRelaxNGValidCtxtPtr ctxt, xmlDocPtr doc);

	/*
	 * Interfaces for progressive validation when possible
	 */
	[CLink] public static extern int xmlRelaxNGValidatePushElement(xmlRelaxNGValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem);
	[CLink] public static extern int xmlRelaxNGValidatePushCData(xmlRelaxNGValidCtxtPtr ctxt, xmlChar* data, c_int len);
	[CLink] public static extern int xmlRelaxNGValidatePopElement(xmlRelaxNGValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem);
	[CLink] public static extern int xmlRelaxNGValidateFullElement(xmlRelaxNGValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem);
}

#endif /* LIBXML_SCHEMAS_ENABLED */ 
