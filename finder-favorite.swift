// Puts a folder in Finder's sidebar Favourites. It replaces the favourite with
// the same name in place, or adds the folder at the end when no name matches.
// Usage: swift finder-favorite.swift <folder>
//
// ponytail: LSSharedFileList is deprecated since macOS 10.11, but it still works
// on macOS 27. If Apple removes it, this file stops compiling. Then set the
// favourite by hand.
// Do not use kLSSharedFileListItemBeforeFirst or kLSSharedFileListItemLast.
// They are the fake pointers 0x1 and 0x2, and Swift crashes when it retains them.
// The script inserts after a real item instead.
import CoreServices
import Foundation

let url = URL(fileURLWithPath: CommandLine.arguments[1]).resolvingSymlinksInPath()
let list = LSSharedFileListCreate(nil, kLSSharedFileListFavoriteItems.takeUnretainedValue(), nil)!.takeRetainedValue()
let items = LSSharedFileListCopySnapshot(list, nil)!.takeRetainedValue() as! [LSSharedFileListItem]
let flags = UInt32(kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes)

guard let last = items.last else {
    print("Finder has no favourites. Add \(url.path) to the sidebar by hand.")
    exit(1)
}
let match = items.first {
    LSSharedFileListItemCopyDisplayName($0).takeRetainedValue() as String == url.lastPathComponent
}
if let match {
    let current = LSSharedFileListItemCopyResolvedURL(match, flags, nil)?.takeRetainedValue() as URL?
    if current?.resolvingSymlinksInPath().path == url.path { exit(0) }
}
LSSharedFileListInsertItemURL(list, match ?? last, nil, nil, url as CFURL, nil, nil)
if let match { LSSharedFileListItemRemove(list, match) }
