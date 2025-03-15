/**
 * Summary: interfaces to the Catalog handling system
 * Description: the catalog module implements the support for
 * XML Catalogs and SGML catalogs
 *
 * SGML Open Technical Resolution TR9401:1997.
 * http://www.jclark.com/sp/catalog.htm
 *
 * XML Catalogs Working Draft 06 August 2001
 * http://www.oasis-open.org/committees/entity/spec-2001-08-06.html
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_CATALOG_ENABLED

extension libxml2
{
	/**
	 * XML_CATALOGS_NAMESPACE:
	 *
	 * The namespace for the XML Catalogs elements.
	 */
	const xmlChar* XML_CATALOGS_NAMESPACE = (xmlChar*)"urn:oasis:names:tc:entity:xmlns:xml:catalog";
	/**
	 * XML_CATALOG_PI:
	 *
	 * The specific XML Catalog Processing Instruction name.
	 */
	const xmlChar* XML_CATALOG_PI = (xmlChar*)"oasis-xml-catalog";

	/*
	 * The API is voluntarily limited to general cataloging.
	 */
	public enum xmlCatalogPrefer
	{
		XML_CATA_PREFER_NONE = 0,
		XML_CATA_PREFER_PUBLIC = 1,
		XML_CATA_PREFER_SYSTEM
	};

	public enum xmlCatalogAllow
	{
		XML_CATA_ALLOW_NONE = 0,
		XML_CATA_ALLOW_GLOBAL = 1,
		XML_CATA_ALLOW_DOCUMENT = 2,
		XML_CATA_ALLOW_ALL = 3
	};

	public struct xmlCatalog;

	typealias xmlCatalogPtr = xmlCatalog*;

	/*
	 * Operations on a given catalog.
	 */
	[CLink] public static extern xmlCatalogPtr xmlNewCatalog(c_int sgml);
	[CLink] public static extern xmlCatalogPtr xmlLoadACatalog(char* filename);
	[CLink] public static extern xmlCatalogPtr xmlLoadSGMLSuperCatalog(char* filename);
	[CLink] public static extern c_int xmlConvertSGMLCatalog(xmlCatalogPtr catal);
	[CLink] public static extern c_int xmlACatalogAdd(xmlCatalogPtr catal, xmlChar* type, xmlChar* orig, xmlChar* replace);
	[CLink] public static extern c_int xmlACatalogRemove(xmlCatalogPtr catal, xmlChar* value);
	[CLink] public static extern xmlChar* xmlACatalogResolve(xmlCatalogPtr catal, xmlChar* pubID, xmlChar* sysID);
	[CLink] public static extern xmlChar* xmlACatalogResolveSystem(xmlCatalogPtr catal, xmlChar* sysID);
	[CLink] public static extern xmlChar* xmlACatalogResolvePublic(xmlCatalogPtr catal, xmlChar* pubID);
	[CLink] public static extern xmlChar* xmlACatalogResolveURI(xmlCatalogPtr catal, xmlChar* URI);
#if LIBXML_OUTPUT_ENABLED
	[CLink] public static extern void xmlACatalogDump(xmlCatalogPtr catal, FILE* out_);
#endif
	[CLink] public static extern void xmlFreeCatalog(xmlCatalogPtr catal);
	[CLink] public static extern c_int xmlCatalogIsEmpty(xmlCatalogPtr catal);

	/*
	 * Global operations.
	 */
	[CLink] public static extern void xmlInitializeCatalog(void);
	[CLink] public static extern c_int xmlLoadCatalog(char* filename);
	[CLink] public static extern void xmlLoadCatalogs(char* paths);
	[CLink] public static extern void xmlCatalogCleanup(void);

#if LIBXML_OUTPUT_ENABLED
	[CLink] public static extern void xmlCatalogDump(FILE* out_);
#endif

	[CLink] public static extern xmlChar* xmlCatalogResolve(xmlChar* pubID, xmlChar* sysID);
	[CLink] public static extern xmlChar* xmlCatalogResolveSystem(xmlChar* sysID);
	[CLink] public static extern xmlChar* xmlCatalogResolvePublic(xmlChar* pubID);
	[CLink] public static extern xmlChar* xmlCatalogResolveURI(xmlChar* URI);
	[CLink] public static extern c_int xmlCatalogAdd(xmlChar* type, xmlChar* orig, xmlChar* replace);
	[CLink] public static extern c_int xmlCatalogRemove(xmlChar* value);
	[CLink] public static extern xmlDocPtr xmlParseCatalogFile(char* filename);
	[CLink] public static extern c_int xmlCatalogConvert(void);

	/*
	 * Strictly minimal interfaces for per-document catalogs used
	 * by the parser.
	 */
	[CLink] public static extern void xmlCatalogFreeLocal(void* catalogs);
	[CLink] public static extern void*  xmlCatalogAddLocal(void* catalogs, xmlChar* URL);
	[CLink] public static extern xmlChar* xmlCatalogLocalResolve(void* catalogs, xmlChar* pubID, xmlChar* sysID);
	[CLink] public static extern xmlChar* xmlCatalogLocalResolveURI(void* catalogs, xmlChar* URI);
	/*
	 * Preference settings.
	 */
	[CLink] public static extern c_int xmlCatalogSetDebug(c_int level);
	[CLink] public static extern xmlCatalogPrefer xmlCatalogSetDefaultPrefer(xmlCatalogPrefer prefer);
	[CLink] public static extern void xmlCatalogSetDefaults(xmlCatalogAllow allow);
	[CLink] public static extern xmlCatalogAllow xmlCatalogGetDefaults(void);

	/* DEPRECATED interfaces */
	[CLink] public static extern xmlChar* xmlCatalogGetSystem(xmlChar* sysID);
	[CLink] public static extern xmlChar* xmlCatalogGetPublic(xmlChar* pubID);
}

#endif /* LIBXML_CATALOG_ENABLED */ 