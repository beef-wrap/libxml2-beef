/*
 * Summary: macros for marking symbols as exportable/importable.
 * Description: macros for marking symbols as exportable/importable.
 *
 * Copy: See Copyright for the status of this software.
 */

using System;
using System.Interop;

namespace libxml2;

extension libxml2
{
	[CLink] public static extern void xmlCheckVersion(c_int version);
}