/*
 * Summary: unfinished XLink detection module
 * Description: unfinished XLink detection module
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_XPTR_ENABLED

extension libxml2
{

	/**
	 * Various defines for the various Link properties.
	 *
	 * NOTE: the link detection layer will try to resolve QName expansion
	 *       of namespaces. If "foo" is the prefix for "http://foo.com/"
	 *       then the link detection layer will expand role="foo:myrole"
	 *       to "http://foo.com/:myrole".
	 * NOTE: the link detection layer will expand URI-References found on
	 *       href attributes by using the base mechanism if found.
	 */
	typealias xlinkHRef = xmlChar*;
	typealias xlinkRole = xmlChar*;
	typealias xlinkTitle = xmlChar*;

	public enum xlinkType : c_int
	{
		XLINK_TYPE_NONE = 0,
		XLINK_TYPE_SIMPLE,
		XLINK_TYPE_EXTENDED,
		XLINK_TYPE_EXTENDED_SET
	}

	public enum xlinkShow : c_int
	{
		XLINK_SHOW_NONE = 0,
		XLINK_SHOW_NEW,
		XLINK_SHOW_EMBED,
		XLINK_SHOW_REPLACE
	}

	public enum xlinkActuate : c_int
	{
		XLINK_ACTUATE_NONE = 0,
		XLINK_ACTUATE_AUTO,
		XLINK_ACTUATE_ONREQUEST
	}

	/**
	 * xlinkNodeDetectFunc:
	 * @ctx:  user data pointer
	 * @node:  the node to check
	 *
	 * This is the prototype for the link detection routine.
	 * It calls the default link detection callbacks upon link detection.
	 */
	public function void xlinkNodeDetectFunc(void* ctx, xmlNodePtr node);

	/*
	 * The link detection module interact with the upper layers using
	 * a set of callback registered at parsing time.
	 */

	/**
	 * xlinkSimpleLinkFunk:
	 * @ctx:  user data pointer
	 * @node:  the node carrying the link
	 * @href:  the target of the link
	 * @role:  the role string
	 * @title:  the link title
	 *
	 * This is the prototype for a simple link detection callback.
	 */
	public function void xlinkSimpleLinkFunk(void* ctx, xmlNodePtr node, xlinkHRef href, xlinkRole role, xlinkTitle title);

	/**
	 * xlinkExtendedLinkFunk:
	 * @ctx:  user data pointer
	 * @node:  the node carrying the link
	 * @nbLocators: the number of locators detected on the link
	 * @hrefs:  pointer to the array of locator hrefs
	 * @roles:  pointer to the array of locator roles
	 * @nbArcs: the number of arcs detected on the link
	 * @from:  pointer to the array of source roles found on the arcs
	 * @to:  pointer to the array of target roles found on the arcs
	 * @show:  array of values for the show attributes found on the arcs
	 * @actuate:  array of values for the actuate attributes found on the arcs
	 * @nbTitles: the number of titles detected on the link
	 * @title:  array of titles detected on the link
	 * @langs:  array of xml:lang values for the titles
	 *
	 * This is the prototype for a extended link detection callback.
	 */
	public function void xlinkExtendedLinkFunk(void* ctx, xmlNodePtr node, c_int nbLocators, xlinkHRef* hrefs, xlinkRole* roles, c_int nbArcs, xlinkRole* from, xlinkRole* to, xlinkShow* show, xlinkActuate* actuate, c_int nbTitles, xlinkTitle* titles, xmlChar** langs);

	/**
	 * xlinkExtendedLinkSetFunk:
	 * @ctx:  user data pointer
	 * @node:  the node carrying the link
	 * @nbLocators: the number of locators detected on the link
	 * @hrefs:  pointer to the array of locator hrefs
	 * @roles:  pointer to the array of locator roles
	 * @nbTitles: the number of titles detected on the link
	 * @title:  array of titles detected on the link
	 * @langs:  array of xml:lang values for the titles
	 *
	 * This is the prototype for a extended link set detection callback.
	 */
	public function void xlinkExtendedLinkSetFunk(void* ctx, xmlNodePtr node, c_int nbLocators, xlinkHRef* hrefs, xlinkRole* roles, c_int nbTitles, xlinkTitle* titles, xmlChar** langs);

	/**
	 * This is the structure containing a set of Links detection callbacks.
	 *
	 * There is no default xlink callbacks, if one want to get link
	 * recognition activated, those call backs must be provided before parsing.
	 */
	typealias xlinkHandlerPtr = xlinkHandler*;

	[CRepr]
	public struct xlinkHandler
	{
		xlinkSimpleLinkFunk simple;
		xlinkExtendedLinkFunk extended;
		xlinkExtendedLinkSetFunk set;
	}

	/*
	 * The default detection routine, can be overridden, they call the default
	 * detection callbacks.
	 */

	[CLink, Obsolete("")] public static extern xlinkNodeDetectFunc xlinkGetDefaultDetect();

	[CLink, Obsolete("")] public static extern void xlinkSetDefaultDetect(xlinkNodeDetectFunc func);

	/*
	 * Routines to set/get the default handlers.
	 */

	[CLink, Obsolete("")] public static extern xlinkHandlerPtr xlinkGetDefaultHandler();

	[CLink, Obsolete("")] public static extern void xlinkSetDefaultHandler(xlinkHandlerPtr handler);

	/*
	 * Link detection module itself.
	 */
	[CLink] public static extern xlinkType xlinkIsLink(xmlDocPtr doc, xmlNodePtr node);
}

#endif /* LIBXML_XPTR_ENABLED */ 

