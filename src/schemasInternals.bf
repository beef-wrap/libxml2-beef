/*
 * Summary: internal interfaces for XML Schemas
 * Description: internal interfaces for the XML Schemas handling
 *              and schema validity checking
 *		The Schemas development is a Work In Progress.
 *              Some of those interfaces are not guaranteed to be API or ABI stable !
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
	public enum xmlSchemaValType : c_int
	{
		XML_SCHEMAS_UNKNOWN = 0,
		XML_SCHEMAS_STRING = 1,
		XML_SCHEMAS_NORMSTRING = 2,
		XML_SCHEMAS_DECIMAL = 3,
		XML_SCHEMAS_TIME = 4,
		XML_SCHEMAS_GDAY = 5,
		XML_SCHEMAS_GMONTH = 6,
		XML_SCHEMAS_GMONTHDAY = 7,
		XML_SCHEMAS_GYEAR = 8,
		XML_SCHEMAS_GYEARMONTH = 9,
		XML_SCHEMAS_DATE = 10,
		XML_SCHEMAS_DATETIME = 11,
		XML_SCHEMAS_DURATION = 12,
		XML_SCHEMAS_FLOAT = 13,
		XML_SCHEMAS_DOUBLE = 14,
		XML_SCHEMAS_BOOLEAN = 15,
		XML_SCHEMAS_TOKEN = 16,
		XML_SCHEMAS_LANGUAGE = 17,
		XML_SCHEMAS_NMTOKEN = 18,
		XML_SCHEMAS_NMTOKENS = 19,
		XML_SCHEMAS_NAME = 20,
		XML_SCHEMAS_QNAME = 21,
		XML_SCHEMAS_NCNAME = 22,
		XML_SCHEMAS_ID = 23,
		XML_SCHEMAS_IDREF = 24,
		XML_SCHEMAS_IDREFS = 25,
		XML_SCHEMAS_ENTITY = 26,
		XML_SCHEMAS_ENTITIES = 27,
		XML_SCHEMAS_NOTATION = 28,
		XML_SCHEMAS_ANYURI = 29,
		XML_SCHEMAS_INTEGER = 30,
		XML_SCHEMAS_NPINTEGER = 31,
		XML_SCHEMAS_NINTEGER = 32,
		XML_SCHEMAS_NNINTEGER = 33,
		XML_SCHEMAS_PINTEGER = 34,
		XML_SCHEMAS_INT = 35,
		XML_SCHEMAS_UINT = 36,
		XML_SCHEMAS_LONG = 37,
		XML_SCHEMAS_ULONG = 38,
		XML_SCHEMAS_SHORT = 39,
		XML_SCHEMAS_USHORT = 40,
		XML_SCHEMAS_BYTE = 41,
		XML_SCHEMAS_UBYTE = 42,
		XML_SCHEMAS_HEXBINARY = 43,
		XML_SCHEMAS_BASE64BINARY = 44,
		XML_SCHEMAS_ANYTYPE = 45,
		XML_SCHEMAS_ANYSIMPLETYPE = 46
	}

	/*
	 * XML Schemas defines multiple type of types.
	 */
	public enum xmlSchemaTypeType : c_int
	{
		XML_SCHEMA_TYPE_BASIC = 1, /* A built-in datatype */
		XML_SCHEMA_TYPE_ANY,
		XML_SCHEMA_TYPE_FACET,
		XML_SCHEMA_TYPE_SIMPLE,
		XML_SCHEMA_TYPE_COMPLEX,
		XML_SCHEMA_TYPE_SEQUENCE = 6,
		XML_SCHEMA_TYPE_CHOICE,
		XML_SCHEMA_TYPE_ALL,
		XML_SCHEMA_TYPE_SIMPLE_CONTENT,
		XML_SCHEMA_TYPE_COMPLEX_CONTENT,
		XML_SCHEMA_TYPE_UR,
		XML_SCHEMA_TYPE_RESTRICTION,
		XML_SCHEMA_TYPE_EXTENSION,
		XML_SCHEMA_TYPE_ELEMENT,
		XML_SCHEMA_TYPE_ATTRIBUTE,
		XML_SCHEMA_TYPE_ATTRIBUTEGROUP,
		XML_SCHEMA_TYPE_GROUP,
		XML_SCHEMA_TYPE_NOTATION,
		XML_SCHEMA_TYPE_LIST,
		XML_SCHEMA_TYPE_UNION,
		XML_SCHEMA_TYPE_ANY_ATTRIBUTE,
		XML_SCHEMA_TYPE_IDC_UNIQUE,
		XML_SCHEMA_TYPE_IDC_KEY,
		XML_SCHEMA_TYPE_IDC_KEYREF,
		XML_SCHEMA_TYPE_PARTICLE = 25,
		XML_SCHEMA_TYPE_ATTRIBUTE_USE,
		XML_SCHEMA_FACET_MININCLUSIVE = 1000,
		XML_SCHEMA_FACET_MINEXCLUSIVE,
		XML_SCHEMA_FACET_MAXINCLUSIVE,
		XML_SCHEMA_FACET_MAXEXCLUSIVE,
		XML_SCHEMA_FACET_TOTALDIGITS,
		XML_SCHEMA_FACET_FRACTIONDIGITS,
		XML_SCHEMA_FACET_PATTERN,
		XML_SCHEMA_FACET_ENUMERATION,
		XML_SCHEMA_FACET_WHITESPACE,
		XML_SCHEMA_FACET_LENGTH,
		XML_SCHEMA_FACET_MAXLENGTH,
		XML_SCHEMA_FACET_MINLENGTH,
		XML_SCHEMA_EXTRA_QNAMEREF = 2000,
		XML_SCHEMA_EXTRA_ATTR_USE_PROHIB
	}

	public enum xmlSchemaContentType : c_int
	{
		XML_SCHEMA_CONTENT_UNKNOWN = 0,
		XML_SCHEMA_CONTENT_EMPTY = 1,
		XML_SCHEMA_CONTENT_ELEMENTS,
		XML_SCHEMA_CONTENT_MIXED,
		XML_SCHEMA_CONTENT_SIMPLE,
		XML_SCHEMA_CONTENT_MIXED_OR_ELEMENTS, /* Obsolete */
		XML_SCHEMA_CONTENT_BASIC,
		XML_SCHEMA_CONTENT_ANY
	}

	public struct xmlSchemaVal;
	typealias xmlSchemaValPtr = xmlSchemaVal*;

	typealias xmlSchemaTypePtr = xmlSchemaType*;

	typealias xmlSchemaFacetPtr = xmlSchemaFacet*;

/**
 * Annotation
 */
	typealias xmlSchemaAnnotPtr = xmlSchemaAnnot*;

	[CRepr]
	public struct xmlSchemaAnnot
	{
		xmlSchemaAnnot* next;
		xmlNodePtr content; /* the annotation */
	}

	/**
	 * XML_SCHEMAS_ANYATTR_SKIP:
	 *
	 * Skip unknown attribute from validation
	 * Obsolete, not used anymore.
	 */
	const c_int XML_SCHEMAS_ANYATTR_SKIP        = 1;
	/**
	 * XML_SCHEMAS_ANYATTR_LAX:
	 *
	 * Ignore validation non definition on attributes
	 * Obsolete, not used anymore.
	 */
	const c_int XML_SCHEMAS_ANYATTR_LAX                = 2;
	/**
	 * XML_SCHEMAS_ANYATTR_STRICT:
	 *
	 * Apply strict validation rules on attributes
	 * Obsolete, not used anymore.
	 */
	const c_int XML_SCHEMAS_ANYATTR_STRICT        = 3;
	/**
	 * XML_SCHEMAS_ANY_SKIP:
	 *
	 * Skip unknown attribute from validation
	 */
	const c_int XML_SCHEMAS_ANY_SKIP        = 1;
	/**
	 * XML_SCHEMAS_ANY_LAX:
	 *
	 * Used by wildcards.
	 * Validate if type found, don't worry if not found
	 */
	const c_int XML_SCHEMAS_ANY_LAX                = 2;
	/**
	 * XML_SCHEMAS_ANY_STRICT:
	 *
	 * Used by wildcards.
	 * Apply strict validation rules
	 */
	const c_int XML_SCHEMAS_ANY_STRICT        = 3;
	/**
	 * XML_SCHEMAS_ATTR_USE_PROHIBITED:
	 *
	 * Used by wildcards.
	 * The attribute is prohibited.
	 */
	const c_int XML_SCHEMAS_ATTR_USE_PROHIBITED = 0;
	/**
	 * XML_SCHEMAS_ATTR_USE_REQUIRED:
	 *
	 * The attribute is required.
	 */
	const c_int XML_SCHEMAS_ATTR_USE_REQUIRED = 1;
	/**
	 * XML_SCHEMAS_ATTR_USE_OPTIONAL:
	 *
	 * The attribute is optional.
	 */
	const c_int XML_SCHEMAS_ATTR_USE_OPTIONAL = 2;
	/**
	 * XML_SCHEMAS_ATTR_GLOBAL:
	 *
	 * allow elements in no namespace
	 */
	const c_int XML_SCHEMAS_ATTR_GLOBAL        = 1 << 0;
	/**
	 * XML_SCHEMAS_ATTR_NSDEFAULT:
	 *
	 * allow elements in no namespace
	 */
	const c_int XML_SCHEMAS_ATTR_NSDEFAULT        = 1 << 7;
	/**
	 * XML_SCHEMAS_ATTR_INTERNAL_RESOLVED:
	 *
	 * this is set when the "type" and "ref" references
	 * have been resolved.
	 */
	const c_int XML_SCHEMAS_ATTR_INTERNAL_RESOLVED        = 1 << 8;
	/**
	 * XML_SCHEMAS_ATTR_FIXED:
	 *
	 * the attribute has a fixed value
	 */
	const c_int XML_SCHEMAS_ATTR_FIXED        = 1 << 9;

	/**
	 * xmlSchemaAttribute:
	 * An attribute definition.
	 */
	typealias xmlSchemaAttributePtr = xmlSchemaAttribute*;

	[CRepr]
	public struct xmlSchemaAttribute
	{
		xmlSchemaTypeType type;
		xmlSchemaAttribute* next; /* the next attribute (not used?) */
		xmlChar* name; /* the name of the declaration */
		xmlChar* id; /* Deprecated; not used */
		xmlChar* ref_; /* Deprecated; not used */
		xmlChar* refNs; /* Deprecated; not used */
		xmlChar* typeName; /* the local name of the type definition */
		xmlChar* typeNs; /* the ns URI of the type definition */
		xmlSchemaAnnotPtr annot;

		xmlSchemaTypePtr base_; /* Deprecated; not used */
		c_int occurs; /* Deprecated; not used */
		xmlChar* defValue; /* The initial value of the value constraint */
		xmlSchemaTypePtr subtypes; /* the type definition */
		xmlNodePtr node;
		xmlChar* targetNamespace;
		c_int flags;
		xmlChar* refPrefix; /* Deprecated; not used */
		xmlSchemaValPtr defVal; /* The compiled value constraint */
		xmlSchemaAttributePtr refDecl; /* Deprecated; not used */
	}

	/**
	 * xmlSchemaAttributeLink:
	 * Used to build a list of attribute uses on complexType definitions.
	 * WARNING: Deprecated; not used.
	 */
	typealias xmlSchemaAttributeLinkPtr = xmlSchemaAttributeLink*;

	[CRepr]
	public struct xmlSchemaAttributeLink
	{
		xmlSchemaAttributeLink* next; /* the next attribute link ... */
		xmlSchemaAttribute* attr; /* the linked attribute */
	}

	/**
	 * XML_SCHEMAS_WILDCARD_COMPLETE:
	 *
	 * If the wildcard is complete.
	 */
	const c_int XML_SCHEMAS_WILDCARD_COMPLETE = 1 << 0;

	/**
	 * xmlSchemaCharValueLink:
	 * Used to build a list of namespaces on wildcards.
	 */
	typealias xmlSchemaWildcardNsPtr = xmlSchemaWildcardNs*;

	[CRepr]
	public struct xmlSchemaWildcardNs
	{
		xmlSchemaWildcardNs* next; /* the next constraint link ... */
		xmlChar* value; /* the value */
	}

	/**
	 * xmlSchemaWildcard.
	 * A wildcard.
	 */
	typealias xmlSchemaWildcardPtr = xmlSchemaWildcard*;

	[CRepr]
	public struct xmlSchemaWildcard
	{
		xmlSchemaTypeType type; /* The kind of type */
		xmlChar* id; /* Deprecated; not used */
		xmlSchemaAnnotPtr annot;
		xmlNodePtr node;
		c_int minOccurs; /* Deprecated; not used */
		c_int maxOccurs; /* Deprecated; not used */
		c_int processContents;
		c_int any; /* Indicates if the ns constraint is of ##any */
		xmlSchemaWildcardNsPtr nsSet; /* The list of allowed namespaces */
		xmlSchemaWildcardNsPtr negNsSet; /* The negated namespace */
		c_int flags;
	}

	/**
	 * XML_SCHEMAS_ATTRGROUP_WILDCARD_BUILDED:
	 *
	 * The attribute wildcard has been built.
	 */
	const c_int XML_SCHEMAS_ATTRGROUP_WILDCARD_BUILDED = 1 << 0;
	/**
	 * XML_SCHEMAS_ATTRGROUP_GLOBAL:
	 *
	 * The attribute group has been defined.
	 */
	const c_int XML_SCHEMAS_ATTRGROUP_GLOBAL = 1 << 1;
	/**
	 * XML_SCHEMAS_ATTRGROUP_MARKED:
	 *
	 * Marks the attr group as marked; used for circular checks.
	 */
	const c_int XML_SCHEMAS_ATTRGROUP_MARKED = 1 << 2;

	/**
	 * XML_SCHEMAS_ATTRGROUP_REDEFINED:
	 *
	 * The attr group was redefined.
	 */
	const c_int XML_SCHEMAS_ATTRGROUP_REDEFINED = 1 << 3;
	/**
	 * XML_SCHEMAS_ATTRGROUP_HAS_REFS:
	 *
	 * Whether this attr. group contains attr. group references.
	 */
	const c_int XML_SCHEMAS_ATTRGROUP_HAS_REFS = 1 << 4;

	/**
	 * An attribute group definition.
	 *
	 * xmlSchemaAttribute and xmlSchemaAttributeGroup start of structures
	 * must be kept similar
	 */
	typealias xmlSchemaAttributeGroupPtr = xmlSchemaAttributeGroup*;

	[CRepr]
	public struct xmlSchemaAttributeGroup
	{
		xmlSchemaTypeType type; /* The kind of type */
		xmlSchemaAttribute* next; /* the next attribute if in a group ... */
		xmlChar* name;
		xmlChar* id;
		xmlChar* ref_; /* Deprecated; not used */
		xmlChar* refNs; /* Deprecated; not used */
		xmlSchemaAnnotPtr annot;

		xmlSchemaAttributePtr attributes; /* Deprecated; not used */
		xmlNodePtr node;
		c_int flags;
		xmlSchemaWildcardPtr attributeWildcard;
		xmlChar* refPrefix; /* Deprecated; not used */
		xmlSchemaAttributeGroupPtr refItem; /* Deprecated; not used */
		xmlChar* targetNamespace;
		void* attrUses;
	}

	/**
	 * xmlSchemaTypeLink:
	 * Used to build a list of types (e.g. member types of
	 * simpleType with variety "union").
	 */
	typealias xmlSchemaTypeLinkPtr = xmlSchemaTypeLink*;

	[CRepr]
	public struct xmlSchemaTypeLink
	{
		xmlSchemaTypeLink* next; /* the next type link ... */
		xmlSchemaTypePtr type; /* the linked type */
	}

	/**
	 * xmlSchemaFacetLink:
	 * Used to build a list of facets.
	 */
	typealias xmlSchemaFacetLinkPtr = xmlSchemaFacetLink*;

	[CRepr]
	public struct xmlSchemaFacetLink
	{
		xmlSchemaFacetLink* next; /* the next facet link ... */
		xmlSchemaFacetPtr facet; /* the linked facet */
	}

	/**
	 * XML_SCHEMAS_TYPE_MIXED:
	 *
	 * the element content type is mixed
	 */
	const c_int XML_SCHEMAS_TYPE_MIXED                = 1 << 0;
	/**
	 * XML_SCHEMAS_TYPE_DERIVATION_METHOD_EXTENSION:
	 *
	 * the simple or complex type has a derivation method of "extension".
	 */
	const c_int XML_SCHEMAS_TYPE_DERIVATION_METHOD_EXTENSION                = 1 << 1;
	/**
	 * XML_SCHEMAS_TYPE_DERIVATION_METHOD_RESTRICTION:
	 *
	 * the simple or complex type has a derivation method of "restriction".
	 */
	const c_int XML_SCHEMAS_TYPE_DERIVATION_METHOD_RESTRICTION                = 1 << 2;
	/**
	 * XML_SCHEMAS_TYPE_GLOBAL:
	 *
	 * the type is global
	 */
	const c_int XML_SCHEMAS_TYPE_GLOBAL                = 1 << 3;
	/**
	 * XML_SCHEMAS_TYPE_OWNED_ATTR_WILDCARD:
	 *
	 * the complexType owns an attribute wildcard, i.e.
	 * it can be freed by the complexType
	 */
	const c_int XML_SCHEMAS_TYPE_OWNED_ATTR_WILDCARD    = 1 << 4; /* Obsolete. */
	/**
	 * XML_SCHEMAS_TYPE_VARIETY_ABSENT:
	 *
	 * the simpleType has a variety of "absent".
	 * TODO: Actually not necessary :-/, since if
	 * none of the variety flags occur then it's
	 * automatically absent.
	 */
	const c_int XML_SCHEMAS_TYPE_VARIETY_ABSENT    = 1 << 5;
	/**
	 * XML_SCHEMAS_TYPE_VARIETY_LIST:
	 *
	 * the simpleType has a variety of "list".
	 */
	const c_int XML_SCHEMAS_TYPE_VARIETY_LIST    = 1 << 6;
	/**
	 * XML_SCHEMAS_TYPE_VARIETY_UNION:
	 *
	 * the simpleType has a variety of "union".
	 */
	const c_int XML_SCHEMAS_TYPE_VARIETY_UNION    = 1 << 7;
	/**
	 * XML_SCHEMAS_TYPE_VARIETY_ATOMIC:
	 *
	 * the simpleType has a variety of "union".
	 */
	const c_int XML_SCHEMAS_TYPE_VARIETY_ATOMIC    = 1 << 8;
	/**
	 * XML_SCHEMAS_TYPE_FINAL_EXTENSION:
	 *
	 * the complexType has a final of "extension".
	 */
	const c_int XML_SCHEMAS_TYPE_FINAL_EXTENSION    = 1 << 9;
	/**
	 * XML_SCHEMAS_TYPE_FINAL_RESTRICTION:
	 *
	 * the simpleType/complexType has a final of "restriction".
	 */
	const c_int XML_SCHEMAS_TYPE_FINAL_RESTRICTION    = 1 << 10;
	/**
	 * XML_SCHEMAS_TYPE_FINAL_LIST:
	 *
	 * the simpleType has a final of "list".
	 */
	const c_int XML_SCHEMAS_TYPE_FINAL_LIST    = 1 << 11;
	/**
	 * XML_SCHEMAS_TYPE_FINAL_UNION:
	 *
	 * the simpleType has a final of "union".
	 */
	const c_int XML_SCHEMAS_TYPE_FINAL_UNION    = 1 << 12;
	/**
	 * XML_SCHEMAS_TYPE_FINAL_DEFAULT:
	 *
	 * the simpleType has a final of "default".
	 */
	const c_int XML_SCHEMAS_TYPE_FINAL_DEFAULT    = 1 << 13;
	/**
	 * XML_SCHEMAS_TYPE_BUILTIN_PRIMITIVE:
	 *
	 * Marks the item as a builtin primitive.
	 */
	const c_int XML_SCHEMAS_TYPE_BUILTIN_PRIMITIVE    = 1 << 14;
	/**
	 * XML_SCHEMAS_TYPE_MARKED:
	 *
	 * Marks the item as marked; used for circular checks.
	 */
	const c_int XML_SCHEMAS_TYPE_MARKED        = 1 << 16;
	/**
	 * XML_SCHEMAS_TYPE_BLOCK_DEFAULT:
	 *
	 * the complexType did not specify 'block' so use the default of the
	 * <schema> item.
	 */
	const c_int XML_SCHEMAS_TYPE_BLOCK_DEFAULT    = 1 << 17;
	/**
	 * XML_SCHEMAS_TYPE_BLOCK_EXTENSION:
	 *
	 * the complexType has a 'block' of "extension".
	 */
	const c_int XML_SCHEMAS_TYPE_BLOCK_EXTENSION    = 1 << 18;
	/**
	 * XML_SCHEMAS_TYPE_BLOCK_RESTRICTION:
	 *
	 * the complexType has a 'block' of "restriction".
	 */
	const c_int XML_SCHEMAS_TYPE_BLOCK_RESTRICTION    = 1 << 19;
	/**
	 * XML_SCHEMAS_TYPE_ABSTRACT:
	 *
	 * the simple/complexType is abstract.
	 */
	const c_int XML_SCHEMAS_TYPE_ABSTRACT    = 1 << 20;
	/**
	 * XML_SCHEMAS_TYPE_FACETSNEEDVALUE:
	 *
	 * indicates if the facets need a computed value
	 */
	const c_int XML_SCHEMAS_TYPE_FACETSNEEDVALUE    = 1 << 21;
	/**
	 * XML_SCHEMAS_TYPE_INTERNAL_RESOLVED:
	 *
	 * indicates that the type was typefixed
	 */
	const c_int XML_SCHEMAS_TYPE_INTERNAL_RESOLVED    = 1 << 22;
	/**
	 * XML_SCHEMAS_TYPE_INTERNAL_INVALID:
	 *
	 * indicates that the type is invalid
	 */
	const c_int XML_SCHEMAS_TYPE_INTERNAL_INVALID    = 1 << 23;
	/**
	 * XML_SCHEMAS_TYPE_WHITESPACE_PRESERVE:
	 *
	 * a whitespace-facet value of "preserve"
	 */
	const c_int XML_SCHEMAS_TYPE_WHITESPACE_PRESERVE    = 1 << 24;
	/**
	 * XML_SCHEMAS_TYPE_WHITESPACE_REPLACE:
	 *
	 * a whitespace-facet value of "replace"
	 */
	const c_int XML_SCHEMAS_TYPE_WHITESPACE_REPLACE    = 1 << 25;
	/**
	 * XML_SCHEMAS_TYPE_WHITESPACE_COLLAPSE:
	 *
	 * a whitespace-facet value of "collapse"
	 */
	const c_int XML_SCHEMAS_TYPE_WHITESPACE_COLLAPSE    = 1 << 26;
	/**
	 * XML_SCHEMAS_TYPE_HAS_FACETS:
	 *
	 * has facets
	 */
	const c_int XML_SCHEMAS_TYPE_HAS_FACETS    = 1 << 27;
	/**
	 * XML_SCHEMAS_TYPE_NORMVALUENEEDED:
	 *
	 * indicates if the facets (pattern) need a normalized value
	 */
	const c_int XML_SCHEMAS_TYPE_NORMVALUENEEDED    = 1 << 28;

	/**
	 * XML_SCHEMAS_TYPE_FIXUP_1:
	 *
	 * First stage of fixup was done.
	 */
	const c_int XML_SCHEMAS_TYPE_FIXUP_1    = 1 << 29;

	/**
	 * XML_SCHEMAS_TYPE_REDEFINED:
	 *
	 * The type was redefined.
	 */
	const c_int XML_SCHEMAS_TYPE_REDEFINED    = 1 << 30;
	/**
	 * XML_SCHEMAS_TYPE_REDEFINING:
	 *
	 * The type redefines an other type.
	 */
	/* #define XML_SCHEMAS_TYPE_REDEFINING    1 << 31 */

	/**
	 * _xmlSchemaType:
	 *
	 * Schemas type definition.
	 */
	[CRepr]
	public struct xmlSchemaType
	{
		xmlSchemaTypeType type; /* The kind of type */
		xmlSchemaType* next; /* the next type if in a sequence ... */
		xmlChar* name;
		xmlChar* id; /* Deprecated; not used */
		xmlChar* ref_; /* Deprecated; not used */
		xmlChar* refNs; /* Deprecated; not used */
		xmlSchemaAnnotPtr annot;
		xmlSchemaTypePtr subtypes;
		xmlSchemaAttributePtr attributes; /* Deprecated; not used */
		xmlNodePtr node;
		c_int minOccurs; /* Deprecated; not used */
		c_int maxOccurs; /* Deprecated; not used */

		c_int flags;
		xmlSchemaContentType contentType;
		xmlChar* base_; /* Base type's local name */
		xmlChar* baseNs; /* Base type's target namespace */
		xmlSchemaTypePtr baseType; /* The base type component */
		xmlSchemaFacetPtr facets; /* Local facets */
		xmlSchemaType* redef; /* Deprecated; not used */
		c_int recurse; /* Obsolete */
		xmlSchemaAttributeLinkPtr* attributeUses; /* Deprecated; not used */
		xmlSchemaWildcardPtr attributeWildcard;
		c_int builtInType; /* Type of built-in types. */
		xmlSchemaTypeLinkPtr memberTypes; /* member-types if a union type. */
		xmlSchemaFacetLinkPtr facetSet; /* All facets (incl. inherited) */
		xmlChar* refPrefix; /* Deprecated; not used */
		xmlSchemaTypePtr contentTypeDef; /* Used for the simple content of complex types.
											Could we use @subtypes for this? */
		xmlRegexpPtr contModel; /* Holds the automaton of the content model */
		xmlChar* targetNamespace;
		void* attrUses;
	}

	/*
	 * xmlSchemaElement:
	 * An element definition.
	 *
	 * xmlSchemaType, xmlSchemaFacet and xmlSchemaElement start of
	 * structures must be kept similar
	 */
	/**
	 * XML_SCHEMAS_ELEM_NILLABLE:
	 *
	 * the element is nillable
	 */
	const c_int XML_SCHEMAS_ELEM_NILLABLE        = 1 << 0;
	/**
	 * XML_SCHEMAS_ELEM_GLOBAL:
	 *
	 * the element is global
	 */
	const c_int XML_SCHEMAS_ELEM_GLOBAL                = 1 << 1;
	/**
	 * XML_SCHEMAS_ELEM_DEFAULT:
	 *
	 * the element has a default value
	 */
	const c_int XML_SCHEMAS_ELEM_DEFAULT        = 1 << 2;
	/**
	 * XML_SCHEMAS_ELEM_FIXED:
	 *
	 * the element has a fixed value
	 */
	const c_int XML_SCHEMAS_ELEM_FIXED                = 1 << 3;
	/**
	 * XML_SCHEMAS_ELEM_ABSTRACT:
	 *
	 * the element is abstract
	 */
	const c_int XML_SCHEMAS_ELEM_ABSTRACT        = 1 << 4;
	/**
	 * XML_SCHEMAS_ELEM_TOPLEVEL:
	 *
	 * the element is top level
	 * obsolete: use XML_SCHEMAS_ELEM_GLOBAL instead
	 */
	const c_int XML_SCHEMAS_ELEM_TOPLEVEL        = 1 << 5;
	/**
	 * XML_SCHEMAS_ELEM_REF:
	 *
	 * the element is a reference to a type
	 */
	const c_int XML_SCHEMAS_ELEM_REF                = 1 << 6;
	/**
	 * XML_SCHEMAS_ELEM_NSDEFAULT:
	 *
	 * allow elements in no namespace
	 * Obsolete, not used anymore.
	 */
	const c_int XML_SCHEMAS_ELEM_NSDEFAULT        = 1 << 7;
	/**
	 * XML_SCHEMAS_ELEM_INTERNAL_RESOLVED:
	 *
	 * this is set when "type", "ref", "substitutionGroup"
	 * references have been resolved.
	 */
	const c_int XML_SCHEMAS_ELEM_INTERNAL_RESOLVED        = 1 << 8;
	 /**
	 * XML_SCHEMAS_ELEM_CIRCULAR:
	 *
	 * a helper flag for the search of circular references.
	 */
	const c_int XML_SCHEMAS_ELEM_CIRCULAR        = 1 << 9;
	/**
	 * XML_SCHEMAS_ELEM_BLOCK_ABSENT:
	 *
	 * the "block" attribute is absent
	 */
	const c_int XML_SCHEMAS_ELEM_BLOCK_ABSENT        = 1 << 10;
	/**
	 * XML_SCHEMAS_ELEM_BLOCK_EXTENSION:
	 *
	 * disallowed substitutions are absent
	 */
	const c_int XML_SCHEMAS_ELEM_BLOCK_EXTENSION        = 1 << 11;
	/**
	 * XML_SCHEMAS_ELEM_BLOCK_RESTRICTION:
	 *
	 * disallowed substitutions: "restriction"
	 */
	const c_int XML_SCHEMAS_ELEM_BLOCK_RESTRICTION        = 1 << 12;
	/**
	 * XML_SCHEMAS_ELEM_BLOCK_SUBSTITUTION:
	 *
	 * disallowed substitutions: "substitution"
	 */
	const c_int XML_SCHEMAS_ELEM_BLOCK_SUBSTITUTION        = 1 << 13;
	/**
	 * XML_SCHEMAS_ELEM_FINAL_ABSENT:
	 *
	 * substitution group exclusions are absent
	 */
	const c_int XML_SCHEMAS_ELEM_FINAL_ABSENT        = 1 << 14;
	/**
	 * XML_SCHEMAS_ELEM_FINAL_EXTENSION:
	 *
	 * substitution group exclusions: "extension"
	 */
	const c_int XML_SCHEMAS_ELEM_FINAL_EXTENSION        = 1 << 15;
	/**
	 * XML_SCHEMAS_ELEM_FINAL_RESTRICTION:
	 *
	 * substitution group exclusions: "restriction"
	 */
	const c_int XML_SCHEMAS_ELEM_FINAL_RESTRICTION        = 1 << 16;
	/**
	 * XML_SCHEMAS_ELEM_SUBST_GROUP_HEAD:
	 *
	 * the declaration is a substitution group head
	 */
	const c_int XML_SCHEMAS_ELEM_SUBST_GROUP_HEAD        = 1 << 17;
	/**
	 * XML_SCHEMAS_ELEM_INTERNAL_CHECKED:
	 *
	 * this is set when the elem decl has been checked against
	 * all constraints
	 */
	const c_int XML_SCHEMAS_ELEM_INTERNAL_CHECKED        = 1 << 18;

	typealias xmlSchemaElementPtr = xmlSchemaElement*;

	[CRepr]
	public struct xmlSchemaElement
	{
		xmlSchemaTypeType type; /* The kind of type */
		xmlSchemaType* next; /* Not used? */
		xmlChar* name;
		xmlChar* id; /* Deprecated; not used */
		xmlChar* ref_; /* Deprecated; not used */
		xmlChar* refNs; /* Deprecated; not used */
		xmlSchemaAnnotPtr annot;
		xmlSchemaTypePtr subtypes; /* the type definition */
		xmlSchemaAttributePtr attributes;
		xmlNodePtr node;
		c_int minOccurs; /* Deprecated; not used */
		c_int maxOccurs; /* Deprecated; not used */

		c_int flags;
		xmlChar* targetNamespace;
		xmlChar* namedType;
		xmlChar* namedTypeNs;
		xmlChar* substGroup;
		xmlChar* substGroupNs;
		xmlChar* scope_;
		xmlChar* value; /* The original value of the value constraint. */
		xmlSchemaElement* refDecl; /* This will now be used for the
											  substitution group affiliation */
		xmlRegexpPtr contModel; /* Obsolete for WXS, maybe used for RelaxNG */
		xmlSchemaContentType contentType;
		xmlChar* refPrefix; /* Deprecated; not used */
		xmlSchemaValPtr defVal; /* The compiled value constraint. */
		void* idcs; /* The identity-constraint defs */
	}

	/*
	 * XML_SCHEMAS_FACET_UNKNOWN:
	 *
	 * unknown facet handling
	 */
	const c_int XML_SCHEMAS_FACET_UNKNOWN        = 0;
	/*
	 * XML_SCHEMAS_FACET_PRESERVE:
	 *
	 * preserve the type of the facet
	 */
	const c_int XML_SCHEMAS_FACET_PRESERVE        = 1;
	/*
	 * XML_SCHEMAS_FACET_REPLACE:
	 *
	 * replace the type of the facet
	 */
	const c_int XML_SCHEMAS_FACET_REPLACE        = 2;
	/*
	 * XML_SCHEMAS_FACET_COLLAPSE:
	 *
	 * collapse the types of the facet
	 */
	const c_int XML_SCHEMAS_FACET_COLLAPSE        = 3;
	/**
	 * A facet definition.
	 */
	[CRepr] public struct xmlSchemaFacet
	{
		xmlSchemaTypeType type; /* The kind of type */
		xmlSchemaFacet* next; /* the next type if in a sequence ... */
		xmlChar* value; /* The original value */
		xmlChar* id; /* Obsolete */
		xmlSchemaAnnotPtr annot;
		xmlNodePtr node;
		c_int fixed_; /* XML_SCHEMAS_FACET_PRESERVE, etc. */
		c_int whitespace;
		xmlSchemaValPtr val; /* The compiled value */
		xmlRegexpPtr    regexp; /* The regex for patterns */
	}

	/**
	 * A notation definition.
	 */
	typealias xmlSchemaNotationPtr = xmlSchemaNotation*;

	[CRepr]
	public struct xmlSchemaNotation
	{
		xmlSchemaTypeType type; /* The kind of type */
		xmlChar* name;
		xmlSchemaAnnotPtr annot;
		xmlChar* identifier;
		xmlChar* targetNamespace;
	}

	/*
	* TODO: Actually all those flags used for the schema should sit
	* on the schema parser context, since they are used only
	* during parsing an XML schema document, and not available
	* on the component level as per spec.
	*/
	/**
	 * XML_SCHEMAS_QUALIF_ELEM:
	 *
	 * Reflects elementFormDefault == qualified in
	 * an XML schema document.
	 */
	const c_int XML_SCHEMAS_QUALIF_ELEM                = 1 << 0;
	/**
	 * XML_SCHEMAS_QUALIF_ATTR:
	 *
	 * Reflects attributeFormDefault == qualified in
	 * an XML schema document.
	 */
	const c_int XML_SCHEMAS_QUALIF_ATTR            = 1 << 1;
	/**
	 * XML_SCHEMAS_FINAL_DEFAULT_EXTENSION:
	 *
	 * the schema has "extension" in the set of finalDefault.
	 */
	const c_int XML_SCHEMAS_FINAL_DEFAULT_EXTENSION        = 1 << 2;
	/**
	 * XML_SCHEMAS_FINAL_DEFAULT_RESTRICTION:
	 *
	 * the schema has "restriction" in the set of finalDefault.
	 */
	const c_int XML_SCHEMAS_FINAL_DEFAULT_RESTRICTION            = 1 << 3;
	/**
	 * XML_SCHEMAS_FINAL_DEFAULT_LIST:
	 *
	 * the schema has "list" in the set of finalDefault.
	 */
	const c_int XML_SCHEMAS_FINAL_DEFAULT_LIST            = 1 << 4;
	/**
	 * XML_SCHEMAS_FINAL_DEFAULT_UNION:
	 *
	 * the schema has "union" in the set of finalDefault.
	 */
	const c_int XML_SCHEMAS_FINAL_DEFAULT_UNION            = 1 << 5;
	/**
	 * XML_SCHEMAS_BLOCK_DEFAULT_EXTENSION:
	 *
	 * the schema has "extension" in the set of blockDefault.
	 */
	const c_int XML_SCHEMAS_BLOCK_DEFAULT_EXTENSION            = 1 << 6;
	/**
	 * XML_SCHEMAS_BLOCK_DEFAULT_RESTRICTION:
	 *
	 * the schema has "restriction" in the set of blockDefault.
	 */
	const c_int XML_SCHEMAS_BLOCK_DEFAULT_RESTRICTION            = 1 << 7;
	/**
	 * XML_SCHEMAS_BLOCK_DEFAULT_SUBSTITUTION:
	 *
	 * the schema has "substitution" in the set of blockDefault.
	 */
	const c_int XML_SCHEMAS_BLOCK_DEFAULT_SUBSTITUTION            = 1 << 8;
	/**
	 * XML_SCHEMAS_INCLUDING_CONVERT_NS:
	 *
	 * the schema is currently including an other schema with
	 * no target namespace.
	 */
	const c_int XML_SCHEMAS_INCLUDING_CONVERT_NS            = 1 << 9;

	/**
	 * _xmlSchema:
	 *
	 * A Schemas definition
	 */
	[CRepr]
	public struct xmlSchema
	{
		xmlChar* name; /* schema name */
		xmlChar* targetNamespace; /* the target namespace */
		xmlChar* version;
		xmlChar* id; /* Obsolete */
		xmlDocPtr doc;
		xmlSchemaAnnotPtr annot;
		c_int flags;

		xmlHashTablePtr typeDecl;
		xmlHashTablePtr attrDecl;
		xmlHashTablePtr attrgrpDecl;
		xmlHashTablePtr elemDecl;
		xmlHashTablePtr notaDecl;

		xmlHashTablePtr schemasImports;

		void* _private; /* unused by the library for users or bindings */
		xmlHashTablePtr groupDecl;
		xmlDictPtr      dict;
		void* includes; /* the includes, this is opaque for now */
		c_int preserve; /* whether to free the document */
		c_int counter; /* used to give anonymous components unique names */
		xmlHashTablePtr idcDef; /* All identity-constraint defs. */
		void* volatiles; /* Obsolete */
	}

	[CLink] public static extern void         xmlSchemaFreeType        (xmlSchemaTypePtr type);
	[CLink] public static extern void         xmlSchemaFreeWildcard(xmlSchemaWildcardPtr wildcard);
}

#endif /* LIBXML_SCHEMAS_ENABLED */ 

