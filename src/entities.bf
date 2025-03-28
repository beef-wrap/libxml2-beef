/*
 * Summary: interface for the XML entities handling
 * Description: this module provides some of the entity API needed
 *              for the parser and applications.
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
	/*
	* The different valid entity types.
	*/
	public enum xmlEntityType : c_int
	{
		XML_INTERNAL_GENERAL_ENTITY = 1,
		XML_EXTERNAL_GENERAL_PARSED_ENTITY = 2,
		XML_EXTERNAL_GENERAL_UNPARSED_ENTITY = 3,
		XML_INTERNAL_PARAMETER_ENTITY = 4,
		XML_EXTERNAL_PARAMETER_ENTITY = 5,
		XML_INTERNAL_PREDEFINED_ENTITY = 6
	}

	/*
	* An unit of storage for an entity, contains the string, the value
	* and the linkind data needed for the linking in the hash table.
	*/
	[CRepr]
	public struct xmlEntity
	{
		void* _private; /* application data */
		xmlElementType  type; /* XML_ENTITY_DECL, must be second ! */
		xmlChar* name; /* Entity name */
		xmlNode* children; /* First child link */
		xmlNode* last; /* Last child link */
		xmlDtd* parent; /* -> DTD */
		xmlNode* next; /* next sibling link  */
		xmlNode* prev; /* previous sibling link  */
		xmlDoc* doc; /* the containing document */

		xmlChar* orig; /* content without ref substitution */
		xmlChar* content; /* content or ndata if unparsed */
		c_int length; /* the content length */
		xmlEntityType etype; /* The entity type */
		xmlChar* ExternalID; /* External identifier for PUBLIC */
		xmlChar* SystemID; /* URI for a SYSTEM or PUBLIC Entity */

		xmlEntity* nexte; /* unused */
		xmlChar* URI; /* the full URI as computed */
		c_int owner; /* unused */
		c_int flags; /* various flags */
		c_ulong expandedSize; /* expanded size */
	}

	/*
	* All entities are stored in an hash table.
	* There is 2 separate hash tables for global and parameter entities.
	*/
	public struct xmlEntitiesTable;

	typealias xmlEntitiesTablePtr = xmlEntitiesTable*;

	/*
	* External functions:
	*/

	[CLink] public static extern xmlEntityPtr xmlNewEntity(xmlDocPtr doc, xmlChar* name, c_int type, xmlChar* ExternalID, xmlChar* SystemID, xmlChar* content);
	[CLink] public static extern void xmlFreeEntity(xmlEntityPtr entity);
	[CLink] public static extern int xmlAddEntity(xmlDocPtr doc, c_int extSubset, xmlChar* name, c_int type, xmlChar* ExternalID, xmlChar* SystemID, xmlChar* content, xmlEntityPtr* out_);
	[CLink] public static extern xmlEntityPtr xmlAddDocEntity(xmlDocPtr doc, xmlChar* name, c_int type, xmlChar* ExternalID, xmlChar* SystemID, xmlChar* content);
	[CLink] public static extern xmlEntityPtr xmlAddDtdEntity(xmlDocPtr doc, xmlChar* name, c_int type, xmlChar* ExternalID, xmlChar* SystemID, xmlChar* content);
	[CLink] public static extern xmlEntityPtr xmlGetPredefinedEntity(xmlChar* name);
	[CLink] public static extern xmlEntityPtr xmlGetDocEntity(xmlDoc* doc, xmlChar* name);
	[CLink] public static extern xmlEntityPtr xmlGetDtdEntity(xmlDocPtr doc, xmlChar* name);
	[CLink] public static extern xmlEntityPtr xmlGetParameterEntity(xmlDocPtr doc, xmlChar* name);
	[CLink] public static extern xmlChar* xmlEncodeEntitiesReentran(xmlDocPtr doc, xmlChar* input);
	[CLink] public static extern xmlChar* xmlEncodeSpecialChars(xmlDoc* doc, xmlChar* input);
	[CLink] public static extern xmlEntitiesTablePtr xmlCreateEntitiesTable(void);
	[CLink] public static extern xmlEntitiesTablePtr xmlCopyEntitiesTable(xmlEntitiesTablePtr table);
	[CLink] public static extern void xmlFreeEntitiesTable(xmlEntitiesTablePtr table);

#if LIBXML_OUTPUT_ENABLED
	[CLink] public static extern void xmlDumpEntitiesTable(xmlBufferPtr buf, xmlEntitiesTablePtr table);
	[CLink] public static extern void xmlDumpEntityDecl(xmlBufferPtr buf, xmlEntityPtr ent);
#endif
}