/*
 * Summary: XML Schematron implementation
 * Description: interface to the XML Schematron validity checking.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_SCHEMATRON_ENABLED

extension libxml2
{
	public enum xmlSchematronValidOptions
	{
		XML_SCHEMATRON_OUT_QUIET = 1 << 0, /* quiet no report */
		XML_SCHEMATRON_OUT_TEXT = 1 << 1, /* build a textual report */
		XML_SCHEMATRON_OUT_XML = 1 << 2, /* output SVRL */
		XML_SCHEMATRON_OUT_ERROR = 1 << 3, /* output via xmlStructuredErrorFunc */
		XML_SCHEMATRON_OUT_FILE = 1 << 8, /* output to a file descriptor */
		XML_SCHEMATRON_OUT_BUFFER = 1 << 9, /* output to a buffer */
		XML_SCHEMATRON_OUT_IO = 1 << 10 /* output to I/O mechanism */
	}

	/**
	* The schemas related types are kept internal
	*/
	[CRepr]
	public struct xmlSchematron;
	typealias xmlSchematronPtr = xmlSchematron*;

	/**
	* xmlSchematronValidityErrorFunc:
	* @ctx: the validation context
	* @msg: the message
	* @...: extra arguments
	*
	* Signature of an error callback from a Schematron validation
	*/
	public function void xmlSchematronValidityErrorFunc(void* ctx, char* msg, ...);

	/**
	* xmlSchematronValidityWarningFunc:
	* @ctx: the validation context
	* @msg: the message
	* @...: extra arguments
	*
	* Signature of a warning callback from a Schematron validation
	*/
	public function void xmlSchematronValidityWarningFunc(void* ctx, char* msg, ...);

	/**
	* A schemas validation context
	*/
	public struct xmlSchematronParserCtxt;
	typealias xmlSchematronParserCtxtPtr = xmlSchematronParserCtxt*;

	public struct xmlSchematronValidCtxt;
	typealias xmlSchematronValidCtxtPtr = xmlSchematronValidCtxt*;

	/*
	* Interfaces for parsing.
	*/
	[CLink] public static extern xmlSchematronParserCtxtPtr xmlSchematronNewParserCtxt(char* URL);
	[CLink] public static extern xmlSchematronParserCtxtPtr xmlSchematronNewMemParserCtxt(char* buffer, c_int size);
	[CLink] public static extern xmlSchematronParserCtxtPtr xmlSchematronNewDocParserCtxt(xmlDocPtr doc);
	[CLink] public static extern void xmlSchematronFreeParserCtxt(xmlSchematronParserCtxtPtr ctxt);
	/*****
	[CLink] public static extern void xmlSchematronSetParserErrors(xmlSchematronParserCtxtPtr ctxt, xmlSchematronValidityErrorFunc err, xmlSchematronValidityWarningFunc warn, void* ctx);
	[CLink] public static extern int xmlSchematronGetParserErrors(xmlSchematronParserCtxtPtr ctxt, xmlSchematronValidityErrorFunc* err, xmlSchematronValidityWarningFunc* warn, void** ctx);
	[CLink] public static extern int xmlSchematronIsValid(xmlSchematronValidCtxtPtr ctxt);
	*****/
	[CLink] public static extern xmlSchematronPtr xmlSchematronParse(xmlSchematronParserCtxtPtr ctxt);
	[CLink] public static extern void xmlSchematronFree(xmlSchematronPtr schema);
	/*
	* Interfaces for validating
	*/
	[CLink] public static extern void xmlSchematronSetValidStructuredErrors(xmlSchematronValidCtxtPtr ctxt, xmlStructuredErrorFunc serror, void* ctx);
	/******
	[CLink] public static extern void xmlSchematronSetValidErrors(xmlSchematronValidCtxtPtr ctxt, xmlSchematronValidityErrorFunc err, xmlSchematronValidityWarningFunc warn, void* ctx);
	[CLink] public static extern int xmlSchematronGetValidErrors(xmlSchematronValidCtxtPtr ctxt, xmlSchematronValidityErrorFunc* err, xmlSchematronValidityWarningFunc* warn, void* *ctx);
	[CLink] public static extern int xmlSchematronSetValidOptions(xmlSchematronValidCtxtPtr ctxt, c_int options);
	[CLink] public static extern int xmlSchematronValidCtxtGetOptions(xmlSchematronValidCtxtPtr ctxt);
	[CLink] public static extern int xmlSchematronValidateOneElement (xmlSchematronValidCtxtPtr ctxt, xmlNodePtr elem);
	*******/

	[CLink] public static extern xmlSchematronValidCtxtPtr xmlSchematronNewValidCtxt(xmlSchematronPtr schema, c_int options);
	[CLink] public static extern void xmlSchematronFreeValidCtxt(xmlSchematronValidCtxtPtr ctxt);
	[CLink] public static extern int xmlSchematronValidateDoc(xmlSchematronValidCtxtPtr ctxt, xmlDocPtr instance);
}

#endif /* LIBXML_SCHEMATRON_ENABLED */ 