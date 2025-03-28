/*
 * Summary: implementation of XML Schema Datatypes
 * Description: module providing the XML Schema Datatypes implementation
 *              both definition and validity checking
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
	public enum xmlSchemaWhitespaceValueType : c_int
	{
		XML_SCHEMA_WHITESPACE_UNKNOWN = 0,
		XML_SCHEMA_WHITESPACE_PRESERVE = 1,
		XML_SCHEMA_WHITESPACE_REPLACE = 2,
		XML_SCHEMA_WHITESPACE_COLLAPSE = 3
	}

	[CLink] public static extern int xmlSchemaInitTypes(void);

	[CLink, Obsolete("")] public static extern void xmlSchemaCleanupTypes(void);

	[CLink] public static extern xmlSchemaTypePtr xmlSchemaGetPredefinedType(xmlChar* name, xmlChar* ns);
	[CLink] public static extern int xmlSchemaValidatePredefinedType(xmlSchemaTypePtr type, xmlChar* value, xmlSchemaValPtr* val);
	[CLink] public static extern int xmlSchemaValPredefTypeNode(xmlSchemaTypePtr type, xmlChar* value, xmlSchemaValPtr* val, xmlNodePtr node);
	[CLink] public static extern int xmlSchemaValidateFacet(xmlSchemaTypePtr base_, xmlSchemaFacetPtr facet, xmlChar* value, xmlSchemaValPtr val);
	[CLink] public static extern int xmlSchemaValidateFacetWhtsp(xmlSchemaFacetPtr facet, xmlSchemaWhitespaceValueType fws, xmlSchemaValType valType, xmlChar* value, xmlSchemaValPtr val, xmlSchemaWhitespaceValueType ws);
	[CLink] public static extern void xmlSchemaFreeValue(xmlSchemaValPtr val);
	[CLink] public static extern xmlSchemaFacetPtr xmlSchemaNewFacet(void);
	[CLink] public static extern int xmlSchemaCheckFacet(xmlSchemaFacetPtr facet, xmlSchemaTypePtr typeDecl, xmlSchemaParserCtxtPtr ctxt, xmlChar* name);
	[CLink] public static extern void xmlSchemaFreeFacet(xmlSchemaFacetPtr facet);
	[CLink] public static extern int xmlSchemaCompareValues(xmlSchemaValPtr x, xmlSchemaValPtr y);
	[CLink] public static extern xmlSchemaTypePtr xmlSchemaGetBuiltInListSimpleTypeItemType(xmlSchemaTypePtr type);
	[CLink] public static extern int xmlSchemaValidateListSimpleTypeFacet(xmlSchemaFacetPtr facet, xmlChar* value, c_ulong actualLen, c_ulong* expectedLen);
	[CLink] public static extern xmlSchemaTypePtr xmlSchemaGetBuiltInType(xmlSchemaValType type);
	[CLink] public static extern int xmlSchemaIsBuiltInTypeFacet(xmlSchemaTypePtr type, c_int facetType);
	[CLink] public static extern xmlChar* xmlSchemaCollapseString(xmlChar* value);
	[CLink] public static extern xmlChar* xmlSchemaWhiteSpaceReplace(xmlChar* value);
	[CLink] public static extern c_ulong  xmlSchemaGetFacetValueAsULong(xmlSchemaFacetPtr facet);
	[CLink] public static extern int xmlSchemaValidateLengthFacet(xmlSchemaTypePtr type, xmlSchemaFacetPtr facet, xmlChar* value, xmlSchemaValPtr val, c_ulong* length);
	[CLink] public static extern int xmlSchemaValidateLengthFacetWhtsp(xmlSchemaFacetPtr facet,  xmlSchemaValType valType,  xmlChar* value,  xmlSchemaValPtr val,  c_ulong* length,  xmlSchemaWhitespaceValueType ws);
	[CLink] public static extern int xmlSchemaValPredefTypeNodeNoNorm(xmlSchemaTypePtr type, xmlChar* value, xmlSchemaValPtr* val, xmlNodePtr node);
	[CLink] public static extern int xmlSchemaGetCanonValue(xmlSchemaValPtr val, xmlChar** retValue);
	[CLink] public static extern int xmlSchemaGetCanonValueWhtsp(xmlSchemaValPtr val, xmlChar** retValue, xmlSchemaWhitespaceValueType ws);
	[CLink] public static extern int xmlSchemaValueAppend(xmlSchemaValPtr prev, xmlSchemaValPtr cur);
	[CLink] public static extern xmlSchemaValPtr xmlSchemaValueGetNext(xmlSchemaValPtr cur);
	[CLink] public static extern xmlChar* xmlSchemaValueGetAsString(xmlSchemaValPtr val);
	[CLink] public static extern int xmlSchemaValueGetAsBoolean(xmlSchemaValPtr val);
	[CLink] public static extern xmlSchemaValPtr xmlSchemaNewStringValue(xmlSchemaValType type, xmlChar* value);
	[CLink] public static extern xmlSchemaValPtr xmlSchemaNewNOTATIONValue(xmlChar* name, xmlChar* ns);
	[CLink] public static extern xmlSchemaValPtr xmlSchemaNewQNameValue(xmlChar* namespaceName, xmlChar* localName);
	[CLink] public static extern int xmlSchemaCompareValuesWhtsp(xmlSchemaValPtr x, xmlSchemaWhitespaceValueType xws, xmlSchemaValPtr y, xmlSchemaWhitespaceValueType yws);
	[CLink] public static extern xmlSchemaValPtr xmlSchemaCopyValue(xmlSchemaValPtr val);
	[CLink] public static extern xmlSchemaValType xmlSchemaGetValType(xmlSchemaValPtr val);
}

#endif /* LIBXML_SCHEMAS_ENABLED */ 

