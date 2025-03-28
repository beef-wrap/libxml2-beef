/*
 * Summary: Provide Canonical XML and Exclusive XML Canonicalization
 * Description: the c14n modules provides a
 *
 * "Canonical XML" implementation
 * http://www.w3.org/TR/xml-c14n
 *
 * and an
 *
 * "Exclusive XML Canonicalization" implementation
 * http://www.w3.org/TR/xml-exc-c14n

 * Copy: See Copyright for the status of this software.
 *
 * Author: Aleksey Sanin <aleksey@aleksey.com>
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_C14N_ENABLED

extension libxml2
{
	/*
	 * XML Canonicalization
	 * http://www.w3.org/TR/xml-c14n
	 *
	 * Exclusive XML Canonicalization
	 * http://www.w3.org/TR/xml-exc-c14n
	 *
	 * Canonical form of an XML document could be created if and only if
	 *  a) default attributes (if any) are added to all nodes
	 *  b) all character and parsed entity references are resolved
	 * In order to achieve this in libxml2 the document MUST be loaded with
	 * following options: XML_PARSE_DTDATTR | XML_PARSE_NOENT
	 */

	/*
	* xmlC14NMode:
	*
	* Predefined values for C14N modes
	*
	*/
	public enum xmlC14NMode : c_int
	{
		XML_C14N_1_0            = 0, /* Original C14N 1.0 spec */
		XML_C14N_EXCLUSIVE_1_0  = 1, /* Exclusive C14N 1.0 spec */
		XML_C14N_1_1            = 2 /* C14N 1.1 spec */
	}

	[CLink] public static extern c_int xmlC14NDocSaveTo(xmlDocPtr doc, xmlNodeSetPtr nodes, c_int mode, xmlChar** inclusive_ns_prefixes, c_int with_comments, xmlOutputBufferPtr buf);

	[CLink] public static extern c_int xmlC14NDocDumpMemory(xmlDocPtr doc, xmlNodeSetPtr nodes, c_int mode, xmlChar** inclusive_ns_prefixes, c_int with_comments, xmlChar** doc_txt_ptr);

	[CLink] public static extern c_int xmlC14NDocSave(xmlDocPtr doc, xmlNodeSetPtr nodes, c_int mode, xmlChar** inclusive_ns_prefixes, c_int with_comments, char* filename, c_int compression);


	/**
	 * This is the core C14N function
	 */
	/**
	 * xmlC14NIsVisibleCallback:
	 * @user_data: user data
	 * @node: the current node
	 * @parent: the parent node
	 *
	 * Signature for a C14N callback on visible nodes
	 *
	 * Returns 1 if the node should be included
	 */
	public function c_int xmlC14NIsVisibleCallback(void* user_data, xmlNodePtr node, xmlNodePtr parent);

	[CLink] public static extern c_int xmlC14NExecute(xmlDocPtr doc, xmlC14NIsVisibleCallback is_visible_callback, void* user_data, c_int mode, xmlChar** inclusive_ns_prefixes, c_int with_comments, xmlOutputBufferPtr buf);

#endif /* LIBXML_C14N_ENABLED */ 
}