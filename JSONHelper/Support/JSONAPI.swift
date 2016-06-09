//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

//import Foundation
//
///// Structure for holding a response returned by a JSON API server.
//public struct JSONAPIResponse: Deserializable {
//  private(set) public var jsonapi = JSONAPISpecification()
//  private(set) public var links = JSONAPILinks()
//  private(set) public var data: AnyObject? = nil
//  private(set) public var included = [[String : AnyObject]]()
//  private(set) public var errors = [JSONAPIError]()
//  private(set) public var meta = [String : AnyObject]()
//
//  /// The original raw response data, read-only.
//  public let raw: [String : AnyObject]
//
//  public enum Fields: String {
//    case jsonapi, links, data, included, errors, meta
//  }
//
//  public init(dictionary: [String : AnyObject]) throws {
//    try jsonapi <-- dictionary[Fields.jsonapi.rawValue]
//    try links <-- dictionary[Fields.links.rawValue]
//    self.data = dictionary[Fields.data.rawValue]
//    try included <-- dictionary[Fields.included.rawValue]
//    try errors <-- dictionary[Fields.errors.rawValue]
//    try meta <-- dictionary[Fields.meta.rawValue]
//    raw = dictionary
//  }
//
//  public init() {
//    raw = [String : AnyObject]()
//  }
//
//  /// Traverses the response `data` and replaces objects in `relationships` with
//  /// full objects from the `included` section of the response.
//  ///
//  /// This is an expensive operation and should only be used if needed.
//  public mutating func replaceRelationshipsInDataWithIncluded() {
//    if let dataDictionary = data as? [String : AnyObject] {
//      data = processDataDictionary(dataDictionary)
//    } else if let dataArray = data as? [[String : AnyObject]] {
//      var newData = [[String : AnyObject]]()
//      for dataDictionary in dataArray {
//        newData.append(processDataDictionary(dataDictionary))
//      }
//      data = newData
//    }
//  }
//
//  private func processDataDictionary(dataDictionary: [String : AnyObject]) -> [String : AnyObject] {
//    let resourceObject = (try? JSONAPIResourceObject(dictionary: dataDictionary)) ?? JSONAPIResourceObject()
//    var newData = [String : AnyObject]()
//
//    for (key, value) in dataDictionary {
//      newData[key] = value
//    }
//
//    var newRelationships = [String: [String : AnyObject]]()
//    for (relationshipName, relationshipObject) in resourceObject.relationships {
//      var newRelationship = [String : AnyObject]()
//
//      if let links = dataDictionary["relationships"]?[relationshipName]??["links"] {
//        newRelationship["links"] = links
//      }
//
//      if let relationshipDataDictionary = relationshipObject.data as? [String : AnyObject] {
//        newRelationship["data"] = processRelationshipDataDictionary(relationshipDataDictionary)
//      } else if let relationshipDataArray = relationshipObject.data as? [[String : AnyObject]] {
//        var newRelationshipData = [[String : AnyObject]]()
//
//        for relationshipDataDictionary in relationshipDataArray {
//          newRelationshipData.append(processRelationshipDataDictionary(relationshipDataDictionary) ?? relationshipDataDictionary)
//        }
//        newRelationship["data"] = newRelationshipData
//      }
//
//      if let meta = dataDictionary["relationships"]?[relationshipName]??["meta"] {
//        newRelationship["meta"] = meta
//      }
//
//      newRelationships[relationshipName] = newRelationship
//    }
//
//    newData["relationships"] = newRelationships
//
//    return newData
//  }
//
//  private func processRelationshipDataDictionary(relationshipDataDictionary: [String : AnyObject]) -> [String : AnyObject]? {
//    let idKey = JSONAPIResourceObject.BaseFields.id.rawValue
//    let typeKey = JSONAPIResourceObject.BaseFields.type.rawValue
//
//    if let
//      relationshipObjectID = relationshipDataDictionary[idKey] as? String,
//      relationshipObjectType = relationshipDataDictionary[typeKey] as? String,
//      includedObject = getIncludedObjectOfType(relationshipObjectType, withID: relationshipObjectID) {
//      return includedObject
//    }
//    return nil
//  }
//
//  public func getIncludedObjectOfType(type: String, withID id: String) -> [String : AnyObject]? {
//    let idKey = JSONAPIResourceObject.BaseFields.id.rawValue
//    let typeKey = JSONAPIResourceObject.BaseFields.type.rawValue
//
//    for include in included {
//      if ((include[idKey] as? String) == id) && ((include[typeKey] as? String) == type) {
//        return include
//      }
//    }
//    return nil
//  }
//}
//
//public struct JSONAPISpecification: Deserializable {
//  private(set) public var version = "1.0"
//
//  public enum Field: String {
//    case version
//  }
//
//  public init(dictionary: [String : AnyObject]) throws {
//    try version <-- dictionary[Field.version.rawValue]
//  }
//
//  public init() {}
//}
//
///// A JSON API links object. http://jsonapi.org/format/#fetching-pagination
//public struct JSONAPILinks: Deserializable {
//  private(set) public var current: JSONAPILink? = nil
//  private(set) public var about: JSONAPILink? = nil
//  private(set) public var related: JSONAPILink? = nil
//  private(set) public var first: JSONAPILink? = nil
//  private(set) public var last: JSONAPILink? = nil
//  private(set) public var prev: JSONAPILink? = nil
//  private(set) public var next: JSONAPILink? = nil
//
//  public enum Field: String {
//    case current = "self"
//    case about = "about"
//    case related = "related"
//    case first = "first"
//    case last = "last"
//    case prev = "prev"
//    case next = "next"
//  }
//
//  public init(dictionary: [String : AnyObject]) {
//    current = deserializeLink(dictionary[Field.current.rawValue])
//    about = deserializeLink(dictionary[Field.about.rawValue])
//    related = deserializeLink(dictionary[Field.related.rawValue])
//    first = deserializeLink(dictionary[Field.first.rawValue])
//    last = deserializeLink(dictionary[Field.last.rawValue])
//    prev = deserializeLink(dictionary[Field.prev.rawValue])
//    next = deserializeLink(dictionary[Field.next.rawValue])
//  }
//
//  private func deserializeLink(data: AnyObject?) -> JSONAPILink? {
//    do {
//      if let urlString = data as? String {
//        return try JSONAPILink(dictionary: [JSONAPILink.Field.href.rawValue: urlString])
//      }
//      return try JSONAPILink(dictionary: (data as? [String : AnyObject]) ?? [:])
//    } catch {
//      return nil
//    }
//  }
//
//  public init() {}
//}
//
///// A JSON API link object. http://jsonapi.org/format/#document-links
//public struct JSONAPILink: Deserializable {
//  private(set) public var href: NSURL?
//  private(set) public var meta = [String : AnyObject]()
//
//  public enum Field: String {
//    case href, meta
//  }
//
//  public init(dictionary: [String : AnyObject]) throws {
//    try href <-- dictionary[Field.href.rawValue]
//    try meta <-- dictionary[Field.meta.rawValue]
//  }
//}
//
///// A JSON API error object. http://jsonapi.org/format/#errors
//public struct JSONAPIError: Deserializable {
//  private(set) public var id: String?
//  private(set) public var links = JSONAPILinks()
//  private(set) public var status: String?
//  private(set) public var code: String?
//  private(set) public var title: String?
//  private(set) public var detail: String?
//  private(set) public var source = JSONAPIErrorSource()
//  private(set) public var meta = [String : AnyObject]()
//
//  public enum Field: String {
//    case id, links, status, code, title, detail, source, meta
//  }
//
//  public init(dictionary: [String : AnyObject]) throws {
//    try id <-- dictionary[Field.id.rawValue]
//    try links <-- dictionary[Field.links.rawValue]
//    try status <-- dictionary[Field.status.rawValue]
//    try code <-- dictionary[Field.code.rawValue]
//    try title <-- dictionary[Field.title.rawValue]
//    try detail <-- dictionary[Field.detail.rawValue]
//    try source <-- dictionary[Field.source.rawValue]
//    try meta <-- dictionary[Field.meta.rawValue]
//  }
//}
//
///// A JSON API error source object. http://jsonapi.org/format/#errors
//public struct JSONAPIErrorSource: Deserializable {
//  private(set) public var pointer: String?
//  private(set) public var parameter: String?
//
//  public enum Field: String {
//    case pointer, parameter
//  }
//
//  public init(dictionary: [String : AnyObject]) throws {
//    try pointer <-- dictionary[Field.pointer.rawValue]
//    try parameter <-- dictionary[Field.parameter.rawValue]
//  }
//
//  public init() {}
//}
//
///// A JSON API resource object. http://jsonapi.org/format/#document-resource-objects
//public struct JSONAPIResourceObject: Deserializable, Serializable {
//  private(set) public var id: String?
//  private(set) public var type: String?
//  private(set) public var attributes = [String : AnyObject]()
//  private(set) public var relationships = [String: JSONAPIRelationship]()
//  private(set) public var links = JSONAPILinks()
//
//  // FIXME: Rename to Fields if possible.
//  public enum BaseFields: String {
//    case id, type, attributes, relationships, links
//  }
//
//  public init(dictionary: [String : AnyObject]) throws {
//    try id <-- (dictionary[BaseFields.id.rawValue] ?? id)
//    try type <-- (dictionary[BaseFields.type.rawValue] ?? type)
//    try attributes <-- dictionary[BaseFields.attributes.rawValue]
//    try relationships <-- dictionary[BaseFields.relationships.rawValue]
//    try links <-- dictionary[BaseFields.links.rawValue]
//  }
//
//  public init() {}
//
//  public func toDictionary() -> [String : AnyObject] {
//    var dictionary = [String : AnyObject]()
//
//    dictionary[BaseFields.id.rawValue] = id
//    dictionary[BaseFields.type.rawValue] = type
//    dictionary[BaseFields.attributes.rawValue] = attributes
//
//    // TODO: relationships
//
//    // TODO: links
//
//    return dictionary
//  }
//
//  public var description: String {
//    return toDictionary().description
//  }
//}
//
///// A JSON API relationship object. http://jsonapi.org/format/#document-resource-object-relationships
//public struct JSONAPIRelationship: Deserializable {
//  private(set) public var links = JSONAPILinks()
//  private(set) public var data: AnyObject?
//  private(set) public var meta = [String : AnyObject]()
//
//  public enum Field: String {
//    case links, data, meta
//  }
//
//  public init(dictionary: [String : AnyObject]) throws {
//    try links <-- dictionary[Field.links.rawValue]
//    self.data = dictionary[Field.data.rawValue]
//    try meta <-- dictionary[Field.meta.rawValue]
//  }
//}
