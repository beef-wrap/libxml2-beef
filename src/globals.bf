/*
 * Summary: interface for all global variables of the library
 * Description: Deprecated, don't use
 *
 * Copy: See Copyright for the status of this software.
 */

using System;

namespace libxml2;

extension libxml2
{
	/*
	 * This file was required to access global variables until version v2.12.0.
	 *
	 * These includes are for backward compatibility.
	 */
	public struct xmlGlobalState;

	typealias xmlGlobalStatePtr = xmlGlobalState*;

	[CLink, Obsolete("")] public static extern void xmlInitializeGlobalState(xmlGlobalStatePtr gs);
	[CLink, Obsolete("")] public static extern xmlGlobalStatePtr xmlGetGlobalState(void);
}